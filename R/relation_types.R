#' Relation types
#' 
#' @export
#' @param x (character) A relation type name. Optional.
#' @param api_url (character) API endpoint, defaults to http://alm.plos.org/api/v5/articles
#' @param ... Curl options (debugging tools mostly) passed on to \code{\link[httr]{GET}}
#' @examples \dontrun{
#' res <- relation_types()
#' res$meta
#' res$relation_types
#' 
#' relation_types("bookmarks")
#' relation_types("discusses")
#' }
relation_types <- function(x = NULL, api_url = 'http://alm.plos.org', ...) {
  api_url <- file.path(api_url, "api/relation_types")
  if (!is.null(x)) api_url <- file.path(api_url, x)
  almGET(api_url, ...)
}
