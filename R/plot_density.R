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
#' @param title Title for the plot, in top matching the color of the density plot.
#' @param description Optional description, subtending the title. 
#' @author Martin Fenner, mfenner@@plos.org, modified by Scott Chamberlain
#' @examples \dontrun{
#' library(rplos); library(plyr)
#' dois <- searchplos(terms='*:*', fields="id", toquery=list('cross_published_journal_key:PLoSONE', 'doc_type:full', 'publication_date:[2010-01-01T00:00:00Z TO 2010-12-31T23:59:59Z]'), limit=200)
#' alm <- alm(doi=do.call(c,dois$id), total_details=TRUE)
#' alm <- ldply(alm)
#' plot_density(alm)
#' plot_density(alm, color="#DCA121")
#' plot_density(alm, title="Scopus citations from 2010")
#' plot_density(alm, title="Scopus citations from 2010", description="Probablity of X number of citations for a paper")
#' plot_density(alm, description="Probablity of X number of citations for a paper")
#' plot_density(input=alm, source="crossref_citations")
#' plot_density(input=alm, source="twitter_total")
#' plot_density(input=alm, source="counter_total")
#' plot_density(input=alm, source=c("counter_total","crossref_citations"))
#' plot_density(input=alm, source=c("counter_total","crossref_citations"))
#' plot_density(input=alm, source=c("counter_total","crossref_citations","twitter_total"))
#' plot_density(input=alm, source=c("counter_total","crossref_citations","twitter_total"), color=c("#DBAC6A", "#E09B33", "#A06D34"))
#' plot_density(input=alm, source=c("counter_total","crossref_citations","twitter_total","wos_citations"))
#' plot_density(input=alm, source=c("counter_total","crossref_citations"), title="Counter, Crossref, Twitter, and Web of Science")
#' plot_density(input=alm, source=c("counter_total","crossref_citations","twitter_total","wos_citations"), color=c("#83DFB4","#EFA5A5","#CFD470","#B2C9E4"))
#' }
#' @export

plot_density <- function(input, source="scopus_citations", color="#1447f2", 
                         title = "", description = "")
{
  plos_color <- "#1447f2"
  input$publication_date <- as.Date(input$publication_date)
  
  # Labels
  jrnls <- sapply(as.character(input$doi), function(x) strsplit(x, "\\.")[[1]][[3]], USE.NAMES=FALSE)
  jrnl_doi_abbrev <- c("pone","pgen","ppat","pcbi","pbio","pntd","pmed","pctr")
  jrnl_lkup <- data.frame(abbrevs=jrnl_doi_abbrev, names=c("PLOS One","PLOS Genetics","PLOS Pathogens","PLOS CompBiol","PLOS Biology","PLOS NTD","PLOS Medicine","PLOS ClinicalTrials"), stringsAsFactors=FALSE)
  indata <- jrnl_doi_abbrev[jrnl_doi_abbrev %in% unique(jrnls)]
  journals <- jrnl_lkup[jrnl_lkup$abbrevs %in% indata, "names"]
  yrs <- unique(year(input$publication_date))  
  plos_xlab <- capwords(gsub("_"," ",source))

  # Calculate quantiles and min/max x-axis limits
  minmax <- c(0, round_any(max(input[,source]), 10, f=ceiling))
  
  # Determine margin at top of plot
  if(nchar(title)==0 && nchar(description)!=0 | nchar(description)==0 && nchar(title)!=0){
    plot_margin <- 2
  } else if(nchar(description)!=0 && nchar(title)!=0){
    plot_margin <- 4
  } else if(nchar(description)==0 && nchar(title)==0){
    plot_margin <- 1
  }
  
  theme_density <- function(){
    list(theme_bw(base_size=16),
         theme(panel.grid.major=element_blank(),
               panel.grid.minor=element_blank(),
               panel.border=element_blank(),
               axis.line = element_line(color = 'black'),
               plot.title = element_text(colour=plos_color, size=24, hjust=0),
               plot.margin = unit(c(plot_margin,1,1,1), "cm")),
         labs(x="", y=""))
  }
  # Plot
  if(length(source)==1){
    p <- 
    ggplot(input, aes_string(x=source)) +
      theme_density() +
      geom_density(fill=plos_color, colour=plos_color) +
      scale_x_continuous(limits=minmax)
    grid.newpage()
    print(p, vp = viewport(width = 1, height = 1))
    grid.text("Probabilty", x=0.03, y=0.5, rot=90, gp=gpar(cex=1, col=plos_color))
    grid.text(plos_xlab, x=0.5, y=0.04, gp=gpar(cex=1, col=plos_color))
    if(nchar(title)==0 & nchar(description)!=0){
      grid.text(paste(strwrap(description,width=90), collapse="\n"), x=0.1, y=0.95, just="left", gp=gpar(cex=1))
    } else if(nchar(description)==0 & nchar(title)!=0){
      grid.text(title, x=0.1, y=0.95, just="left", gp=gpar(cex=2, col=plos_color))
    } else if(nchar(description)!=0 & nchar(title)!=0){
      grid.text(title, x=0.1, y=0.95, just="left", gp=gpar(cex=2, col=plos_color))
      grid.text(paste(strwrap(description,width=90), collapse="\n"), x=0.1, y=0.87, just="left", gp=gpar(cex=1))
    }
  } else
  {
    if(length(color)==1){
      colors <- rep(color,length(source))
    } else
    {
      colors <- color
    }
    df <- input[,source]
    dfm <- melt(df)
    p <- ggplot(dfm, aes(x=value, fill=variable, colour=variable)) +
      theme_density() +
      geom_density() +
      theme(legend.position="none") +
      facet_wrap(~variable, scales="free") +
      scale_colour_manual(values = colors) +
      scale_fill_manual(values = colors)
    grid.newpage()
    print(p, vp = viewport(width = 1, height = 1))
    grid.text("Probabilty", x=0.03, y=0.5, rot=90, gp=gpar(cex=1))
    grid.text(plos_xlab, x=0.5, y=0.04, gp=gpar(cex=1))
    if(nchar(title)==0 & nchar(description)!=0){
      grid.text(paste(strwrap(description,width=90), collapse="\n"), x=0.1, y=0.95, just="left", gp=gpar(cex=1))
    } else if(nchar(description)==0 & nchar(title)!=0){
      grid.text(title, x=0.1, y=0.95, just="left", gp=gpar(cex=2))
    } else if(nchar(description)!=0 & nchar(title)!=0){
      grid.text(title, x=0.1, y=0.95, just="left", gp=gpar(cex=2))
      grid.text(paste(strwrap(description,width=90), collapse="\n"), x=0.1, y=0.87, just="left", gp=gpar(cex=1))
    }
  }
}