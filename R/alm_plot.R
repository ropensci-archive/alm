#' Plot results of a call to the alm function.
#'
#' @import ggplot2
#' @importFrom grid grid.newpage pushViewport viewport grid.layout
#' @importFrom reshape2 melt
#' @importFrom plyr ldply
#' @export
#' 
#' @param dat Output from \code{alm_ids} (character)
#' @param type One of totalmetrics or history
#' @param removezero Remove data sources with all zeros prior to plotting.
#' @return A ggplot2 bar plot for `totalmetrics` or line plot for `history`.
#' @details You have to specify info='detail' in your call to \code{alm_ids} so that
#' 		you get history and summary data so that either or both can be plotted
#' 		in this function.
#' @seealso \code{\link{alm_ids}} which is required to use this function.
#' @references See a tutorial/vignette for alm at
#' \url{http://ropensci.org/tutorials/alm_tutorial.html}
#' @examples \dontrun{
#' out <- alm_ids(doi='10.1371/journal.pone.0001543', info='detail')
#' alm_plot(out)
#' # works from info=totals too
#' out <- alm_ids(doi='10.1371/journal.pone.0001543', info='totals')
#' alm_plot(out)
#' }
alm_plot <- function(dat){
  .id <- value <- variable <- dates <- totals <- NULL
  
  if("totals" %in% names(dat$data)){
    dat_m <- melt(dat$data$totals, id.vars=".id")
  } else {
    dat_m <- melt(dat$data, id.vars=".id")
  }
  dat_m <- na.omit(dat_m)
  ggplot(dat_m, aes(x = .id, y = value, fill = variable)) +
    geom_bar(position="dodge", stat="identity") +
    theme_bw(base_size=18) +
    coord_flip() +
    scale_fill_discrete("Metric") +
    labs(y = 'Count')
}
