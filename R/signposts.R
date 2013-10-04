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
#' @param doi Digital object identifier for an article in PLoS Journals (character)
#' @param pmid PubMed object identifier (numeric)
#' @param pmcid PubMed Central object identifier (numeric)
#' @param mdid Mendeley object identifier (character)
#' @param url API endpoint, defaults to http://alm.plos.org/api/v3/articles (character)
#' @param months Number of months since publication to request historical data for.
#'    See details for a note. (numeric)
#' @param days Number of days since publication to request historical data for. 
#'    See details for a note. (numeric)
#' @param year End of which year to request historical data for. 
#'    See details for a note. (numeric)
#' @param source Name of source (or list of sources) to get ALM information for 
#'    (character)
#' @param key your PLoS API key, either enter, or loads from .Rprofile (character)
#' @param ... optional additional curl options (debugging tools mostly)
#' @param curl If using in a loop, call getCurlHandle() first and pass
#'    the returned value in here (avoids unnecessary footprint)
#' @details This is just a wrapper around the function \code{\link{alm}}, forcing
#' info="summary", then coercing signposts data to a data.frame.
#' @seealso \code{\link{alm}}, \code{\link{plot_signposts}}
#' @return A data.frame of the signpost numbers for the searched object, and DOIs.
#' @examples \dontrun{
#' # The default call with either doi, pmid, pmcid, or mdid without specifying 
#' # an argument for info
#' signposts(doi="10.1371/journal.pone.0029797")
#' 
#' # Many DOIs
#' dois <- c('10.1371/journal.pone.0001543','10.1371/journal.pone.0040117',
#' '10.1371/journal.pone.0029797','10.1371/journal.pone.0039395')
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
                months = NULL, days = NULL, year = NULL, 
                source = NULL, key = NULL, curl = getCurlHandle())
{	
  temp <- alm(doi = doi, pmid = pmid, pmcid = pmcid, mdid = mdid, url = url, 
      info = "summary", months = months, days = days, year = year, source = source, 
      key = key, curl = curl)
  if(class(try(temp[[2]], silent=TRUE)) == "try-error"){
    data.frame(temp[[1]][c("views","shares","bookmarks","citations")])
  } else
  {
    out <- lapply(temp, function(x) data.frame(x[c("doi","views","shares","bookmarks","citations")]))
    do.call(rbind, out)
  }
}