#' Work types
#' 
#' @export
#' @param id A work type id, required
#' @param api_url (character) API endpoint, defaults to http://alm.plos.org/api/v5/articles
#' @template curl
#' @examples \dontrun{
#' res <- work_types()
#' res$meta
#' res$work_types
#' 
#' work_type("speech")
#' }
work_types <- function(api_url = 'https://eventdata.datacite.org', ...) {	
  alm_GET(file.path(api_url, "api/work_types"), list(), ...)
}

#' @export
#' @rdname work_types
work_type <- function(id, api_url = 'https://eventdata.datacite.org', ...) {	
  alm_GET(file.path(api_url, "api/work_types", id), list(), ...)
}
