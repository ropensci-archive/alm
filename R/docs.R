#' Documents
#' 
#' @export
#' @param id (character) A group id. Optional.
#' @param api_url (character) API endpoint, defaults to http://alm.plos.org/api/v5/articles
#' @template curl
#' @examples \dontrun{
#' docs()
#' doc('wos')
#' doc('crossref')
#' }
docs <- function(id = NULL, api_url = 'https://eventdata.datacite.org', ...) {
  alm_GET(file.path(api_url, "api/docs"), list(), ...)
}

#' @export
#' @rdname docs
doc <- function(id = NULL, api_url = 'https://eventdata.datacite.org', ...) {
  alm_GET(file.path(api_url, "api/docs", id), list(), ...)
}
