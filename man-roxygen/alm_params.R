#' @param doi (character) Digital object identifier for an article in PLoS Journals
#' @param pmid (numeric) PubMed object identifier
#' @param pmcid (numeric) PubMed Central object identifier
#' @param wos (character) Web of Science identifier
#' @param scp (character) Scopus identifier
#' @param url (character) Canonical URL. This is a URL for an object, not the URL for the 
#'    Lagotto instance (see api_url)
#' @param info One of totals, summary, or detail (default totals + sum_metrics data in a list).
#' 		Not specifying anything (the default) returns data.frame of totals across
#' 		data providers. (character). \code{info='detail'} returns all possible data, including slots
#'   	for info, signposts, totals, and sum_metrics (see the sum_metrics parameter below).
#'    IMPORTANT: note, however, that you can only get by day metrics for articles published since
#'    May 2014.
#' @param source_id (character) Name of source to get ALM information for. One source only.
#'    You can get multiple sources via a for loop or lapply-type call.
#' @param publisher_id (character) Metrics for articles by a given publisher, using the Crossref
#'    \code{member_id}.
#' @param key (character) Your API key, either enter, or loads from .Rprofile. Only required for
#'    PKP source, not the others.
#' @param total_details (logical) If FALSE (the default) the standard totals data.frame is
#'    returned; if TRUE, the totals data is in a wide format with more details
#'    about the paper, including publication date, title, etc. If you set this
#'    to TRUE, the output should no longer with with \code{\link{alm_plot}}.
#' @param sum_metrics (character) Just like the output you get from setting info='totals', you can
#'    get summary metrics by day (sum_metrics='day'), month (sum_metrics='month'),
#'    or year (sum_metrics='year'). IMPORTANT: note that you can only get by day metrics for
#'    articles published since May 2014.
#' @param api_url (character) API endpoint, defaults to http://alm.plos.org/api/v5/articles
