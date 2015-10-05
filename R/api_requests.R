#' API requests
#' 
#' @export
#' @param key (character) An API key. Required.
#' @param api_url (character) API endpoint, defaults to http://alm.plos.org/api/v5/articles
#' @param ... Curl options (debugging tools mostly) passed on to \code{\link[httr]{GET}}
#' @examples \dontrun{
#' api_requests(getOption("almv4_pwd"))
#' }
api_requests <- function(key, api_url = 'http://alm.plos.org', ...) {
  stop("doesn't work yet", call. = FALSE)
  # almGET(file.path(api_url, "api/api_requests"), key = key, ...)
}
