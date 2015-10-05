#' ALM works
#' 
#' @export
#' @param doi xxx
#' @param pmid xxx
#' @param pmcid xxx
#' @param wos xxx
#' @param scp xxx
#' @param url xxx
#' @param arxiv xxx
#' @param ark xxx
#' @param source_id xxx
#' @param publisher_id xxx
#' @param api_url (character) API endpoint, defaults to http://alm.plos.org/api/v5/articles
#' @param ... Curl options (debugging tools mostly) passed on to \code{\link[httr]{GET}} 
#' @examples \dontrun{
#' alm_works(doi = '10.1371/journal.ppat.1005123')
#' }
alm_works <- function(doi = NULL, pmid = NULL, pmcid = NULL, wos = NULL, 
                      scp = NULL, url = NULL, arxiv = NULL, ark = NULL, 
                      source_id = NULL, publisher_id = NULL,
                      api_url = 'http://alm.plos.org', ...){
  
  justid <- ids_list(doi = doi, pmid = pmid, pmcid = pmcid, wos = wos, scp = scp, 
                 url = url, arxiv = arxiv, ark = ark)
  id <- c(justid, source_id = source_id, publisher_id = publisher_id)
  
  check_if(length(id) == 0, paste0("Supply one of: ", id_names_c))
  check_if(length(delsp(id)) > 1, paste0("Only supply one of: ", paste0(id_names2, collapse = ", ")))
  check_if(length(source_id) > 1, "You can only supply one source_id")
  check_if(length(publisher_id) > 1, "You can only supply one publisher_id")
  
  args <- ids_list(source_id = source_id, publisher_id = publisher_id, type = idtype(names(id)))
  if (length(justid) == 0) {
    check_if(length(id) == 0, paste0("Please provide one of: ", id_names_c))
    tt <- alm_GET(api_url, args, ...)
  } else {
    if (length(delsp(id)[[1]]) == 1) {
      tt <- alm_GET(file.path(api_url, "api/works", id[[1]]), args, ...)
    } else {
      if (length(delsp(id)[[1]]) > 1) {
        if (length(delsp(id)[[1]]) > 50) {
          slice <- function(x, n) split(x, as.integer((seq_along(x) - 1) / n))
          idsplit <- slice(delsp(id)[[1]], 50)
          repeatit <- function(y) {
            if (names(delsp(id)) == "doi") {
              id2 <- paste(sapply(y, function(x) gsub("/", "%2F", x)), collapse=",")
            } else {
              id2 <- paste(delsp(id)[[1]], collapse=",")
            }
            tt <- alm_POST(api_url, c(args, ids = id2), sleep=sleep, ...)
          }
          temp <- lapply(idsplit, repeatit)
          justdat <- do.call(c, unname(lapply(temp, "[[", "data")))
          tt <- c(temp[[1]][ !names(temp[[1]]) == "data" ], data=list(justdat))
        } else {
          id2 <- id2 <- concat_ids(delsp(id))
          tt <- alm_POST(api_url, c(args, ids = id2), ...)
        }
      }
    }
  }
  
  tt
}

ids_list <- function(...) {
  almcompact(list(...))
}

id_names2 <- c("doi", "pmid", "pmcid", "wos", "scp", "url", "arxiv", "ark")
id_names <- c("doi", "pmid", "pmcid", "wos", "scp", "url", "arxiv", 
              "ark", "source_id", "publisher_id")
id_names_c <- paste0(id_names, collapse = ", ")
