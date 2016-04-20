#' Contributors
#' 
#' @export
#' @param id (character) contributor ID. optional
#' @param page (numeric) Page number. optional
#' @param per_page (numeric) Results per page, defaults to 1000. optional
#' @param api_url (character) API endpoint, defaults to http://alm.plos.org/api/v5/articles
#' @template curl
#' @examples \dontrun{
#' res <- contributors()
#' res$meta
#' head(res$contributors)
#' 
#' contributors(per_page = 2)
#' 
#' contributor('https://github.com/golo-lang')
#' }
contributors <- function(page = NULL, per_page = NULL, api_url = 'https://eventdata.datacite.org', ...) {
  args <- args <- almcompact(list(page = page, per_page = per_page))
  alm_GET(file.path(api_url, "api/contributors"), y = args, ...)
}

#' @export
#' @rdname contributors
contributor <- function(id, api_url = 'https://eventdata.datacite.org', ...) {
  alm_GET(file.path(api_url, "api/contributors", id), list(), ...)
}
