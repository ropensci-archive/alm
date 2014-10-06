#' @seealso \code{\link{alm_plot}}
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
#' alm_ids(doi="10.1371/journal.pone.0029797")
#'
#' # Details for a single DOI
#' out <- alm_ids(doi='10.1371/journal.pone.0029797', info='detail')
#' out
#' ## totals
#' out$data$info
#' ## history
#' out$data$sum_metrics
#'
#' # A single PubMed ID (pmid)
#' alm_ids(pmid=22590526)
#'
#' # A single PubMed Central ID (pmcid)
#' alm_ids(pmcid=212692, info='summary')
#'
#' # A single Mendeley UUID (mendeley)
#' alm_ids(mendeley_uuid="1d7e7f09-c59b-364b-8c39-a7686f0e9fa0")
#' 
#' # Provide more than one DOI
#' dois <- c('10.1371/journal.pone.0001543','10.1371/journal.pone.0040117',
#'		'10.1371/journal.pone.0029797','10.1371/journal.pone.0039395')
#' out <- alm_ids(doi=dois)
#' out[[1]] # get data for the first DOI
#'
#' # Search for DOI's, then feed into alm
#' library('rplos')
#' dois <- searchplos(q='evolution', fl='id',
#'    fq=list('-article_type:correction','doc_type:full'), limit = 52)
#' out <- alm_ids(doi=dois$data$id)
#' lapply(out, head)
#'
#' # Provide more than one pmid
#' pmids <- c(19300479, 19390606, 19343216)
#' out <- alm_ids(pmid=pmids)
#' out[[3]] # get data for the third pmid
#'
#' # Getting data for a specific source
#' alm_ids(doi='10.1371/journal.pone.0035869', source='mendeley')
#' alm_ids(doi='10.1371/journal.pone.0035869', source=c('mendeley','twitter','counter'))
#' alm_ids(doi='10.1371/journal.pone.0035869', source=c('mendeley','twitter','counter'),
#'    info='history')
#'
#' # Get detailed totals output
#' alm_ids(doi='10.1371/journal.pone.0035869', total_details=TRUE)
#'
#' # Get summary metrics by day
#' alm_ids(doi='10.1371/journal.pone.0036240', sum_metrics='day')
#'
#' # Get summary metrics by month
#' alm_ids(doi='10.1371/journal.pone.0036240', sum_metrics='month')
#'
#' # Get summary metrics by year
#' alm_ids(doi='10.1371/journal.pone.0036240', sum_metrics='year')
#'
#' # Search by source only, without article identifiers
#' alm_ids(source='crossref')
#'
#' # Curl debugging
#' library('httr')
#' alm_ids(doi="10.1371/journal.pone.0029797", config=verbose())
#' dois <- c('10.1371/journal.pone.0001543','10.1371/journal.pone.0040117',
#'  	'10.1371/journal.pone.0029797','10.1371/journal.pone.0039395')
#' alm_ids(doi=dois, config=verbose())
#' }
#'
#' @examples \dontest{
#' # Crossref article data
#' # You need to get an API key first, and pass in a different URL
#' url <- "http://alm.labs.crossref.org/api/v5/articles"
#' key <- getOption("crossrefalmkey")
#' alm_ids(doi='10.1371/journal.pone.0086859', url = url, key = key)
#' alm_ids(doi='10.11646/zootaxa.3618.1.1', url = url, key = key)
#' alm_ids(doi='10.1016/j.jep.2013.06.007', url = url, key = key)
#' alm_ids(doi='10.1111/j.1756-1051.2012.00099.x', url = url, key = key)
#'
#' # Public Knowledge Project article data
#' # You need to get an API key first, and pass in a different URL
#' url <- 'http://pkp-alm.lib.sfu.ca/api/v3/articles'
#' alm_ids(doi='10.3402/gha.v7.23554', url = url, key = getOption("pkpalmkey"))
#'
#' # Copernicus publishers article data
#' # You need to get an API key first, and pass in a different URL
#' url <- 'http://metricus.copernicus.org/api/v3/articles'
#' alm_ids(doi='10.5194/acpd-14-8287-2014', url = url, key = getOption("copernicusalmkey"))
#'
#' # eLife publishers article data
#' # You need to get an API key first, and pass in a different URL
#' url <- 'http://alm.svr.elifesciences.org/api/v3/articles'
#' alm_ids(doi='10.7554/eLife.00471', url = url, key = getOption("elifealmkey"))
#' }
