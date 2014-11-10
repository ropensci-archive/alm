#' Retrieve API requests data.
#'
#' @export
#' @param key API key
#' @param url URL for the api requests endpoint
#' @param ... Curl args to \code{\link[httr]{GET}}
#' @examples \donttest{
#' out <- alm_requests()
#' out$meta
#' dat <- out$data
#' head( dat )
#' dat[ dat$db_duration > 100, ] 
#' }
alm_requests <- function(key = NULL, url = 'http://alm.plos.org/api/v5/api_requests', ...)
{
  res <- GET(url, query=list(api_key=getkey(key)), ...)
  stop_for_status(res)
  out <- jsonlite::fromJSON(content(res, "text"), FALSE)
  mm <- out[!names(out) == "data"]
  mm[sapply(mm, is.null) == TRUE] <- "none"
  meta <- data.frame(mm, stringsAsFactors = FALSE)
  data <- do.call(rbind.fill, lapply(out$data, function(x){
      x[sapply(x, is.null) == TRUE] <- "none"
      data.frame(x, stringsAsFactors = FALSE)
  }))
  list(meta=meta, data=data)
}
