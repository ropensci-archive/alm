#' Publishers
#' 
#' @export
#' @param id (character) A publisher id. required
#' @param api_url (character) API endpoint, defaults to http://alm.plos.org/api/v5/articles
#' @template curl
#' @examples \dontrun{
#' publishers()
#' publisher(340)
#' }
publishers <- function(api_url = 'https://eventdata.datacite.org', ...) {
  alm_GET(file.path(api_url, "api/publishers"), list(), ...)
}

#' @export
#' @rdname publishers
publisher <- function(id, api_url = 'https://eventdata.datacite.org', ...) {
  alm_GET(file.path(api_url, "api/publishers", id), list(), ...)
}
