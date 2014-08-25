#' R client for the open source article level metrics ALM application.
#'
#' An R interface to the open source article level metrics API
#' created by the Public Library of Science (PLOS). A number of publishers are
#' using the open source app created by PLOS, so you can drop in a different
#' base URL to the functions in this package to get to not only PLOS data, but
#' data for Crossref, and more as the open source PLOS software is used.
#'
#' You need API keys for each of the endpoints you use.
#'
#' @name alm-package
#' @aliases alm
#' @docType package
#' @title R client for the open source article level metrics ALM application.
#' @author Scott Chamberlain \email{myrmecocystus@@gmail.com}
#' @keywords package
NULL

#' Defunct functions in alm
#'
#' \itemize{
#'  \item \code{\link{alm_pubmedid}}: Function removed, you can get this info using alm_ids
#'  \item \code{\link{alm_pubmedcentid}}: Function removed, you can get this info using alm_ids
#'  \item \code{\link{almupdated}}: Function removed, you can get this info using alm_ids
#'  \item \code{\link{almdateupdated}}: Function removed, you can get this info using alm_ids
#'  \item \code{\link{alm_totals}}: Function removed, you can get this info using alm_ids
#' }
#'
#' @name alm-defunct
NULL
