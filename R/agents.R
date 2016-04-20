#' Agents
#' 
#' @export
#' @param id (character) agent ID. optional
#' @param api_url (character) API endpoint, defaults to http://alm.plos.org/api/v5/articles
#' @template curl
#' @examples \dontrun{
#' res <- agents()
#' res$meta
#' head(res$agents)
#' 
#' agents(id = 'plos_fulltext')
#' }
agents <- function(id = NULL, api_url = 'https://eventdata.datacite.org', ...) {
  path <- file.path(api_url, "api/agents")
  if (!is.null(id)) path <- file.path(path, id)
  almGET(path, ...)
}
