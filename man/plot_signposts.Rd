\name{plot_signposts}
\alias{plot_signposts}
\title{Plot PLOS article-level metrics data.}
\usage{
  plot_signposts(input, type = "bar", width = 800,
    height = 500)
}
\arguments{
  \item{input}{A data.frame from a search from the
  \code{\link{signposts}} function}

  \item{type}{Type of chart, one of bar (default),
  multiBarChart, or multiBarHorizontalChart. multiBarChart
  or multiBarHorizontalChart options use the library
  rCharts, specifically the NVD3 javascript library.
  Choosing multiBarChart or multiBarHorizontalChart opens a
  visualization in your default browser, while option bar
  makes a ggplot2 plot within your R session.}

  \item{width}{Only applies with type="interactive",
  otherwise ignored. Width of the plotting area.}

  \item{height}{Only applies with type="interactive",
  otherwise ignored. Height of the plotting area.}
}
\value{
  A data.frame of the signpost numbers for the searched
  object.
}
\description{
  This can be used in conjuction with the function
  \code{\link{signposts}}.
}
\details{
  Note that DOIs are the unit of replication of each study.
  When plotting, if the prefix is common among all DOIs,
  then just the end of the DOI, the numeric part is printed
  to make plots less ugly.
}
\examples{
\dontrun{
# Plot data from a single identifier gives a bar chart
dat <- signposts(doi="10.1371/journal.pone.0029797")
plot_signposts(input=dat)

# Plot data from many identifiers gives a line chart
dois <- c('10.1371/journal.pone.0001543','10.1371/journal.pone.0040117',
   '10.1371/journal.pone.0029797','10.1371/journal.pone.0039395')
dat <- signposts(doi=dois)
plot_signposts(input=dat)

# Or you can make an interactive chart
plot_signposts(input=dat, type="multiBarChart")

# Lots of DOIs
library(rplos); library(rCharts)
dois <- searchplos('ecology', 'id', limit = 30)
dat <- signposts(doi=do.call(c,dois$id))
## multiBarChart
plot_signposts(input=dat, type="multiBarChart")
## multiBarHorizontalChart
plot_signposts(input=dat, type="multiBarHorizontalChart")
}
}
\references{
  See a tutorial/vignette for alm at
  \url{http://ropensci.org/tutorials/alm_tutorial.html}
}
\seealso{
  \code{\link{alm}}, \code{\link{plot_signposts}}
}

