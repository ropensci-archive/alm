#' @seealso \code{\link{almplot}}
#' @details You can only supply one of the parmeters doi, pmid, pmcid, and mdid.
#' 
#' 		Query for as many articles at a time as you like. Though queries are broken
#' 		up in to smaller bits of 50 identifiers at a time.  
#' 		
#' 		If you supply days, months and/or year parameters, days takes precedence
#' 		over months and year. 		
#' @return PLoS altmetrics as data.frame's.
#' @examples \dontrun{
#' # The default call with either doi, pmid, pmcid, or mdid without specifying 
#' # an argument for info
#' alm(doi="10.1371/journal.pone.0029797")
#' 
#' # Details for a single DOI
#' out <- alm(doi='10.1371/journal.pone.0029797', info='detail')
#' ## totals
#' out[["totals"]]
#' ## history
#' out[["history"]]
#' 
#' # A single PubMed ID (pmid)
#' alm(pmid=22590526)
#' 
#' # A single PubMed Central ID (pmcid)
#' alm(pmcid=212692, info='summary')
#' 
#' # A single Mendeley UUID (mdid)
#' alm(mdid="35791700-6d00-11df-a2b2-0026b95e3eb7")
#'
#' # Provide more than one DOI
#' dois <- c('10.1371/journal.pone.0001543','10.1371/journal.pone.0040117',
#'		'10.1371/journal.pone.0029797','10.1371/journal.pone.0039395')
#' out <- alm(doi=dois)
#' out[[1]] # get data for the first DOI
#' 
#' # Search for DOI's, then feed into alm
#' dois <- searchplos(terms='evolution', fields='id', limit = 52)
#' out <- alm(doi=as.character(dois[,1]))
#' lapply(out, head)
#' 
#' # Provide more than one pmid
#' pmids <- c(19300479, 19390606, 19343216)
#' out <- alm(pmid=pmids)
#' out[[3]] # get data for the third pmid
#' 
#' # Getting just summary data
#' alm(doi='10.1371/journal.pone.0039395', info='summary')
#' 
#' # Using days argument
#' alm(doi='10.1371/journal.pone.0040117', days=30)
#' 
#' # Using the year argument
#' alm(doi='10.1371/journal.pone.0040117', year=2012)
#' 
#' # Getting data for a specific source
#' alm(doi='10.1371/journal.pone.0035869', source='mendeley')
#' alm(doi='10.1371/journal.pone.0035869', source=c('mendeley','twitter','counter'))
#' alm(doi='10.1371/journal.pone.0035869', source=c('mendeley','twitter','counter'), info='history')
#' 
#' # Get detailed totals output
#' alm(doi='10.1371/journal.pone.0035869', total_details=TRUE)
#' 
#' # Get summary metrics by day
#' alm(doi='10.1371/journal.pone.0036240', sum_metrics='day')
#' 
#' # Get summary metrics by month
#' alm(doi='10.1371/journal.pone.0036240', sum_metrics='month')
#' 
#' # Get summary metrics by year
#' alm(doi='10.1371/journal.pone.0036240', sum_metrics='year')
#' }