#' Recommendations
#' 
#' @export
#' @param doi (character) A doi. Required.
#' @param api_url (character) API endpoint, defaults to http://alm.plos.org/api/v5/articles
#' @template curl
#' @examples \dontrun{
#' res <- recommendations("http://doi.org/10.1038/NGEO2696")
#' res$meta
#' res$recommendations
#' }
recommendations <- function(doi, api_url = 'https://eventdata.datacite.org', ...) {	
  stop("broken right now", call. = FALSE)
  almGET(file.path(api_url, "api/works", doi, "recommendations"), ...)
}
