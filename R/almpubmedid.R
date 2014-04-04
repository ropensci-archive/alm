#' Get PubMed article ID by inputting the doi for the article.
#' 
#' @import httr 
#' @param doi digital object identifier for an article in PLoS Journals
#' @param key your PLoS API key, either enter, or loads from .Rprofile
#' @return The PubMed article ID.
#' @references See a tutorial/vignette for alm at 
#' \url{http://ropensci.org/tutorials/alm_tutorial.html}
#' @examples \dontrun{
#' almpubmedid(doi = '10.1371/journal.pbio.0000012')
#' }
#' @export
almpubmedid <- function(doi, key = NULL) 
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
	as.numeric(out[[1]]$pmid)
}