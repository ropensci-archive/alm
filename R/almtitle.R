#' Get title of article by inputting the doi for the article.
#' 
#' @import httr
#' @importFrom stringr str_replace_all
#' @param doi digital object identifier for an article in PLoS Journals
#' @param key your PLoS API key, either enter, or loads from .Rprofile
#' @return Title of article, in xml format.
#' @references See a tutorial/vignette for alm at 
#' \url{http://ropensci.org/tutorials/alm_tutorial.html}
#' @examples \dontrun{
#' almtitle(doi='10.1371/journal.pbio.0000012')
#' }
#' @export
almtitle <- function(doi, key = NULL) 
{ 
	url = 'http://alm.plos.org/api/v3/articles'
	key <- getkey(key)
	doi <- paste("doi/", doi, sep="")
	doi2 <- gsub("/", "%2F", doi)
	url2 <- paste(url, "/info%3A", doi2, sep='')
	args <- almcompact(list(api_key = key, info = 'summary'))
	tt <- GET(url2, query=args)
	stop_for_status(tt)
	res <- content(tt, as = "text")
	out <- RJSONIO::fromJSON(res, simplifyVector = FALSE)
	str_replace_all(unlist(out[[1]])["title"], "<(.|\n)*?>", "")[[1]]
}