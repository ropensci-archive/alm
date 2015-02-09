#' Check status of an ALM service.
#' 
#' @export
#' @param key (character) Your API key, either enter, or loads from .Rprofile. Only required for 
#'    PKP source, not the others.
#' @param url API endpoint, defaults to http://alm.plos.org/api/v5/status (character)
#' @param ... optional additional curl options (debugging tools mostly) 
#' @examples \dontrun{
#' alm_status()
#' }

alm_status <- function(key = NULL, url = 'http://alm.plos.org/api/v5/status', ...)
{	
  tt <- alm_GET(url, almcompact(list(api_key = key)), ...)
  df <- data.frame(variable=names(tt$data), value=do.call(c, unname(tt$data)), stringsAsFactors = FALSE)
  list(error=tt$error, data=df)
}
