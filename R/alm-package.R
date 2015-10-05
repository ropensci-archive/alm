#' R client for the open source article level metrics Lagotto application.
#'
#' An R interface to the RESTful API from the open source article level metrics
#' software Lagotto, created by the Public Library of Science (PLOS). A number of 
#' publishers are using Lagotto, so you can drop in a different base URL to the 
#' functions in this package to get to not only PLOS data, but
#' data for Crossref, and more.
#'
#' Authenication was required, but has now been removed going foward in Lagotto. 
#' You only need API keys for a few of the data providers that are running old 
#' versions of Lagotto, and that will change as they upgrade their Lagotto sofware.
#'
#' @importFrom methods is
#' @importFrom stats setNames na.omit
#' @importFrom stringr str_replace_all str_split
#' @importFrom reshape sort_df
#' @importFrom plyr rbind.fill
#' @importFrom httr GET POST content stop_for_status add_headers
#' @name alm-package
#' @aliases alm
#' @docType package
#' @title R client for the open source article level metrics Lagotto application.
#' @author Scott Chamberlain \email{myrmecocystus@@gmail.com}
#' @keywords package
NULL
