#' Retrieve PLoS article-level metrics (ALM) by source.
#'
#' See details for more information.
#' 
#' @importFrom plyr round_any
#' @export 
#' @param source (character) Name of source (or list of sources) to get ALM information for. Can be
#'    one or more sources in a vector or list.
#' @param info One of totals, summary, or detail (default totals + sum_metrics data in a list). 
#'   	Not specifying anything (the default) returns data.frame of totals across 
#' 		data providers. (character)
#' @param key your PLoS API key, either enter, or loads from .Rprofile (character)
#' @param total_details If FALSE (the default) the standard totals data.frame is
#'    returned; if TRUE, the totals data is in a wide format with more details
#'    about the paper, including publication date, title, etc. If you set this 
#'    to TRUE, the output should no longer with with \code{\link{almplot}}.
#' @param sum_metrics Just like the output you get from setting info='totals', you can 
#'    get summary metrics by day (sum_metrics='day'), month (sum_metrics='month'), 
#'    or year (sum_metrics='year').
#' @param url API endpoint, defaults to http://alm.plos.org/api/v3/articles (character)
#' @param ... optional additional curl options (debugging tools mostly)
#' @references See a tutorial/vignette for alm at 
#' \url{http://ropensci.org/tutorials/alm_tutorial.html}
#' @examples \dontrun{
#' alm_source(source='mendeley')
#' alm_source(source='scopus', info='summary')
#' alm_source(source=c('mendeley','twitter'))
#' alm_source(source='mendeley', limit=2)
#' alm_source(source='mendeley', limit=200)
#' 
#' alm_source(source='mendeley', info='summary')
#' }

alm_source <- function(source = 'crossref', info = "totals", key = NULL, total_details = FALSE, 
  sum_metrics = NULL, limit=50, page=1, url = 'http://alm.plos.org/api/v5/articles', ...)
{	
  key <- getkey(key)
  info <- match.arg(info, c("summary","totals","detail"))
  source <- match.arg(source, several.ok = TRUE, 
                      choices = c("bloglines","citeulike","connotea","crossref","nature",
                                  "postgenomic","pubmed","scopus","plos","researchblogging",
                                  "biod","webofscience","pmc","facebook","mendeley","twitter",
                                  "wikipedia","scienceseeker","relativemetric","f1000","figshare"))
  source <- paste(source, collapse = ",")
  
  getalm <- function() {
    info2 <- switch(info, totals=NULL, detail='detail', summary='summary')
    if(!is.null(sum_metrics)) info <- info2 <- 'detail' 
    args <- almcompact(list(api_key = key, info = info2, source = source))
  
    if(limit <= 50){
      tt <- alm_GET(url, c(args, rows=limit, page=page), ...)
    } else
    {
      pages <- 1 : (round_any(limit, 50, f = ceiling)/50)
      temp <- lapply(pages, function(k) alm_GET(x = url, y = c(args, page=k, rows=50), ...))
      tt <- do.call(c, lapply(temp, "[[", "data"))
      remove <- (length(pages)*50)-limit
      tt <- if(!remove==0) tt[-c(((length(tt)-remove)+1):length(tt))] else tt
    }
    
    if(info=="summary"){ 
      tmpdetails <- if(limit <= 50) lapply(tt$data, get_details) else lapply(tt, get_details)
      tmpsposts <- if(limit <= 50) lapply(tt$data, get_signpost) else lapply(tt, get_signpost)
      details <- ldply(tmpdetails, data.frame)
      sposts <- ldply(tmpsposts, data.frame)
      return( list(meta=metadf(tt), details=details, signposts=sposts) )
    } else {		
      rep <- if(limit <= 50) tt$data else tt
      restmp <- lapply(rep, getdata, y=info, z=total_details, w=sum_metrics)
      restmp <- do.call(rbind, restmp)
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
  } else { data.frame(doi=x$doi, ldply(totals2, function(x) as.data.frame(x))) }
}

# get_details(data_)
# get_signpost(data_)
get_details <- function(x){
  date_parts <- x$issued$`date-parts`[[1]]
  date_parts[[2]] <- if(nchar(date_parts[[2]]) == 1) paste0("0", date_parts[[2]])
  date_parts <- paste(date_parts, collapse = "-")
  tmp <- x[ !names(x) %in% c('sources','issued','viewed','saved','discussed','cited') ]
  tmp[vapply(tmp, is.null, logical(1))] <- NA
  data.frame(tmp, date=date_parts, stringsAsFactors = FALSE)
}

get_signpost <- function(x){
  tmp <- x[ names(x) %in% c('doi','viewed','saved','discussed','cited') ]
  tmp[vapply(tmp, is.null, logical(1))] <- NA
  data.frame(tmp, stringsAsFactors = FALSE)
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

