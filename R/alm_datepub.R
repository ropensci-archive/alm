#' Get the date when the article was published.
#'
#' @import httr
#' @importFrom stringr str_split
#' @export
#' @param doi Digital object identifier for an article in PLoS Journals
#' @param get Get year, month, or day; if unspecified, whole date returned.
#' @param sleep Time (in seconds) before function sends API call - defaults to
#'    zero.  Set to higher number if you are using this function in a loop with
#'    many API calls.
#' @param key your PLoS API key, either enter, or loads from .Rprofile
#' @references See a tutorial/vignette for alm at
#' \url{http://ropensci.org/tutorials/alm_tutorial.html}
#' @return Date when article was published.
#' @examples \dontrun{
#' alm_datepub(doi='10.1371/journal.pone.0026871')
#' alm_datepub('10.1371/journal.pone.0026871', get='year')
#'
#' # Provide more than one DOI
#' dois <- c('10.1371/journal.pone.0026871','10.1371/journal.pone.0048868',
#' 		'10.1371/journal.pone.0048705','10.1371/journal.pone.0048731')
#' alm_datepub(doi=dois, get="month")
#' }

alm_datepub <- function(doi = NULL, pmid = NULL, pmcid = NULL, mendeley_uuid = NULL, 
  get = NULL, key = NULL, url = 'http://alm.plos.org/api/v5/articles', ...)
{
  temp <- alm_ids(doi = doi, pmid = pmid, pmcid = pmcid, mendeley_uuid = mendeley_uuid, url = url, 
                  info = "summary", key = key, ...)
  if(length(doi) == 1) getdate(temp$data, get) else lapply(temp$data, getdate, get=get)
}

getdate <- function(x, get) {
  date <- x$info$issued
  if(is.null(get)) { date } else {
    switch(get, 
           year = as.numeric(strsplit(date,"-")[[1]][1]),
           month = as.numeric(strsplit(date,"-")[[1]][2]),
           day = as.numeric(strsplit(date,"-")[[1]][3])
    )
  }
}
