#' Retrieve PLOS article-level metrics signposts.
#' 
#' This includes:
#' \itemize{
#'  \item views: counter + pmc (PLOS only)
#'  \item shares: facebook (+ twitter at PLOS)
#'  \item bookmarks: mendeley + citeulike
#'  \item citations: crossref (scopus at PLOS)
#' }
#' 
#' @template alm_params 
#' @details This is just a wrapper around the function \code{\link{alm}}, forcing
#' info="summary", then coercing signposts data to a data.frame.
#' @seealso \code{\link{alm}}
#' @return A data.frame of the signpost numbers for the searched object.
#' @examples \dontrun{
#' # The default call with either doi, pmid, pmcid, or mdid without specifying 
#' # an argument for info
#' signposts(doi="10.1371/journal.pone.0029797")
#' 
#' # Many DOIs
#' dois <- c('10.1371/journal.pone.0001543','10.1371/journal.pone.0040117','10.1371/journal.pone.0029797','10.1371/journal.pone.0039395')
#' signposts(doi=dois)
#' 
#' # A single PubMed ID (pmid)
#' signposts(pmid=22590526)
#' 
#' # A single PubMed Central ID (pmcid)
#' signposts(pmcid=212692)
#' 
#' # A single Mendeley UUID (mdid)
#' signposts(mdid="35791700-6d00-11df-a2b2-0026b95e3eb7")
#' }
#' @export
signposts <- function(doi = NULL, pmid = NULL, pmcid = NULL, mdid = NULL, 
                url = 'http://alm.plos.org/api/v3/articles',
                info = "totals", months = NULL, days = NULL, year = NULL, 
                source = NULL, key = NULL, curl = getCurlHandle(), 
                total_details = FALSE, sum_metrics = NULL)
{	
  temp <- alm(doi = doi, pmid = pmid, pmcid = pmcid, mdid = mdid, url = url, 
      info = "summary", months = months, days = days, year = year, source = source, 
      key = key, curl = curl, total_details = total_details, sum_metrics = sum_metrics)
  if(class(try(temp[[2]], silent=TRUE)) == "try-error"){
    data.frame(temp[[1]][c("views","shares","bookmarks","citations")])
  } else
  {
    out <- lapply(temp, function(x) data.frame(x[c("views","shares","bookmarks","citations")]))
    do.call(rbind, out)
  }
}