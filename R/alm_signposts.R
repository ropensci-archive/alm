#' Retrieve PLOS article-level metrics signposts.
#' 
#' This includes:
#' \itemize{
#'  \item viewed: counter, and pmc (PLOS only)
#'  \item saved: mendeley, and citeulike
#'  \item discussed: facebook, and twitter at PLOS
#'  \item cited: crossref, and scopus at PLOS
#' }
#' 
#' @export
#' @param doi Digital object identifier for an article in PLoS Journals (character)
#' @param pmid PubMed object identifier (numeric)
#' @param pmcid PubMed Central object identifier (numeric)
#' @param mendeley_uuid Mendeley object identifier (character)
#' @param url API endpoint, defaults to http://alm.plos.org/api/v3/articles (character)
#' @param source (character) Name of source to get ALM information for. One source only.
#'    You can get multiple sources via a for loop or lapply-type call.
#' @param key your PLoS API key, either enter, or loads from .Rprofile (character)
#' @param ... optional additional curl options (debugging tools mostly)
#' 
#' @details This is just a wrapper around the function \code{\link{alm_ids}}, forcing
#' info="summary", then coercing signposts data to a data.frame.
#' @seealso \code{\link{alm_ids}}, \code{\link{plot_signposts}}
#' @return A data.frame of the signpost numbers for the searched object, and DOIs.
#' @references See a tutorial/vignette for alm at 
#' \url{http://ropensci.org/tutorials/alm_tutorial.html}
#' @examples \dontrun{
#' # The default call with either doi, pmid, pmcid, or mendeley_uuid without specifying 
#' # an argument for info
#' alm_signposts(doi="10.1371/journal.pone.0029797")
#' 
#' # Many DOIs
#' dois <- c('10.1371/journal.pone.0001543','10.1371/journal.pone.0040117',
#' '10.1371/journal.pone.0029797','10.1371/journal.pone.0039395')
#' alm_signposts(doi=dois)
#' 
#' # A single PubMed ID (pmid)
#' alm_signposts(pmid=22590526)
#' 
#' # A single PubMed Central ID (pmcid)
#' alm_signposts(pmcid=212692)
#' 
#' # Curl debugging
#' library('httr')
#' alm_signposts(pmid=22590526, config=verbose())
#' }

alm_signposts <- function(doi = NULL, pmid = NULL, pmcid = NULL, mendeley_uuid = NULL, 
  source = NULL, key = NULL, url = 'http://alm.plos.org/api/v5/articles', ...)
{	
  temp <- alm_ids(doi = doi, pmid = pmid, pmcid = pmcid, mendeley_uuid = mendeley_uuid, url = url, 
      info = "summary", source = source, key = key, ...)
  if( !is.null(temp$data[['signposts']]) ){
    temp$data[['signposts']]
  } else
  {
    out <- lapply(temp$data, '[[', 'signposts')
    do.call(rbind, unname(out))
  }
}
