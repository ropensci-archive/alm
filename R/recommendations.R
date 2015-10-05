#' Recommendations
#' 
#' @export
#' @param doi (character) A doi. Required.
#' @param api_url (character) API endpoint, defaults to http://alm.plos.org/api/v5/articles
#' @param ... Curl options (debugging tools mostly) passed on to \code{\link[httr]{GET}}
#' @examples \dontrun{
#' res <- recommendations("10.1371/journal.pmed.1001361")
#' res$meta
#' res$recommendations
#' }
recommendations <- function(doi, api_url = 'http://alm.plos.org', ...) {	
  almGET(file.path(api_url, "api/works", doi, "recommendations"), ...)
}
