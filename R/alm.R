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

alm <- function(doi = NULL, pmid = NULL, pmcid = NULL, mdid = NULL,
  url = 'http://alm.plos.org/api/v3/articles',
	info = "totals", months = NULL, days = NULL, year = NULL, 
	source = NULL, key = NULL, curl = getCurlHandle(), 
  total_details = FALSE, sum_metrics = NULL)
{	
	if(!info %in% c("summary","totals","history","detail")) {
		stop("info must be one of summary, totals, history, or detail")
	}
	if(!is.null(doi))
		doi <- doi[!grepl("image", doi)] # remove any DOIs of images
	id <- almcompact(list(doi=doi, pmid=pmid, pmcid=pmcid, mendeley=mdid))
	
	if(length(id)>1){ stop("Only supply one of: doi, pmid, pmcid, mdid") } else { NULL }
	key <- getkey(key)
	
	if(is.null(source)){source2 <- NULL} else{ source2 <- paste(source,collapse=",") }
	
	getalm <- function() {
		if(info=="totals"){info2 <- NULL} else
			if(info=="history"|info=="detail"){info2 <- "detail"} else
				if(info=="summary"){info2 <- "summary"}
    
    # set info2 to history if sum_metrics is not NULL
		if(!is.null(sum_metrics))
      info <- info2 <- 'history' 
    
		args <- almcompact(list(api_key = key, info = info2, months = months, 
												 days = days, year = year, source = source2, type = names(id)))
		if(length(id[[1]])==0){stop("Please provide a DOI or other identifier")} else
			if(length(id[[1]])==1){
				if(names(id) == "doi") id <- gsub("/", "%2F", id)
				args2 <- c(args, ids = id[[1]])
        out <- GET(url, query=args2)
        stop_for_status(out)
        tt <- content(out)
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
							args2 <- c(args, ids = id2)
							out <- GET(url, query=args2)
							stop_for_status(out)
							tt <- content(out)
						}
						temp <- lapply(idsplit, repeatit)
						tt <- do.call(c, temp)
					} else {
						if(names(id) == "doi") {
							id2 <- paste(sapply(id, function(x) gsub("/", "%2F", x)), collapse=",")
						} else
						{
							id2 <- paste(id[[1]], collapse=",")
						}
						args2 <- c(args, ids = id2)
						out <- GET(url, query=args2)
						stop_for_status(out)
						tt <- content(out)
					}
				}
			}
		if(info=="summary"){tt} else
		{
			getdata <- function(data_, y) {
				if(y == "totals"){
          data_2 <- data_$sources
					servs <- sapply(data_2, function(x) x$name)
          totals <- lapply(data_2, function(x) x$metrics)
          
          totals2 <- lapply(totals, function(x){
            x[sapply(x, is.null)] <- NA
            x
          })
					
          names(totals2) <- servs
          
          if(total_details){
            temp <- data.frame(t(unlist(totals2, use.names=TRUE)))
            names(temp) <- str_replace_all(names(temp), "\\.", "_")
            return( 
              cbind(data.frame(doi=data_$doi, title=data_$title, publication_date=data_$publication_date), 
                    temp, date_modified=data_$update_date)
            )
          } else
          {
            return(ldply(totals2, function(x) as.data.frame(x)))
          }
				} else
				
        if(is.null(sum_metrics)) 
        {
				  data_2 <- data_$sources
					servs <- sapply(data_2, function(x) x$name)
				  totals <- lapply(data_2, function(x) x$metrics)
				  totals2 <- lapply(totals, function(x){
				    x[sapply(x, is.null)] <- NA
				    x
				  })
					names(totals2) <- servs
					totalsdf <- ldply(totals2, function(x) as.data.frame(x))
          
					if(total_details){
					  temp <- data.frame(t(unlist(totals2, use.names=TRUE)))
					  names(temp) <- str_replace_all(names(temp), "\\.", "_")
					  totals3 <- cbind(data.frame(doi=data_$doi, title=data_$title, 
                             publication_date=data_$publication_date), 
                             temp, date_modified=data_$update_date)
					} else
					{
					  totals3 <- totalsdf
					}
					
					hist <- lapply(data_2, function(x) x$histories)
					gethist <- function(y) {
						dates <- sapply(y, function(x) str_split(x[[1]], "T")[[1]][[1]])
						totals <- sapply(y, function(x) x[[2]])
						data.frame(dates=dates, totals=totals)	
					}
					histdfs <- lapply(hist, gethist)
					names(histdfs) <- servs
					historydf <- ldply(histdfs)
					if(y == "history"){ historydf } else
						if(y == "detail"){ list(totals = totals3, history = historydf) } else
							stop("info must be one of history, event or detail")
				} else
				{
				  sumby <- paste0("by_", match.arg(sum_metrics, choices=c("day","month","year")))
          
				  data_2 <- data_$sources
				  servs <- sapply(data_2, function(x) x$name)
				  totals <- lapply(data_2, function(x) x[[sumby]])
				  totals[sapply(totals,is.null)] <- NA
				  totals2 <- lapply(totals, function(x){
				    x <- lapply(x, function(y) { y[sapply(y, is.null)] <- NA; y })
				    x
				  })
				  names(totals2) <- servs
				  totalsdf <- ldply(totals2, function(x) ldply(x, function(x) as.data.frame(x)))
          return(totalsdf)
				}
			}
			if(length(id[[1]])>1){ lapply(tt, getdata, y=info) } else { getdata(data_=tt[[1]], y=info)}
		}
	}
	
	# Define safe version so errors don't prevent getalm from working
	safe_getalm <- plyr::failwith(NULL, getalm)
	
	# Get the data
	safe_getalm()
}