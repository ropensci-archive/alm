#' Groups
#' 
#' @param id (character) A group id. Optional.
#' @param api_url (character) API endpoint, defaults to http://alm.plos.org/api/v5/articles
#' @param ... Curl options (debugging tools mostly) passed on to \code{\link[httr]{GET}}
#' @examples \dontrun{
#' groups()
#' groups('cited')
#' groups('viewed')
#' }
groups <- function(id = NULL, api_url = 'http://alm.plos.org', ...) {
  api_url <- file.path(api_url, "api/groups")
  if (!is.null(id)) api_url <- file.path(api_url, id)
  almGET(api_url, ...)
}
