#' Contributor roles
#' 
#' @export
#' @param id (character) contributor ID. optional
#' @param api_url (character) API endpoint, defaults to http://alm.plos.org/api/v5/articles
#' @template curl
#' @examples \dontrun{
#' res <- contributor_roles()
#' res$meta
#' head(res$contributor_roles)
#' 
#' contributor_role('conceptualization')
#' }
contributor_roles <- function(api_url = 'https://eventdata.datacite.org', ...) {
  alm_GET(file.path(api_url, "api/contributor_roles"), list(), ...)
}

#' @export
#' @rdname contributor_roles
contributor_role <- function(id, api_url = 'https://eventdata.datacite.org', ...) {
  alm_GET(file.path(api_url, "api/contributor_roles", id), list(), ...)
}
