\name{plot_density}
\alias{plot_density}
\title{Density plots from PLOS Article Level Metrics data}
\usage{
  plot_density(input, source = "scopus_citations",
    color = "#1ebd21")
}
\arguments{
  \item{input}{A data.frame, usuaally from a call to
  \code{link{alm}}.}

  \item{source}{Data source (column) to plot. Can be a
  single element, or a character vector.}

  \item{color}{Color of the density plot and the title. Can
  be a hex color or rgb, etc.}
}
\description{
  Density plots from PLOS Article Level Metrics data
}
\examples{
\dontrun{
library(rplos); library(plyr)
dois <- searchplos(terms='*:*', fields="id", toquery=list('cross_published_journal_key:PLoSONE', 'doc_type:full', 'publication_date:[2010-01-01T00:00:00Z TO 2010-12-31T23:59:59Z]'), limit=200)
alm <- alm(doi=do.call(c,dois$id), total_details=TRUE)
alm <- ldply(alm)
plot_density(alm)
plot_density(input=alm, source="crossref_citations")
plot_density(input=alm, source="counter_total")
plot_density(input=alm, source=c("counter_total","crossref_citations"))
plot_density(input=alm, source=c("counter_total","crossref_citations","twitter_total"))
plot_density(input=alm, source=c("counter_total","crossref_citations","twitter_total","wos_citations"))
}
}
\author{
  Martin Fenner, mfenner@plos.org, modified by Scott
  Chamberlain
}

