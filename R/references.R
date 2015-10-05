#' References
#' 
#' @export
#' @param doi (character) A DOI. Required.
#' @param api_url (character) API endpoint, defaults to http://alm.plos.org/api/v5/articles
#' @param ... Curl options (debugging tools mostly) passed on to \code{\link[httr]{GET}}
#' @examples \dontrun{
#' res <- references("10.1371/journal.pone.0017342")
#' res$meta
#' res$references
#' }
references <- function(doi, api_url = 'http://alm.plos.org', ...) {	
  almGET(file.path(api_url, "api/works", doi, "references"), ...)
}
