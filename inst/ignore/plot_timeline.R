# plot_timeline <- function()
# {
#   message("Function now written yet")
# }
# library(alm); library(reshape2); library(reshape); library(rCharts)
# dois <- c('10.1371/journal.pone.0001543','10.1371/journal.pone.0040117','10.1371/journal.pone.0039395')
# out <- alm(doi=dois, info="history")
# out2 <- lapply(out, function(x) x[ x$.id == "pmc", c("dates","totals")])
# temp <- merge(out2[[1]], out2[[2]], all = TRUE, sort = FALSE, by="dates")
# temp <- merge(temp, out2[[3]], all = TRUE, sort = FALSE, by="dates")
# names(temp)[2:4] <- sapply(dois[1:3], function(x) strsplit(x, "\\.")[[1]][[4]], USE.NAMES=FALSE)
# # out <- alm(doi="10.1371/journal.pone.0029797", info="history")
# # out2 <- dcast(out, dates ~ .id, fun.aggregate=sum)
# m1 <- mPlot(x = "dates", y = names(temp)[2:4], type = "Line", data = temp)
# m1$set(pointSize = 0, lineWidth = 1)
# m1


#####
# library(alm); library(reshape2); library(reshape); library(rCharts)
# dois <- c('10.1371/journal.pone.0001543','10.1371/journal.pone.0040117','10.1371/journal.pone.0039395')
# out <- alm(doi=dois, info="history")
# out2 <- lapply(out, function(x) x[ x$.id == "counter", c("dates","totals")])
# 
# formatt <- function(x){
#   x$dates <- as.Date(x$dates)
#   tt <- sort_df(x, "dates")
#   tt$dates <- as.character(tt$dates)
#   tt[is.na(tt)] <- 0
#   tt
# }
# 
# out3 <- lapply(out2, formatt)
# 
# h1 <- hPlot(
#   totals ~ dates,
#   data = out3[[2]],
#   type = "column"
# )
# h1$xAxis(labels ='{enabled: false}', ticks = '{enabled: false}')
# h1$yAxis(gridLineWidth = 0, title = 'false')
# # h1$yAxis(gridLineWidth = 0, title = 'false', labels = '{step: 2}')
# h1$chart(width=900, height=200)
# h1
# h1$plotOptions(series = '{color: #}')
# h$tooltip()
# h1$print()
# h1$colors("#799AA2")
# h1$plotOptions(column = '{colorByPoint: true}')


# m1 <- mPlot(x = "date", y = c("psavert", "uempmed"), type = "Bar", data = econ)
# m1
# 
# 
# h1 <- Highcharts$new()
# h1$chart(type = "bar")
# h1$series(data = c(1, 3, 2, 4, 5, 4, 6, 2, 3, 5, NA), dashStyle = "longdash")
# h1$series(data = c(NA, 4, 1, 3, 4, 2, 9, 1, 2, 3, 4), dashStyle = "shortdot")
# h1$legend(symbolWidth = 80)
# h1
# 
# df=data.frame(name=c("US", "GB", "RU"), value=c(5,1,8))
# df <- df[order(df$value),]
# h1 <- hPlot(
#   value ~ name,
#   data = df,
#   type = "column"
# )
# h1