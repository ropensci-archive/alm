\name{signposts}
\alias{signposts}
\title{Retrieve PLOS article-level metrics signposts.}
\usage{
  signposts(doi = NULL, pmid = NULL, pmcid = NULL,
    mdid = NULL,
    url = "http://alm.plos.org/api/v3/articles",
    info = "totals", months = NULL, days = NULL,
    year = NULL, source = NULL, key = NULL,
    curl = getCurlHandle(), total_details = FALSE,
    sum_metrics = NULL)
}
\arguments{
  \item{doi}{Digital object identifier for an article in
  PLoS Journals (character)}

  \item{pmid}{PubMed object identifier (numeric)}

  \item{pmcid}{PubMed Central object identifier (numeric)}

  \item{mdid}{Mendeley object identifier (character)}

  \item{url}{API endpoint, defaults to
  http://alm.plos.org/api/v3/articles (character)}

  \item{info}{One of summary, history, or detail(default
  totals + history in a list).  Not specifying anything
  (the default) returns data.frame of totals across data
  providers. (character)}

  \item{months}{Number of months since publication to
  request historical data for.  See details for a note.
  (numeric)}

  \item{days}{Number of days since publication to request
  historical data for.  See details for a note. (numeric)}

  \item{year}{End of which year to request historical data
  for.  See details for a note. (numeric)}

  \item{source}{Name of source (or list of sources) to get
  ALM information for (character)}

  \item{key}{your PLoS API key, either enter, or loads from
  .Rprofile (character)}

  \item{...}{optional additional curl options (debugging
  tools mostly)}

  \item{curl}{If using in a loop, call getCurlHandle()
  first and pass the returned value in here (avoids
  unnecessary footprint)}

  \item{total_details}{If FALSE (the default) the standard
  totals data.frame is returned; if TRUE, the totals data
  is in a wide format with more details about the paper,
  including publication date, title, etc. If you set this
  to TRUE, the output should no longer with with
  \code{\link{almplot}}.}

  \item{sum_metrics}{Just like the output you get from
  setting info='totals', you can get summary metrics by day
  (sum_metrics='day'), month (sum_metrics='month'), or year
  (sum_metrics='year').}
}
\value{
  A data.frame of the signpost numbers for the searched
  object.
}
\description{
  This includes: \itemize{ \item views: counter + pmc (PLOS
  only) \item shares: facebook (+ twitter at PLOS) \item
  bookmarks: mendeley + citeulike \item citations: crossref
  (scopus at PLOS) }
}
\examples{
\dontrun{
# The default call with either doi, pmid, pmcid, or mdid without specifying
# an argument for info
signposts(doi="10.1371/journal.pone.0029797")

# Many DOIs
dois <- c('10.1371/journal.pone.0001543','10.1371/journal.pone.0040117','10.1371/journal.pone.0029797','10.1371/journal.pone.0039395')
signposts(doi=dois)

# A single PubMed ID (pmid)
signposts(pmid=22590526)

# A single PubMed Central ID (pmcid)
signposts(pmcid=212692)

# A single Mendeley UUID (mdid)
signposts(mdid="35791700-6d00-11df-a2b2-0026b95e3eb7")
}
}
\seealso{
  \code{\link{alm}}
}

