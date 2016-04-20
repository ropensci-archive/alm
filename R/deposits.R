#' Deposits
#' 
#' @export
#' @param message_type (character) Filter by message_type. optional
#' @param state (character) "Filter by DOI prefix" or maybe "Filter by state" optional
#' @param source_token (character) Filter by source_token. optional
#' @param api_url (character) API endpoint, defaults to http://alm.plos.org/api/v5/articles
#' @template curl
#' @examples \dontrun{
#' res <- deposits()
#' res$meta
#' head(res$deposits)
#' 
#' deposits(per_page = 2)
#' 
#' # message type
#' deposits(message_type = 'relation')
#' 
#' # source token
#' deposits(source_token = "5f9f3976-415f-4fb7-b5df-b7e0329d1258")
#' 
#' # source token
#' deposit(id = "67495ea3-f9d2-40cf-8336-10c87bb3ae83")
#' }
deposits <- function(message_type = NULL, state = NULL, source_token = NULL, 
                     page = NULL, per_page = NULL, 
                     api_url = 'https://eventdata.datacite.org', ...) {
  
  args <- args <- almcompact(list(message_type = message_type, state = state, 
                                  source_token = source_token,
                                  page = page, per_page = per_page))
  almGET(file.path(api_url, "api/deposits"), y = args, ...)
}

#' @export
#' @rdname deposits
deposit <- function(id, api_url = 'https://eventdata.datacite.org', ...) {
  alm_GET(file.path(api_url, "api/deposits", id), list(), ...)
}
