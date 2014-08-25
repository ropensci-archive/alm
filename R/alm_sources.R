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
#'    to TRUE, the output should no longer with with \code{\link{alm_plot}}.
#' @param sum_metrics Just like the output you get from setting info='totals', you can
#'    get summary metrics by day (sum_metrics='day'), month (sum_metrics='month'),
#'    or year (sum_metrics='year').
#' @param limit (integer) Number from 1 to infinity. This doubles as the rows parameter, which is
#'    what's called internally to the API service. The max results per page is 50, so if you use a
#'    value > 50, then we essentially loop through to get all the results you want.
#' @param page (integer) Number from 1 to infinity.
#' @param url API endpoint, defaults to http://alm.plos.org/api/v3/articles (character)
#' @param ... optional additional curl options (debugging tools mostly)
#' @references See a tutorial/vignette for alm at
#' \url{http://ropensci.org/tutorials/alm_tutorial.html}
#' @examples \dontrun{
#' alm_sources(source='mendeley')
#' alm_sources(source='scopus', info='summary')
#' alm_sources(source=c('mendeley','twitter'))
#' alm_sources(source='mendeley', limit=2)
#' alm_sources(source='mendeley', limit=200)
#'
#' alm_sources(source='mendeley', info='summary')
#' }

alm_sources <- function(source = 'crossref', info = "totals", key = NULL, total_details = FALSE,
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
