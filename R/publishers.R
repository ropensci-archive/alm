#' Publishers
#' 
#' @export
#' @param id (character) A publisher id. Optional.
#' @param api_url (character) API endpoint, defaults to http://alm.plos.org/api/v5/articles
#' @param ... Curl options (debugging tools mostly) passed on to \code{\link[httr]{GET}}
#' @examples \dontrun{
#' publishers()
#' publishers(340)
#' }
publishers <- function(id = NULL, api_url = 'http://alm.plos.org', ...) {
  api_url <- file.path(api_url, "api/publishers")
  if (!is.null(id)) api_url <- file.path(api_url, id)
  almGET(api_url, ...)
}
