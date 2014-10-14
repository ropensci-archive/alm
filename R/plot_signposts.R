#' Plot PLOS article-level metrics data.
#'
#' This can be used in conjuction with the function \code{\link{alm_signposts}}.
#'
#' @import ggplot2
#' @importFrom reshape2 melt
#' @export
#' 
#' @param input A data.frame from a search from the \code{\link{alm_signposts}} function
#' @param type Type of chart, one of bar (default), multiBarChart, or
#'    multiBarHorizontalChart. multiBarChart or multiBarHorizontalChart
#'    options use the library rCharts, specifically the NVD3 javascript library.
#'    Choosing multiBarChart or multiBarHorizontalChart opens a visualization in
#'    your default browser, while option bar makes a ggplot2 plot within your R session.
#' @param width Only applies with type="interactive", otherwise ignored. Width of
#'    the plotting area.
#' @param height Only applies with type="interactive", otherwise ignored. Height of
#'    the plotting area.
#' @details Note that DOIs are the unit of replication of each study. When plotting,
#' if the prefix is common among all DOIs, then just the end of the DOI, the numeric
#' part is printed to make plots less ugly.
#' @seealso \code{\link{alm_ids}}, \code{\link{plot_signposts}}
#' @return A data.frame of the signpost numbers for the searched object.
#' @references See a tutorial/vignette for alm at
#' \url{http://ropensci.org/tutorials/alm_tutorial.html}
#' @examples \dontrun{
#' # Plot data from a single identifier gives a bar chart
#' dat <- alm_signposts(doi="10.1371/journal.pone.0029797")
#' plot_signposts(input=dat)
#'
#' # Plot data from many identifiers gives a line chart
#' dois <- c('10.1371/journal.pone.0001543','10.1371/journal.pone.0040117',
#'    '10.1371/journal.pone.0029797','10.1371/journal.pone.0039395')
#' dat <- alm_signposts(doi=dois)
#' plot_signposts(input=dat)
#'
#' # Or you can make an interactive chart
#' plot_signposts(input=dat, type="multiBarChart")
#'
#' # Many DOIs
#' library('rplos'); library('rCharts')
#' dois <- searchplos(q='evolution', fl='id',
#'    fq=list('-article_type:correction','doc_type:full'), limit = 10)
#' dat <- alm_signposts(doi=dois$id)
#' ## multiBarChart
#' plot_signposts(input=dat, type="multiBarChart")
#' ## multiBarHorizontalChart
#' plot_signposts(input=dat, type="multiBarHorizontalChart")
#' }

plot_signposts <- function(input, type="bar", width=800, height=500)
{
  stripdois <- function(x){
    temp <- strsplit(as.character(x$doi), "\\.")
    if(all(sapply(temp, function(x) paste0(x[1:3],collapse="")) %in% sapply(temp, function(x) paste0(x[1:3],collapse=""))[[1]])){
      doi_parts <- sapply(strsplit(as.character(x$doi), "\\."), "[[", 4)
      x <- x[,-1]
      x$doi <- doi_parts
      x
    } else
    { x }
  }

  if(!is.data.frame(input))
    stop("object passed to input must be a data.frame")

  if(nrow(input)==1){
    df <- melt(input)
    ggplot(df, aes(variable, value)) +
      theme_grey(base_size=16) +
      geom_bar(stat="identity") +
      labs(x="",y="")
  } else
  if(type=="bar"){
    input <- stripdois(input)
    df <- melt(input)
    ggplot(df, aes(doi, value)) +
      theme_grey(base_size=16) +
      geom_bar(stat="identity") +
      facet_wrap(~variable, scales="free") +
      labs(x="",y="")
  } else
  {
    input <- stripdois(input)
    df <- melt(input)
    n <- nPlot(value ~ doi, group = "variable", data = df, type = type)
    n$set(width = width, height = height)
    if(type=="multiBarChart")
      n$chart(reduceXTicks = FALSE)
    n
  }
}
