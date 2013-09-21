#' @param doi Digital object identifier for an article in PLoS Journals (character)
#' @param pmid PubMed object identifier (numeric)
#' @param pmcid PubMed Central object identifier (numeric)
#' @param mdid Mendeley object identifier (character)
#' @param url API endpoint, defaults to http://alm.plos.org/api/v3/articles (character)
#' @param info One of summary, history, or detail(default totals + history in a list). 
#' 		Not specifying anything (the default) returns data.frame of totals across 
#' 		data providers. (character)
#' @param months Number of months since publication to request historical data for.
#' 		See details for a note. (numeric)
#' @param days Number of days since publication to request historical data for. 
#' 		See details for a note. (numeric)
#' @param year End of which year to request historical data for. 
#'   	See details for a note. (numeric)
#' @param source Name of source (or list of sources) to get ALM information for (character)
#' @param key your PLoS API key, either enter, or loads from .Rprofile (character)
#' @param ... optional additional curl options (debugging tools mostly)
#' @param curl If using in a loop, call getCurlHandle() first and pass
#'    the returned value in here (avoids unnecessary footprint)
#' @param total_details If FALSE (the default) the standard totals data.frame is
#'    returned; if TRUE, the totals data is in a wide format with more details
#'    about the paper, including publication date, title, etc. If you set this 
#'    to TRUE, the output should no longer with with \code{\link{almplot}}.
#' @param sum_metrics Just like the output you get from setting info='totals', you can 
#'    get summary metrics by day (sum_metrics='day'), month (sum_metrics='month'), 
#'    or year (sum_metrics='year').