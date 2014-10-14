#' Retrieve alerts data for article-level metrics (ALM).
#'
#' @import httr jsonlite
#' @export
#'
#' @param source (character) Source to limtit alert search to.
#' @param ids (character) Article identifiers
#' @param class_name (character) Which error to get
#' @param level (character) Alert level to limit search to. One of ERROR, WARN, INFO, 
#' or FATAL. Default: all.
#' @param q (character) Query terms
#' @param unresolved (logical) Whether to give back unresolved alerts only.
#' @param per_page (integer) Number of records to return. Default: 50. Max: ?
#' @param page (integer) Number from 1 to number of pages
#' @param user (character) Username
#' @param pwd (character) Password
#' @param url URL to use.
#' @param ... Further args passed to httr::GET
#'
#' @details
#' This function uses the alm.plos.org API by default. You can change which ALM app you use by
#' specifying the url in the url parameter. It will likely be the same as the default
#' http://alm.plos.org/api/v4/alerts, but just the alm.plos.org part will be different.
#'
#' ALM installations on the most current version (3.4.7) can be used in this function, as of
#' 2014-08-26 those are PLOS, ALM Labs, and Crossref Labs.
#'
#' @examples \dontrun{
#' alm_alerts()
#' alm_alerts(q='mismatch')
#' alm_alerts(unresolved=TRUE)
#' alm_alerts(class_name='NoMethodError')
#' alm_alerts(class_name='ApiResponseTooSlowError')
#' alm_alerts(level='Error')
#' alm_alerts(ids="10.1371/journal.pone.0029797")
#'
#' # curl debugging
#' alm_alerts(level='Error', config=verbose())
#'
#' # paging
#' alm_alerts(per_page=2)
#'
#' out <- alm_alerts(level = "error")
#' head(out$data)
#'
#' # Using different ALM apps, e.g, labs.crowdometer.org
#' alm_alerts(url='http://labs.crowdometer.org/api/v4/alerts')
#' }

alm_alerts <- function(source=NULL, ids=NULL, class_name=NULL, level=NULL, q=NULL,
  unresolved=FALSE, per_page=50, page=1, user=NULL, pwd=NULL, url='http://alm.plos.org/api/v4/alerts', ...)
{
  user <- getuserinfo(user, pwd)
  args <- alm_compact(list(q=q,
    source=if(!is.null(source)) paste(source, collapse=",") else NULL,
    class_name=class_name, level=if(!is.null(level)) toupper(level) else NULL,
    unresolved=if(unresolved) 1 else NULL, ids=ids, rows=per_page, page=page))
  furtherargs <- list(...)
  tt <- GET(url,
            query=args,
            config=c(authenticate(user[1], user[2]), furtherargs[['config']]))
  stop_for_status(tt)
  res <- content(tt, as = "text")
  tmp <- jsonlite::fromJSON(res)
  list(meta=data.frame(tmp[names(tmp) %in% c("total","total_pages","page") ], stringsAsFactors = FALSE),
       error=tmp$error,
       data=tmp$data)
}

getuserinfo <- function(x=NULL, y=NULL){
  c(if(is.null(x)) getOption("almv4_user") else x, if(is.null(y)) getOption("almv4_pwd") else y)
}

alm_compact <- function(l) Filter(Negate(is.null), l)
