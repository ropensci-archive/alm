## urls
cr_url <- "http://api.eventdata.crossref.org"

# no identifiers
alm_works(per_page = 10)
## crossref
alm_works(api_url = cr_url, per_page = 10)

# A single identifier
## datacite
alm_works('http://doi.org/10.6068/DP1541A4866AD14')
## crossref
alm_works('http://doi.org/10.1002/14651858.CD005220.PUB2', api_url = cr_url)

# Details for a single DOI
out <- alm_works(c('http://doi.org/10.6068/DP1541A4866AD14', 'http://doi.org/10.6068/DP1541A53768228'))
out
## totals
out$meta
## history
out$works

# A single PubMed ID (pmid)
alm_works(22590526, type = "pmid", api_url = cr_url)

# A single PubMed Central ID (pmcid)
alm_works(212692, type = "pmcid", api_url = cr_url)

# A single Web of Science ID (wos)
alm_works(wos="000268452400005")

# A single Scopus ID (scp)
alm_works(scp="68049122102")

# A single Canonical URL (url)
alm_works(url="http://www.plosmedicine.org/article/info:doi/10.1371/journal.pmed.1000097")

# Provide more than one DOI
dois <- c('10.1371/journal.pone.0001543','10.1371/journal.pone.0040117',
		'10.1371/journal.pone.0029797','10.1371/journal.pone.0039395')
out <- alm_works(doi=dois)
out$data[[1]] # get data for the first DOI

# Search for DOI's, then feed into alm
library('rplos')
dois <- searchplos(q='evolution', fl='id',
   fq=list('-article_type:correction','doc_type:full'), limit = 250)
out <- alm_works(doi=dois$data$id)
lapply(out, head)

alm_works(dois$data$id[1:5], source_id = "facebook")

sources <- c("facebook","twitter","mendeley","reddit","scopus","wikipedia")
lapply(sources, function(x) alm_works(dois$data$id[1:5], source_id = x))

# Provide more than one pmid
pmids <- c(19300479, 19390606, 19343216)
out <- alm_works(pmid=pmids)
out$data[[3]] # get data for the third pmid

# Getting data for a specific source_id
alm_works(doi='10.1371/journal.pone.0035869', source_id='mendeley')
alm_works(doi='10.1371/journal.pone.0035869', source_id='twitter')
alm_works(doi='10.1371/journal.pone.0035869', source_id='counter', info='detail')
## fails if more than one source_id given
# alm_works(doi='10.1371/journal.pone.0035869', source_id=c('twitter','facebook'))

# Get detailed totals output
alm_works(doi='10.1371/journal.pone.0035869', total_details=TRUE)

# Get summary metrics by day
alm_works(doi='10.1371/journal.pone.0036240', sum_metrics='day')

# Get summary metrics by month
alm_works(doi='10.1371/journal.pone.0036240', sum_metrics='month')

# Get summary metrics by year
alm_works(doi='10.1371/journal.pone.0036240', sum_metrics='year')

# Get data by source_id
alm_works(source_id='crossref')
alm_works(source_id='twitter')

# Curl debugging
library('httr')
alm_works(doi="10.1371/journal.pone.0029797", config=verbose())
dois <- c('10.1371/journal.pone.0001543','10.1371/journal.pone.0040117',
 	'10.1371/journal.pone.0029797','10.1371/journal.pone.0039395')
alm_works(doi=dois, config=progress())

# Data from other sources
## Crossref article data
### Pass in a different URL - no key needed
api_url <- "http://det.labs.crossref.org/api/v5/articles"
alm_works(doi='10.1371/journal.pone.0086859', api_url = api_url)
alm_works(doi='10.11646/zootaxa.3618.1.1', api_url = api_url)
alm_works(doi='10.1016/j.jep.2013.06.007', api_url = api_url)
alm_works(doi='10.1111/j.1756-1051.2012.00099.x', api_url = api_url)

## Public Knowledge Project article data
### pass in a different url - an API key needed
api_url <- 'http://pkp-alm.lib.sfu.ca/api/v5/articles'
alm_works(doi='10.3402/gha.v7.23554', api_url = api_url, key = getOption("pkpalmkey"))

## eLife
### pass in a different url - no key needed
api_url <- 'http://lagotto.svr.elifesciences.org/api/v5/articles'
alm_works(doi='10.7554/eLife.00471', api_url = api_url)
}
