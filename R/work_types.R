#' Work types
#' 
#' @export
#' @param api_url (character) API endpoint, defaults to http://alm.plos.org/api/v5/articles
#' @param ... Curl options (debugging tools mostly) passed on to \code{\link[httr]{GET}}
#' @examples \dontrun{
#' res <- work_types()
#' res$meta
#' res$work_types
#' }
work_types <- function(api_url = 'http://alm.plos.org', ...) {	
  almGET(file.path(api_url, "api/work_types"), ...)
}
