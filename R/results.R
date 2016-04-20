#' Results
#' 
#' @export
#' @param work_id (character) Work ID. optional
#' @param work_ids (character) Work IDs. optional
#' @param source_id (character) Source name. optional
#' @param sort (character) Sort by result descending, or by update date descending 
#' if left empty. optional
#' @param page (numeric) Page number. optional
#' @param per_page (numeric) Results per page, defaults to 1000. optional
#' @param api_url (character) API endpoint, defaults to http://alm.plos.org/api/v5/articles
#' @template curl
#' @examples \dontrun{
#' res <- results()
#' res$meta
#' head(res$results)
#' }
results <- function(work_id = NULL, work_ids = NULL, source_id = NULL, sort = NULL, 
                    page = NULL, per_page = NULL, 
                    api_url = 'https://eventdata.datacite.org', ...) {
  
  args <- args <- almcompact(list(work_id = work_id, work_ids = work_ids, source_id = source_id, 
                                  sort = sort, page = page, per_page = per_page))
  almGET(file.path(api_url, "api/results"), y = args, ...)
}
