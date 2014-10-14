#' Retrieve PLoS article-level metrics (ALM).
#'
#' This is the main function to search the PLoS ALM (article-level metrics) API.
#' See details for more information.
#'
#' @importFrom stringr str_replace_all str_split
#' @export
#' @template alm_params
#' @template alm_egs
#' @param sleep Set a sleep time (in seconds). Only used for large calls where you may be in danger
#' of upsetting the server gods, can you say 504 error?
#' @references See a tutorial/vignette for alm at
#' \url{http://ropensci.org/tutorials/alm_tutorial.html}

alm_ids <- function(doi = NULL, pmid = NULL, pmcid = NULL, mendeley_uuid = NULL, info = "totals",
  source = NULL, key = NULL, total_details = FALSE, sum_metrics = NULL, sleep = 0,
	url = 'http://alm.plos.org/api/v5/articles', ...)
{
	key <- getkey(key)
  info <- match.arg(info, c("summary","totals","detail"))
  if(!is.null(doi)) doi <- doi[!grepl("image", doi)] # remove any DOIs of images
	id <- almcompact(list(doi=doi, pmid=pmid, pmcid=pmcid, mendeley_uuid=mendeley_uuid))
	if(length(id) == 0) stop("Supply one of: doi, pmid, pmcid, mendeley_uuid")
	if(length(id) > 1) stop("Only supply one of: doi, pmid, pmcid, mendeley_uuid")
  if(length(source) > 1) stop("You can only supply one source")

	getalm <- function() {
    info2 <- switch(info, totals=NULL, detail='detail', summary='summary')
		if(!is.null(sum_metrics)) info <- info2 <- 'detail'
		args <- almcompact(list(api_key = key, info = info2, source = source, type = names(id)))
		if(length(id[[1]])==0){stop("Please provide a DOI or other identifier")} else
			if(length(id[[1]])==1){
				if(names(id) == "doi") id <- gsub("/", "%2F", id)
				tt <- alm_GET(x = url, y = c(args, ids = id[[1]]), ...)
			} else
			{
				if(length(id[[1]])>1){
					if(length(id[[1]])>50){
						slice <- function(x, n) split(x, as.integer((seq_along(x) - 1) / n))
						idsplit <- slice(id[[1]], 50)
						repeatit <- function(y) {
							if(names(id) == "doi"){
								id2 <- paste(sapply(y, function(x) gsub("/", "%2F", x)), collapse=",")
							} else
							{
								id2 <- paste(id[[1]], collapse=",")
							}
							tt <- alm_GET(url, c(args, ids = id2), sleep=sleep, ...)
						}
						temp <- lapply(idsplit, repeatit)
# 						tt <- do.call(c, temp)
            justdat <- do.call(c, unname(lapply(temp, "[[", "data")))
            tt <- c(temp[[1]][ !names(temp[[1]]) == "data" ], data=list(justdat))
					} else {
					  id2 <- id2 <- concat_ids(id)
						tt <- alm_GET(url, c(args, ids = id2), ...)
					}
				}
			}
		if(info=="summary"){
		  if(length(id[[1]]) > 1){
		    restmp <- lapply(tt$data, getsummary)
        names(restmp) <- vapply(tt$data, function(x) x$doi, character(1))
		  } else { restmp <- getsummary(tt$data[[1]]) }
      list(meta=metadf(tt), data=restmp)
    } else {
			if(length(id[[1]]) > 1){
        restmp <- lapply(tt$data, getdata, y=info, z=total_details, w=sum_metrics)
        names(restmp) <- vapply(tt$data, function(x) x$doi, character(1))
			} else {
        checktt <- tryCatch(tt$data[[1]], error=function(e) e)
        restmp <- if(is(checktt, "simpleError")) list() else getdata(x=tt$data[[1]], y=info, z=total_details, w=sum_metrics)
			}
      return( list(meta=metadf(tt), data=restmp) )
		}
	}

	safe_getalm <- plyr::failwith(NULL, getalm)
	safe_getalm()
}

concat_ids <- function(x){
  if(names(x) == "doi") {
    paste(sapply(x, function(y) gsub("/", "%2F", y)), collapse=",")
  } else { paste(x[[1]], collapse=",") }
}

getdata <- function(x, y, z=FALSE, w=NULL) {
  if(y == "totals"){
    get_totals(x, z)
  } else {
    if(is.null(w)){
      tots <- get_totals(x, z)
      summets <- get_sumby(x$sources, w)
      list(info=get_details(x),
           signposts=get_signpost(x),
           totals=tots,
           sum_metrics=summets)
    } else {
      get_sumby(x$sources, w)
    }
  }
}

getsummary <- function(x) {
  list(info=get_details(x),
       signposts=get_signpost(x))
}

metadf <- function(x){
  tmp <- x[!names(x) == 'data']
  tmp[vapply(tmp, is.null, logical(1))] <- NA
  data.frame(tmp, stringsAsFactors = FALSE)
}

get_totals <- function(x, total_details=FALSE){
  servs <- sapply(x$sources, function(x) x$name)
  totals <- lapply(x$sources, function(x) x$metrics)
  totals2 <- lapply(totals, function(x){
    x[sapply(x, is.null)] <- NA
    x
  })
  names(totals2) <- servs

  if(total_details){
    temp <- data.frame(t(unlist(totals2, use.names=TRUE)))
    names(temp) <- str_replace_all(names(temp), "\\.", "_")
    cbind(data.frame(
      doi=x$doi,
      title=x$title),
      temp, date_modified=x$update_date)
  } else { ldply(totals2, function(x) as.data.frame(x)) }
}

get_details <- function(x){
  date_parts <- x$issued$`date-parts`[[1]]
  date_parts[[2]] <- if(nchar(date_parts[[2]]) == 1) paste0("0", date_parts[[2]]) else date_parts[[2]]
  date_parts <- paste(date_parts, collapse = "-")
  tmp <- x[ !names(x) %in% c('sources','issued','viewed','saved','discussed','cited') ]
  tmp[sapply(tmp, is.null)] <- ""
  data.frame(tmp, issued=date_parts, stringsAsFactors = FALSE)
}

get_signpost <- function(x){
  tmp <- x[ names(x) %in% c('doi','viewed','saved','discussed','cited') ]
  tmp[vapply(tmp, is.null, logical(1))] <- NA
  data.frame(tmp, stringsAsFactors = FALSE)
}

get_sumby <- function(x, y){
  sumby <- paste0("by_", match.arg(y, choices=c("day","month","year")))
  servs <- sapply(x, function(z) z$name)
  totals <- lapply(x, function(z) z[[sumby]])
  totals[sapply(totals,is.null)] <- NA
  totals2 <- lapply(totals, function(z){
    z <- lapply(z, function(w) { w[sapply(w, is.null)] <- NA; w })
    z
  })
  names(totals2) <- servs
  tmp <- ldply(totals2, function(v) ldply(v, as.data.frame))
  if(NROW(tmp) == 0) NULL else tmp
}
