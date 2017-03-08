#' Works
#' 
#' @export
#' @param id (character) A single work ID. required
#' @param ids (character) Work IDs. optional
#' @param q (character) Query for ids. optional
#' @param type (character) Work ID type (one of doi, pmid, pmcid, arxiv, wos, 
#' scp, ark, or url). optional
#' @param source_id (character) Source ID. optional
#' @param publisher_id (character) Publisher ID. optional
#' @param contributor_id (character) Contributor ID. optional
#' @param relation_type_id (character) Relation_type ID. optional
#' @param registration_agency (character) Registration agency. optional
#' @param sort (character) Sort by source result count descending, or by publication 
#' date descending if left empty. optional
#' @param page (numeric) Page number. optional
#' @param per_page (numeric) Results per page (0-1000), defaults to 1000. optional
#' @param api_url (character) API endpoint, defaults to http://alm.plos.org/api/v5/articles
#' @template curl
#' @details 
#' Returns list of works either by ID, or all
#' 
#' If no ids are provided in the query, all works are returned, 1000 per page and 
#' sorted by publication date (default), or source result count. Search is not 
#' supported by the API.
#' @examples \dontrun{
#' alm_work(id = 'http://doi.org/10.6068/DP1541A4866AD14')
#' 
#' alm_works(ids = 'http://doi.org/10.6068/DP1541A4866AD14')
#' ids <- c('http://doi.org/10.6068/DP1541A53768228','http://doi.org/10.6068/DP1541A4866AD14')
#' alm_works(ids = ids)
#' }
alm_works <- function(ids = NULL, q = NULL, type = NULL, source_id = NULL, publisher_id = NULL, 
  contributor_id = NULL, relation_type_id = NULL, registration_agency = NULL, 
  sort = NULL, page = NULL, per_page = NULL, api_url = 'https://eventdata.datacite.org', ...) {
  
  # check_if(length(id) == 0, paste0("Supply one of: ", id_names_c))
  # check_if(length(delsp(id)) > 1, paste0("Only supply one of: ", paste0(id_names2, collapse = ", ")))
  # check_if(length(source_id) > 1, "You can only supply one source_id")
  # check_if(length(publisher_id) > 1, "You can only supply one publisher_id")
  
  ids <- if (!is.null(ids)) paste0(ids, collapse = ",")
  args <- almcompact(list(ids = ids, q = q, type = type, source_id = source_id, 
                          publisher_id = publisher_id, contributor_id = contributor_id, 
                          relation_type_id = relation_type_id, 
                          registration_agency = registration_agency, 
                          sort = sort, page = page, per_page = per_page))
  
  alm_GET(file.path(api_url, "works"), args, ...)
  # if (length(justid) == 0) {
  #   check_if(length(id) == 0, paste0("Please provide one of: ", id_names_c))
  #   tt <- alm_GET(api_url, args, ...)
  # } else {
  #   if (length(delsp(id)[[1]]) == 1) {
  #     tt <- alm_GET(file.path(api_url, "api/works", id[[1]]), args, ...)
  #   } else {
  #     if (length(delsp(id)[[1]]) > 1) {
  #       if (length(delsp(id)[[1]]) > 50) {
  #         slice <- function(x, n) split(x, as.integer((seq_along(x) - 1) / n))
  #         idsplit <- slice(delsp(id)[[1]], 50)
  #         repeatit <- function(y) {
  #           if (names(delsp(id)) == "doi") {
  #             id2 <- paste(sapply(y, function(x) gsub("/", "%2F", x)), collapse=",")
  #           } else {
  #             id2 <- paste(delsp(id)[[1]], collapse=",")
  #           }
  #           tt <- alm_POST(api_url, c(args, ids = id2), sleep=sleep, ...)
  #         }
  #         temp <- lapply(idsplit, repeatit)
  #         justdat <- do.call(c, unname(lapply(temp, "[[", "data")))
  #         tt <- c(temp[[1]][ !names(temp[[1]]) == "data" ], data=list(justdat))
  #       } else {
  #         id2 <- id2 <- concat_ids(delsp(id))
  #         tt <- alm_POST(api_url, c(args, ids = id2), ...)
  #       }
  #     }
  #   }
  # }
  # 
  # tt
}

#' @export
#' @rdname alm_works
alm_work <- function(id, api_url = 'https://eventdata.datacite.org', ...) {
  alm_GET(file.path(api_url, "api/works", id), list(), ...)
}

### helpers
ids_list <- function(...) {
  almcompact(list(...))
}

id_names2 <- c("doi", "pmid", "pmcid", "wos", "scp", "url", "arxiv", "ark")
id_names <- c("doi", "pmid", "pmcid", "wos", "scp", "url", "arxiv", 
              "ark", "source_id", "publisher_id")
id_names_c <- paste0(id_names, collapse = ", ")
