#' Alt-metrics total citations from all sources.
#' 
#' @export
#' @param doi digital object identifier for an article in PLoS Journals
#' @param key your PLoS API key, either enter, or loads from .Rprofile
#' @return data.frame of total no. views (counter + pmc), shares (facebook + twitter),
#' 		bookmarks (mendeley + citeulike), and citations (crossref)
#' @references See a tutorial/vignette for alm at 
#' \url{http://ropensci.org/tutorials/alm_tutorial.html}
#' @examples \dontrun{
#' almtotals(doi = '10.1371/journal.pbio.0000012')
#' }
almtotals <- function(doi, key = NULL) 
{ 
	url = 'http://alm.plos.org/api/v3/articles'	
	key <- getkey(key)
	doi <- paste("doi/", doi, sep="")
	doi2 <- gsub("/", "%2F", doi)
	url2 <- paste(url, "/info%3A", doi2, sep='')
	args <- almcompact(list(api_key = key, info = 'detail'))
	tt <- GET(url2, query=args)
	stop_for_status(tt)
	res <- content(tt, as = "text")
	out <- RJSONIO::fromJSON(res, simplifyVector = FALSE)
	data.frame(out[[1]][c("views","shares","bookmarks","citations")])
}