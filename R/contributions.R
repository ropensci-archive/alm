#' Contributions
#' 
#' @export
#' @param contributor_role_id (character) Contributor_role ID. optional
#' @param source_id (character) Source name. optional
#' @param recent (integer) Limit to relations created last x days. optional
#' @param page (numeric) Page number. optional
#' @param per_page (numeric) Results per page, defaults to 1000. optional
#' @param api_url (character) API endpoint, defaults to http://alm.plos.org/api/v5/articles
#' @template curl
#' @examples \dontrun{
#' res <- contributions()
#' res$meta
#' head(res$contributions)
#' }
contributions <- function(contributor_role_id = NULL, source_id = NULL, recent = NULL, 
                      page = NULL, per_page = NULL, api_url = 'https://eventdata.datacite.org', ...) {
  
  args <- args <- almcompact(list(contributor_role_id = contributor_role_id, 
                                  source_id = source_id, recent = recent,
                                  page = page, per_page = per_page))
  almGET(file.path(api_url, "api/contributions"), y = args, ...)
}
