#' Get title of article by inputting the doi for the article.
#'
#' @import httr
#' @importFrom stringr str_replace_all
#' @export
#' @param doi digital object identifier for an article in PLoS Journals
#' @param key your PLoS API key, either enter, or loads from .Rprofile
#' @return Title of article, in xml format.
#' @references See a tutorial/vignette for alm at
#' \url{http://ropensci.org/tutorials/alm_tutorial.html}
#' @examples \dontrun{
#' alm_title(doi='10.1371/journal.pbio.0000012')
#' dois <- c('10.1371/journal.pone.0026871','10.1371/journal.pone.0048868',
#'   	'10.1371/journal.pone.0048705','10.1371/journal.pone.0048731')
#' alm_title(doi=dois)
#' }

alm_title <- function(doi = NULL, pmid = NULL, pmcid = NULL, mendeley_uuid = NULL, 
  key = NULL, url = 'http://alm.plos.org/api/v5/articles', ...)
{
  temp <- alm_ids(doi = doi, pmid = pmid, pmcid = pmcid, mendeley_uuid = mendeley_uuid, url = url, 
                  info = "summary", key = key, ...)
  if(length(doi) == 1) temp$data$info$title else lapply(temp$data, function(x) x$info$title)  
}
