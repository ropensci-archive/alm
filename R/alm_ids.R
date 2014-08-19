#' Retrieve PLoS article-level metrics (ALM).
#' 
#' This is the main function to search the PLoS ALM (article-level metrics) API. 
#' See details for more information.
#' 
#' @importFrom stringr str_replace_all str_split
#' @export
#' @template alm_params
#' @template alm_egs
#' @references See a tutorial/vignette for alm at 
#' \url{http://ropensci.org/tutorials/alm_tutorial.html}

alm_ids <- function(doi = NULL, pmid = NULL, pmcid = NULL, mendeley = NULL, info = "totals", 
  source = NULL, key = NULL, total_details = FALSE, sum_metrics = NULL,
	url = 'http://alm.plos.org/api/v5/articles', ...)
{	
	key <- getkey(key)
  info <- match.arg(info, c("summary","totals","detail"))
  source2 <- if(is.null(source)) NULL else paste(source, collapse=",")
  if(!is.null(doi)) doi <- doi[!grepl("image", doi)] # remove any DOIs of images
	id <- almcompact(list(doi=doi, pmid=pmid, pmcid=pmcid, mendeley=mendeley))
	if(length(id)>1) stop("Only supply one of: doi, pmid, pmcid, mdid")
	
	getalm <- function() {
    info2 <- switch(info, totals=NULL, detail='detail', summary='summary')
		if(!is.null(sum_metrics)) info <- info2 <- 'detail' 
		args <- almcompact(list(api_key = key, info = info2, source = source2, type = names(id)))
		if(length(id[[1]])==0){stop("Please provide a DOI or other identifier")} else
			if(length(id[[1]])==1){
				if(names(id) == "doi") id <- gsub("/", "%2F", id)
				tt <- alm_GET(url, c(args, ids = id[[1]]), ...)
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
							tt <- alm_GET(url, c(args, ids = id2), ...)
						}
						temp <- lapply(idsplit, repeatit)
						tt <- do.call(c, temp)
					} else {
					  id2 <- if(names(id) == "doi") { 
					    paste(sapply(id, function(x) gsub("/", "%2F", x)), collapse=",")
					  } else { paste(id[[1]], collapse=",") }
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
			} else { restmp <- getdata(x=tt$data[[1]], y=info, z=total_details, w=sum_metrics) }
      return( list(meta=metadf(tt), data=restmp) )
		}
	}
	
	safe_getalm <- plyr::failwith(NULL, getalm)
	safe_getalm()
}

alm_GET <- function(x, y, ...){
  out <- GET(x, query=y, ...)
  stop_for_status(out)
  tt <- content(out, as = "text")
  jsonlite::fromJSON(tt, FALSE)
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

# get_totals(x=data_)
# get_totals(x=data_, TRUE)
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

# get_details(data_)
# get_signpost(data_)
get_details <- function(x){
  date_parts <- x$issued$`date-parts`[[1]]
  date_parts[[2]] <- if(nchar(date_parts[[2]]) == 1) paste0("0", date_parts[[2]])
  date_parts <- paste(date_parts, collapse = "-")
  tmp <- x[ !names(x) %in% c('sources','issued','viewed','saved','discussed','cited') ]
  data.frame(tmp, date=date_parts, stringsAsFactors = FALSE)
}

get_signpost <- function(x){
  data.frame(x[ names(x) %in% c('doi','viewed','saved','discussed','cited') ], stringsAsFactors = FALSE)
}

# get_sumby(x=data_$sources, y=sum_metrics)
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

