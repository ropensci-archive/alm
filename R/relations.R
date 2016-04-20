#' Relations
#' 
#' @export
#' @param work_id (character) Work ID. optional
#' @param work_ids (character) Work IDs. optional
#' @param q (character) Query for ids. optional
#' @param relation_type_id (character) Relation_type ID. optional
#' @param source_id (character) Source name. optional
#' @param recent (integer) Limit to relations created last x days. optional
#' @param page (numeric) Page number. optional
#' @param per_page (numeric) Results per page, defaults to 1000. optional
#' @param api_url (character) API endpoint, defaults to http://alm.plos.org/api/v5/articles
#' @template curl
#' @examples \dontrun{
#' res <- relations()
#' res$meta
#' head(res$relations)
#' }
relations <- function(work_id = NULL, work_ids = NULL, q = NULL, 
                      relation_type_id = NULL, source_id = NULL, recent = NULL, 
                      page = NULL, per_page = NULL, 
                      api_url = 'https://eventdata.datacite.org', ...) {
  
  args <- args <- almcompact(list(work_id = work_id, work_ids = work_ids, 
                                  relation_type_id = relation_type_id, q = q, 
                                  source_id = source_id, recent = recent,
                                  page = page, per_page = per_page))
  almGET(file.path(api_url, "api/relations"), y = args, ...)
}
