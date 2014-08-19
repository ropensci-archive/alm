#' @seealso \code{\link{almplot}}
#' @details You can only supply one of the parmeters doi, pmid, pmcid, and mendeley.
#'
#' 		Query for as many articles at a time as you like. Though queries are broken
#' 		up in to smaller bits of 50 identifiers at a time.
#'
#' 		If you supply days, months and/or year parameters, days takes precedence
#' 		over months and year.
#' @return PLoS altmetrics as data.frame's.
#' @examples \dontrun{
#' # The default call with either doi, pmid, pmcid, or mendeley without specifying
#' # an argument for info
#' alm(doi="10.1371/journal.pone.0029797")
#'
#' # Details for a single DOI
#' out <- alm(doi='10.1371/journal.pone.0029797', info='detail')
#' out
#' ## totals
#' out[["info"]]
#' ## history
#' out[["sum_metrics"]]
#'
#' # A single PubMed ID (pmid)
#' alm(pmid=22590526)
#'
#' # A single PubMed Central ID (pmcid)
#' alm(pmcid=212692, info='summary')
#'
#' # A single Mendeley UUID (mendeley)
#' alm(mendeley="437b07d9-bc40-4c57-b60e-1f60fefe2300")
#' alm(mendeley=c("edc2e519-cc10-36fc-a68d-12e0116c6ac0", "62128d98-b63d-3f26-9bb4-0bda3913f01e"))
#'
#' # Provide more than one DOI
#' dois <- c('10.1371/journal.pone.0001543','10.1371/journal.pone.0040117',
#'		'10.1371/journal.pone.0029797','10.1371/journal.pone.0039395')
#' out <- alm(doi=dois)
#' out[[1]] # get data for the first DOI
#'
#' # Search for DOI's, then feed into alm
#' library('rplos')
#' dois <- searchplos(q='evolution', fl='id', 
#'    fq=list('-article_type:correction','doc_type:full'), limit = 52)
#' out <- alm(doi=as.character(dois[,1]))
#' lapply(out, head)
#'
#' # Provide more than one pmid
#' pmids <- c(19300479, 19390606, 19343216)
#' out <- alm(pmid=pmids)
#' out[[3]] # get data for the third pmid
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
#' 
#' # Search by source only, without article identifiers
#' alm(source='crossref')
#' 
#' # Curl debugging
#' library('httr')
#' alm(doi="10.1371/journal.pone.0029797", config=verbose())
#' dois <- c('10.1371/journal.pone.0001543','10.1371/journal.pone.0040117',
#'  	'10.1371/journal.pone.0029797','10.1371/journal.pone.0039395')
#' alm(doi=dois, config=verbose())
#' }
#'
#' @examples \dontest{
#' # Crossref article data
#' # You need to get an API key first, and pass in a different URL
#' url <- "http://alm.labs.crossref.org/api/v5/articles"
#' alm(doi='10.1371/journal.pone.0086859', url = url, key = getOption("crossrefalmkey"))
#'
#' # Public Knowledge Project article data
#' # You need to get an API key first, and pass in a different URL
#' url <- 'http://pkp-alm.lib.sfu.ca/api/v3/articles'
#' alm(doi='10.3402/gha.v7.23554', url = url, key = getOption("pkpalmkey"))
#'
#' # Copernicus publishers article data
#' # You need to get an API key first, and pass in a different URL
#' url <- 'http://metricus.copernicus.org/api/v3/articles'
#' alm(doi='10.5194/acpd-14-8287-2014', url = url, key = getOption("copernicusalmkey"))
#'
#' # eLife publishers article data
#' # You need to get an API key first, and pass in a different URL
#' url <- 'http://alm.svr.elifesciences.org/api/v3/articles'
#' alm(doi='10.7554/eLife.00471', url = url, key = getOption("elifealmkey"))
#' }
