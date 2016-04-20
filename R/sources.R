#' Sources 
#' 
#' @export
#' @param id (character) A source id. required
#' @param api_url (character) API endpoint, defaults to http://alm.plos.org/api/v5/articles
#' @template curl
#' @examples \dontrun{
#' res <- sources()
#' res$meta
#' res$sources
#' 
#' source("crossref_datacite")
#' source("datacite_orcid")
#' 
#' # months data
#' sources_months("crossref_datacite")
#' }
sources <- function(api_url = 'https://eventdata.datacite.org', ...) {
  alm_GET(file.path(api_url, "api/sources"), list(), ...)
}

#' @export
#' @rdname sources
source_ <- function(id, api_url = 'https://eventdata.datacite.org', ...) {
  alm_GET(file.path(api_url, "api/sources", id), list(), ...)
}

#' @export
#' @rdname sources
sources_months <- function(id, api_url = 'https://eventdata.datacite.org', ...) {
  api_url <- file.path(api_url, "api/sources", id, "months")
  almGET(api_url, ...)
}
