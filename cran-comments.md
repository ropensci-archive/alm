R CMD CHECK passed on my local OS X install with R 3.1.1, R 3.1.2 RC and R development version, Ubuntu running on Travis-CI, and Win builder.

I apologize for submitting a new version only 2 weeks after the previous, but a change in the API this package works with was made. 

I see two notes in R CMD CHECK. One is about rCharts, which is not on CRAN, but I point out where to obtain it in the Description field of the DESCRIPTION file. Another note points out possibly mis-spelled words, which are not mis-spelled. 

In addition, I made the REAMDE file WC3 compliant on Kurt Hornik's request.

Note that I changed the title in the DESCRIPTION file slightly to match a name change in the service this package interacts with.

Thanks! Scott Chamberlain
