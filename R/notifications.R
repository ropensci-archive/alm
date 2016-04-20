#' Notifications
#' 
#' @export
#' @param key (character) An API key. Required.
#' @param api_url (character) API endpoint, defaults to http://alm.plos.org/api/v5/articles
#' @template curl
notifications <- function(key, api_url = 'https://eventdata.datacite.org', ...) {
  stop("doesn't work yet", call. = FALSE)
  #almGET(file.path(api_url, "api/notifications"), key = key, ...)
}
