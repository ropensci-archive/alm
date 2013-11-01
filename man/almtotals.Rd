\name{almtotals}
\alias{almtotals}
\title{Alt-metrics total citations from all sources.}
\usage{
  almtotals(doi, key = NULL, curl = getCurlHandle())
}
\arguments{
  \item{doi}{digital object identifier for an article in
  PLoS Journals}

  \item{key}{your PLoS API key, either enter, or loads from
  .Rprofile}

  \item{curl}{If using in a loop, call getCurlHandle()
  first and pass the returned value in here (avoids
  unnecessary footprint)}
}
\value{
  data.frame of total no. views (counter + pmc), shares
  (facebook + twitter), bookmarks (mendeley + citeulike),
  and citations (crossref)
}
\description{
  Alt-metrics total citations from all sources.
}
\examples{
\dontrun{
almtotals(doi = '10.1371/journal.pbio.0000012')
}
}
\references{
  See a tutorial/vignette for alm at
  \url{http://ropensci.org/tutorials/alm_tutorial.html}
}

