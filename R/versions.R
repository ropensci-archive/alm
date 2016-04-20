#' Versions
#' 
#' @export
#' @param doi (character) A doi. Required.
#' @param api_url (character) API endpoint, defaults to http://alm.plos.org/api/v5/articles
#' @template curl
#' @examples \dontrun{
#' res <- versions("10.1371/journal.pmed.1001361")
#' res$meta
#' res$versions
#' }
versions <- function(doi, api_url = 'https://eventdata.datacite.org', ...) {	
  almGET(file.path(api_url, "api/works", doi, "versions"), ...)
}
