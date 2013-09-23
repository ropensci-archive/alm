#' Density plots from PLOS Article Level Metrics data
#'
#' @import ggplot2
#' @importFrom grid unit grid.text gpar viewport grid.newpage
#' @importFrom reshape2 melt
#' @importFrom plyr round_any
#' @importFrom lubridate year
#' @param input A data.frame, usuaally from a call to \code{link{alm}}.
#' @param source Data source (column) to plot. Can be a single element, or a
#'    character vector.
#' @param color Color of the density plot and the title. Can be a hex color or 
#'    rgb, etc.
#' @author Martin Fenner, mfenner@@plos.org, modified by Scott Chamberlain
#' @examples \dontrun{
#' library(rplos); library(plyr)
#' dois <- searchplos(terms='*:*', fields="id", toquery=list('cross_published_journal_key:PLoSONE', 'doc_type:full', 'publication_date:[2010-01-01T00:00:00Z TO 2010-12-31T23:59:59Z]'), limit=200)
#' alm <- alm(doi=do.call(c,dois$id), total_details=TRUE)
#' alm <- ldply(alm)
#' plot_density(alm)
#' plot_density(input=alm, source="crossref_citations")
#' plot_density(input=alm, source="counter_total")
#' plot_density(input=alm, source=c("counter_total","crossref_citations"))
#' plot_density(input=alm, source=c("counter_total","crossref_citations","twitter_total"))
#' plot_density(input=alm, source=c("counter_total","crossref_citations","twitter_total","wos_citations"))
#' }
#' @export

plot_density <- function(input, source="scopus_citations", color="#1ebd21")
{
  input$publication_date <- as.Date(input$publication_date)
  
  # Labels
  jrnls <- sapply(as.character(input$doi), function(x) strsplit(x, "\\.")[[1]][[3]], USE.NAMES=FALSE)
  jrnl_doi_abbrev <- c("pone","pgen","ppat","pcbi","pbio","pntd","pmed","pctr")
  jrnl_lkup <- data.frame(abbrevs=jrnl_doi_abbrev, names=c("PLOS One","PLOS Genetics","PLOS Pathogens","PLOS CompBiol","PLOS Biology","PLOS NTD","PLOS Medicine","PLOS ClinicalTrials"), stringsAsFactors=FALSE)
  indata <- jrnl_doi_abbrev[jrnl_doi_abbrev %in% unique(jrnls)]
  journals <- jrnl_lkup[jrnl_lkup$abbrevs %in% indata, "names"]
  
  yrs <- unique(year(input$publication_date))
  
  plos_xlab <- capwords(gsub("_"," ",source))
  plos_title <- sprintf("%s for %s %s Papers", paste0(plos_xlab,collapse=","), yrs, paste0(journals,collapse=","))
  plos_description <- sprintf("%s plotted as a probability distribution for all %s %s research articles published in %s. Data collected %s.", paste0(plos_xlab,collapse=","), nrow(input), journals, yrs, (as.Date(input$date_modified[1])))
  
  # Calculate quantiles and min/max x-axis limits
  minmax <- c(0, round_any(max(input[,source]), 10, f=ceiling))
  
  # Plot
  if(length(source)==1){
    p <- ggplot(input, aes_string(x=source)) +
      theme_bw(base_size=16) +
      geom_density(fill=color, colour=color) +
      theme(panel.grid.major=element_blank(),
            panel.grid.minor=element_blank(),
            panel.border=element_blank(),
            axis.line = element_line(color = 'black'),
            plot.title = element_text(colour=color, size=24, hjust=0),
            plot.margin = unit(c(4,1,1,1), "cm")) +
      scale_x_continuous(limits=minmax) +
      labs(x="", y="")
    
    grid.newpage()
    vpb_ <- viewport(width = 1, height = 1)
    print(p, vp = vpb_)
    grid.text(plos_title, x=0.1, y=0.95, just="left", gp=gpar(cex=2, col=color))
    grid.text(paste(strwrap(plos_description,width=90), collapse="\n"), x=0.1, y=0.87, just="left", gp=gpar(cex=1))
    grid.text(plos_xlab, x=0.9, y=0.04, just="right", gp=gpar(cex=1, col=color))
  } else
  {
    df <- input[,source]
    dfm <- melt(df)
    p <- ggplot(dfm, aes(x=value)) +
      theme_bw(base_size=16) +
      geom_density(fill=color, colour=color) +
      theme(panel.grid.major=element_blank(),
            panel.grid.minor=element_blank(),
            panel.border=element_blank(),
            axis.line = element_line(color = 'black'),
            plot.title = element_text(colour=color, size=24, hjust=0),
            plot.margin = unit(c(4,1,1,1), "cm")) +
      labs(x="", y="") +
      facet_wrap(~variable, scales="free")
    
    plos_title <- sprintf("Altmetrics for %s %s Papers", yrs, paste0(journals,collapse=","))
    plos_description <- sprintf("Probability distributions for all %s %s research articles published in %s. Data collected %s.", nrow(input), journals, yrs, (as.Date(input$date_modified[1])))
    
    grid.newpage()
    vpb_ <- viewport(width = 1, height = 1)
    print(p, vp = vpb_)
    grid.text(plos_title, x=0.1, y=0.95, just="left", gp=gpar(cex=2, col=color))
    grid.text(paste(strwrap(plos_description,width=90), collapse="\n"), x=0.1, y=0.87, just="left", gp=gpar(cex=1))
  }
}