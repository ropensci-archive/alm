#' Groups
#' 
#' @param id (character) A group id. Optional.
#' @param api_url (character) API endpoint, defaults to http://alm.plos.org/api/v5/articles
#' @template curl
#' @examples \dontrun{
#' groups()
#' group('contributions')
#' group('works')
#' }
groups <- function(api_url = 'https://eventdata.datacite.org', ...) {
  alm_GET(file.path(api_url, "api/groups"), list(), ...)
}

#' @export
#' @rdname groups
group <- function(id, api_url = 'https://eventdata.datacite.org', ...) {
  alm_GET(file.path(api_url, "api/groups", id), list(), ...)
}
