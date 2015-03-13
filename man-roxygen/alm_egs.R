#' @seealso \code{\link{alm_plot}}
#' @details You can only supply one of the parmeters doi, pmid, pmcid, wos, scp, or url; and you
#' must supply one of them. Query for as many articles at a time as you like. Though queries
#' are broken up in to smaller bits of 50 identifiers at a time. If you supply days, months and/or
#' year parameters, days takes precedence over months and year.
#' @return PLoS altmetrics as data.frame's.
#' @examples \dontrun{
#' # The default call with either doi, pmid, pmcid, wos, scp, or url without specifying
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
#' # A single Web of Science ID (wos)
#' alm_ids(wos="000268452400005")
#'
#' # A single Scopus ID (scp)
#' alm_ids(scp="68049122102")
#'
#' # A single Canonical URL (url)
#' alm_ids(url="http://www.plosmedicine.org/article/info:doi/10.1371/journal.pmed.1000097")
#'
#' # Provide more than one DOI
#' dois <- c('10.1371/journal.pone.0001543','10.1371/journal.pone.0040117',
#'		'10.1371/journal.pone.0029797','10.1371/journal.pone.0039395')
#' out <- alm_ids(doi=dois)
#' out$data[[1]] # get data for the first DOI
#'
#' # Search for DOI's, then feed into alm
#' library('rplos')
#' dois <- searchplos(q='evolution', fl='id',
#'    fq=list('-article_type:correction','doc_type:full'), limit = 250)
#' out <- alm_ids(doi=dois$data$id)
#' lapply(out, head)
#'
#' alm_ids(dois$data$id[1:5], source_id = "facebook")
#'
#' sources <- c("facebook","twitter","mendeley","reddit","scopus","wikipedia")
#' lapply(sources, function(x) alm_ids(dois$data$id[1:5], source_id = x))
#'
#' # Provide more than one pmid
#' pmids <- c(19300479, 19390606, 19343216)
#' out <- alm_ids(pmid=pmids)
#' out$data[[3]] # get data for the third pmid
#'
#' # Getting data for a specific source_id
#' alm_ids(doi='10.1371/journal.pone.0035869', source_id='mendeley')
#' alm_ids(doi='10.1371/journal.pone.0035869', source_id='twitter')
#' alm_ids(doi='10.1371/journal.pone.0035869', source_id='counter', info='detail')
#' ## fails if more than one source_id given
#' # alm_ids(doi='10.1371/journal.pone.0035869', source_id=c('twitter','facebook'))
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
#' # Get data by source_id
#' alm_ids(source_id='crossref')
#' alm_ids(source_id='twitter')
#'
#' # Curl debugging
#' library('httr')
#' alm_ids(doi="10.1371/journal.pone.0029797", config=verbose())
#' dois <- c('10.1371/journal.pone.0001543','10.1371/journal.pone.0040117',
#'  	'10.1371/journal.pone.0029797','10.1371/journal.pone.0039395')
#' alm_ids(doi=dois, config=progress())
#' 
#' # Data from other sources
#' ## Crossref article data
#' ### Pass in a different URL - no key needed
#' api_url <- "http://det.labs.crossref.org/api/v5/articles"
#' alm_ids(doi='10.1371/journal.pone.0086859', api_url = api_url)
#' alm_ids(doi='10.11646/zootaxa.3618.1.1', api_url = api_url)
#' alm_ids(doi='10.1016/j.jep.2013.06.007', api_url = api_url)
#' alm_ids(doi='10.1111/j.1756-1051.2012.00099.x', api_url = api_url)
#'
#' ## Public Knowledge Project article data
#' ### pass in a different url - an API key needed
#' api_url <- 'http://pkp-alm.lib.sfu.ca/api/v5/articles'
#' alm_ids(doi='10.3402/gha.v7.23554', api_url = api_url, key = getOption("pkpalmkey"))
#'
#' ## eLife 
#' ### pass in a different url - no key needed
#' api_url <- 'http://lagotto.svr.elifesciences.org/api/v5/articles'
#' alm_ids(doi='10.7554/eLife.00471', api_url = api_url)
#' }
