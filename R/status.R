#' Check the status of a Lagotto API
#' 
#' @export
#' @param api_url (character) API endpoint, defaults to http://alm.plos.org/api/v5/articles
#' @template curl
#' @examples \dontrun{
#' res <- status()
#' res$meta
#' res$status
#' head(res$status$agents)
#' }
status <- function(api_url = 'https://eventdata.datacite.org', ...) {	
  almGET(file.path(api_url, "api/status"), ...)
}
