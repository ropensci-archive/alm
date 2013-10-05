#' Bubble chart
#' @import ggplot2 scales
#' @importFrom grid unit grid.text gpar viewport grid.newpage
#' @importFrom reshape2 melt
#' @importFrom plyr round_any
#' @importFrom lubridate year
#' @param input A data.frame, usuaally from a call to \code{link{alm}}.
#' @param source Data source (column) to plot. Can be a single element, or a
#'    character vector.
#' @param color Color of the density plot and the title. Can be a hex color or 
#'    rgb, etc.
#' @param title Title for the plot, in top matching the color of the density plot.
#' @param description Optional description, subtending the title. 
#' @param symbol Symbol type, see ?pch for possible values.
#' @author Martin Fenner, mfenner@@plos.org, modified by Scott Chamberlain
#' @examples \dontrun{
#' library(rplos); library(plyr); library(scales)
dois <- searchplos(terms='*:*', fields="id", 
  toquery=list('cross_published_journal_key:PLoSONE', 'doc_type:full', 
  'publication_date:[2010-01-01T00:00:00Z TO 2010-12-31T23:59:59Z]'), limit=500)
alm <- alm(doi=do.call(c,dois$id), total_details=TRUE)
alm <- ldply(alm)
plot_scatter(input=alm, plotbyvar="scopus_citations")
plot_scatter(input=alm, plotbyvar="pmc_total")

# plot_scatter(input=alm2, plotbyvar="scopus")

dois <- searchplos(terms='*:*', fields="id", 
                   toquery=list('cross_published_journal_key:PLoSONE', 'doc_type:full'), limit=100)
alm <- alm(doi=do.call(c,dois$id), total_details=TRUE)
alm <- ldply(alm)
plot_scatter(input=alm, plotbyvar="scopus_citations")
#' }
#' @export

plot_scatter <- function(input, plotbyvar, color="#1ebd21")
{
  theme_scatter <- function(){
    list(theme_bw(base_size=16),
         theme(panel.grid.major=element_blank(),
               panel.grid.minor=element_blank(),
               panel.border = theme_blank(),
               legend.position="none",
               axis.line = theme_segment(colour = "black")),
         labs(x="", y=""))
  }
  
  if(!inherits(input,"data.frame"))
    stop("input must be a data.frame")
  
  input <- input[order(input[,plotbyvar], decreasing = TRUE),]
  input$publication_date <- as.Date(input$publication_date)
  
  ggplot(input, aes_string(x="publication_date", y="counter_total", size=plotbyvar)) +
    geom_point(colour=color) +
    scale_x_date(labels = date_format("%b/%y")) +
    theme_scatter() +
    labs(y="Views",x="")
}