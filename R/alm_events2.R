# alm_events_new(doi = "10.1371/journal.ppat.1005123")
alm_events_new <- function(doi = NULL, pmid = NULL, pmcid = NULL, wos = NULL, scp = NULL, 
                           url = NULL, arxiv = NULL, ark = NULL, source_id = NULL, 
                           publisher_id = NULL, compact = TRUE, 
                           api_url='http://alm.plos.org', ...) {
  
  id <- almcompact(list(doi=doi, pmid=pmid, pmcid=pmcid, wos=wos, scp=scp, 
                        url=url, arxiv = arxiv, ark = ark, 
                        source_id=source_id, publisher_id=publisher_id))
  check_if(length(delsp(id)) > 1, "Only supply one of: doi, pmid, pmcid, wos, scp, url, arxiv, ark, wos")
  check_if(length(source_id) > 1, "Supply only one source_id")
  check_if(length(publisher_id) > 1, "Supply only one publisher_id")
  
  args <- almcompact(list(source_id = source_id, publisher_id=publisher_id, type = idtype(names(id))))
  if (length(almcompact(list(doi = doi, pmid = pmid, pmcid = pmcid, wos = wos, url = url, 
                             scp = scp, arxiv = arxiv, ark = ark))) == 0) {
    if (length(id) == 0) stop("Please provide one of: doi, pmid, pmcid, wos, scp, url, arxiv, ark, source_id, or publisher_id", call. = FALSE)
    ttt <- alm_GET(file.path(api_url, "events"), args, ...)
    lapply(ttt$data, function(x) x$sources)
  } else {
    ttt <- lapply(id[[1]], function(z) alm_GET(file.path(api_url, "api/works", z, "events"), args, ...))
    pluck(ttt, "events")
  }
}

check_if <- function(statement, mssg) {
  if (statement) {
    stop(mssg, call. = FALSE)
  }  
}

# make_args <- function(url, args) {
#   
# }
# 
# make_url <- function(x) {
#   
# }

which_api <- function(x) {
  grepl("api/v5/articles", x)
}
