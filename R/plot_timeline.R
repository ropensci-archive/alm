plot_timeline <- function()
{
  message("Function now written yet")
}
# library(alm); library(reshape2); library(reshape); library(rCharts)
# dois <- c('10.1371/journal.pone.0001543','10.1371/journal.pone.0040117','10.1371/journal.pone.0039395')
# out <- alm(doi=dois, info="history")
# out2 <- lapply(out, function(x) x[ x$.id == "facebook", c("dates","totals")])
# temp <- merge(out2[[1]], out2[[2]], all = TRUE, sort = FALSE, by="dates")
# temp <- merge(temp, out2[[3]], all = TRUE, sort = FALSE, by="dates")
# names(temp)[2:4] <- sapply(dois[1:3], function(x) strsplit(x, "\\.")[[1]][[4]], USE.NAMES=FALSE)
# # out <- alm(doi="10.1371/journal.pone.0029797", info="history")
# # out2 <- dcast(out, dates ~ .id, fun.aggregate=sum)
# m1 <- mPlot(x = "dates", y = names(temp)[2:4], type = "Line", data = temp)
# m1$set(pointSize = 0, lineWidth = 1)
# m1