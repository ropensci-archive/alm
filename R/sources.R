#' Sources 
#' 
#' @export
#' @param x (character) A source name. Optional for \code{sources}; required
#' for \code{sources_months}.
#' @param api_url (character) API endpoint, defaults to http://alm.plos.org/api/v5/articles
#' @param ... Curl options (debugging tools mostly) passed on to \code{\link[httr]{GET}}
#' @examples \dontrun{
#' res <- sources()
#' res$meta
#' res$sources
#' 
#' sources("citeulike")
#' sources("crossref")
#' 
#' # months data
#' sources_months("crossref")
#' }
sources <- function(x = NULL, api_url = 'http://alm.plos.org', ...) {
  api_url <- file.path(api_url, "api/sources")
  if (!is.null(x)) api_url <- file.path(api_url, x)
  almGET(api_url, ...)
}

#' @export
#' @rdname sources
sources_months <- function(x, api_url = 'http://alm.plos.org', ...) {
  api_url <- file.path(api_url, "api/sources", x, "months")
  almGET(api_url, ...)
}
