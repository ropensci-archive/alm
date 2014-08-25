

<pre>
       .__
_____  |  |   _____
\__  \ |  |  /     \
 / __ \|  |_|  Y Y  \
(____  /____/__|_|  /
     \/           \/
</pre>

|Platform|master|dev|
|----|----|----|
|Linux|[![Build Status](https://api.travis-ci.org/ropensci/alm.png?branch=master)](https://travis-ci.org/ropensci/alm?branch=master)|[![Build Status](https://api.travis-ci.org/ropensci/alm.png?branch=dev)](https://travis-ci.org/ropensci/alm?branch=dev)|
|Windows|[![Build status](https://ci.appveyor.com/api/projects/status/w7mrpr5owh9deepq/branch/master)](https://ci.appveyor.com/project/sckott/alm/branch/master)|[![Build status](https://ci.appveyor.com/api/projects/status/w7mrpr5owh9deepq/branch/dev)](https://ci.appveyor.com/project/sckott/alm/branch/dev)|

## What it is!?

`alm` is a set of functions to access article level metrics from the Public Library of Science journals using their ALM API.


## What is an article level metric?

Glad you asked. The canonical URL for this is perhaps [altmetrics.org](http://altmetrics.org/manifesto/). Basically it is a metric that measures something about an article. This is in stark contrast to journal level metrics, like the Journal Impact Factor.

## Are there other altmetrics data providers?

Yes indeedy.

+ [ImpactStory](http://impactstory.it/)
+ [Altmetric.com](http://altmetric.com/)
+ [PlumAnalytics](http://www.plumanalytics.com/)

## Authentication

You aren't currently not required to use an API key to access the PLoS ALM API, but soon will need to.

Get your PLoS API key [here](http://api.plos.org/)

Put your API key in your .Rprofile file using exactly this:
options(PlosApiKey = "YOUalmAPIKEY"),
and the functions within this package will be able to use your API key without you having to enter it every time you run a search.

## Quick start

### Install

You can get this package from CRAN by:


```r
install.packages("alm")
```


Or the development version by installing with `install_github()`


```r
install.packages("devtools")
library('devtools')
install_github("ropensci/alm")
```

Load the package


```r
library('alm')
```

The first function we'll look at is `alm_ids()`, named with `ids` since we search for data by one of four different choices of identifier.

### Get altmetrics data for a single paper


```r
alm_ids(doi = "10.1371/journal.pone.0029797")
```

```
## $meta
##   total total_pages page error
## 1     1           1    1    NA
## 
## $data
##                       .id  pdf  html readers comments likes  total
## 1               citeulike   NA    NA       1       NA    NA      1
## 2                crossref   NA    NA      NA       NA    NA      8
## 3                  nature   NA    NA      NA       NA    NA      4
## 4                  pubmed   NA    NA      NA       NA    NA      2
## 5                  scopus   NA    NA      NA       NA    NA      7
## 6                 counter 2487 30224      NA       NA    NA  32825
## 7        researchblogging   NA    NA      NA       NA    NA      1
## 8                     wos   NA    NA      NA       NA    NA      7
## 9                     pmc   68   467      NA       NA    NA    535
## 10               facebook   NA    NA     149       22    60    231
## 11               mendeley   NA    NA      78       NA    NA     78
## 12                twitter   NA    NA      NA       12    NA     12
## 13              wikipedia   NA    NA      NA       NA    NA     48
## 14          scienceseeker   NA    NA      NA       NA    NA      0
## 15         relativemetric   NA    NA      NA       NA    NA 157436
## 16                  f1000   NA    NA      NA       NA    NA      0
## 17               figshare    0    18      NA       NA     0     18
## 18              pmceurope   NA    NA      NA       NA    NA      4
## 19          pmceuropedata   NA    NA      NA       NA    NA     49
## 20            openedition   NA    NA      NA       NA    NA      0
## 21              wordpress   NA    NA      NA       NA    NA      0
## 22                 reddit   NA    NA      NA        0     0      0
## 23               datacite   NA    NA      NA       NA    NA      0
## 24             copernicus   NA    NA      NA       NA    NA      0
## 25        articlecoverage   NA    NA      NA        0    NA      0
## 26 articlecoveragecurated   NA    NA      NA        0    NA      0
## 27          plos_comments   NA    NA      NA       11    NA     16
```

### Details for a single DOI



```r
alm_ids(doi = "10.1371/journal.pone.0029797", info = "detail")
```

```
## $meta
##   total total_pages page error
## 1     1           1    1    NA
## 
## $data
## $data$info
##                            doi
## 1 10.1371/journal.pone.0029797
##                                                                             title
## 1 Ecological Guild Evolution and the Discovery of the World's Smallest Vertebrate
##                                                                canonical_url
## 1 http://www.plosone.org/article/info%3Adoi%2F10.1371%2Fjournal.pone.0029797
##       pmid   pmcid                        mendeley_uuid
## 1 22253785 3256195 897fbbd6-5a23-3552-8077-97251b82c1e1
##            update_date     issued
## 1 2014-08-25T14:03:30Z 2012-01-11
## 
## $data$signposts
##                            doi viewed saved discussed cited
## 1 10.1371/journal.pone.0029797  33360    79       243     7
## 
## $data$totals
##                       .id  pdf  html readers comments likes  total
## 1               citeulike   NA    NA       1       NA    NA      1
## 2                crossref   NA    NA      NA       NA    NA      8
## 3                  nature   NA    NA      NA       NA    NA      4
## 4                  pubmed   NA    NA      NA       NA    NA      2
## 5                  scopus   NA    NA      NA       NA    NA      7
## 6                 counter 2487 30224      NA       NA    NA  32825
## 7        researchblogging   NA    NA      NA       NA    NA      1
## 8                     wos   NA    NA      NA       NA    NA      7
## 9                     pmc   68   467      NA       NA    NA    535
## 10               facebook   NA    NA     149       22    60    231
## 11               mendeley   NA    NA      78       NA    NA     78
## 12                twitter   NA    NA      NA       12    NA     12
## 13              wikipedia   NA    NA      NA       NA    NA     48
## 14          scienceseeker   NA    NA      NA       NA    NA      0
## 15         relativemetric   NA    NA      NA       NA    NA 157436
## 16                  f1000   NA    NA      NA       NA    NA      0
## 17               figshare    0    18      NA       NA     0     18
## 18              pmceurope   NA    NA      NA       NA    NA      4
## 19          pmceuropedata   NA    NA      NA       NA    NA     49
## 20            openedition   NA    NA      NA       NA    NA      0
## 21              wordpress   NA    NA      NA       NA    NA      0
## 22                 reddit   NA    NA      NA        0     0      0
## 23               datacite   NA    NA      NA       NA    NA      0
## 24             copernicus   NA    NA      NA       NA    NA      0
## 25        articlecoverage   NA    NA      NA        0    NA      0
## 26 articlecoveragecurated   NA    NA      NA        0    NA      0
## 27          plos_comments   NA    NA      NA       11    NA     16
## 
## $data$sum_metrics
##                .id year month day total X[[1L]]
## 1        citeulike 2012     1  12     1      NA
## 2           nature 2012     1  11     1      NA
## 3           nature 2012     1  12     1      NA
## 4           nature 2012     2   1     1      NA
## 5 researchblogging   NA    NA  NA    NA      NA
## 6    plos_comments 2012     1  11     1      NA
## 7    plos_comments 2012     1  12     7      NA
## 8    plos_comments 2012     1  13     1      NA
## 9    plos_comments 2012     1  14     1      NA
```

### Search on many identifiers


```r
dois <- c("10.1371/journal.pone.0001543", "10.1371/journal.pone.0040117", "10.1371/journal.pone.0029797", "10.1371/journal.pone.0039395")
out <- alm_ids(doi = dois)
lapply(out$data, head)
```

```
## $`10.1371/journal.pone.0040117`
##         .id pdf html readers comments likes total
## 1 citeulike  NA   NA       0       NA    NA     0
## 2  crossref  NA   NA      NA       NA    NA     6
## 3    nature  NA   NA      NA       NA    NA     0
## 4    pubmed  NA   NA      NA       NA    NA     5
## 5    scopus  NA   NA      NA       NA    NA    10
## 6   counter 379 1831      NA       NA    NA  2229
## 
## $`10.1371/journal.pone.0039395`
##         .id pdf html readers comments likes total
## 1 citeulike  NA   NA       0       NA    NA     0
## 2  crossref  NA   NA      NA       NA    NA     0
## 3    nature  NA   NA      NA       NA    NA     0
## 4    pubmed  NA   NA      NA       NA    NA     1
## 5    scopus  NA   NA      NA       NA    NA     3
## 6   counter 227 1282      NA       NA    NA  1535
## 
## $`10.1371/journal.pone.0029797`
##         .id  pdf  html readers comments likes total
## 1 citeulike   NA    NA       1       NA    NA     1
## 2  crossref   NA    NA      NA       NA    NA     8
## 3    nature   NA    NA      NA       NA    NA     4
## 4    pubmed   NA    NA      NA       NA    NA     2
## 5    scopus   NA    NA      NA       NA    NA     7
## 6   counter 2487 30224      NA       NA    NA 32825
## 
## $`10.1371/journal.pone.0001543`
##         .id pdf html readers comments likes total
## 1 citeulike  NA   NA       0       NA    NA     0
## 2  crossref  NA   NA      NA       NA    NA     7
## 3    nature  NA   NA      NA       NA    NA     0
## 4    pubmed  NA   NA      NA       NA    NA     7
## 5    scopus  NA   NA      NA       NA    NA    11
## 6   counter 447 2709      NA       NA    NA  3202
```

### Output an-easy-to-combine-with-other-results data.frame


```r
res <- alm_ids(doi = "10.1371/journal.pone.0035869", total_details = TRUE)
res$data[, 3:10]
```

```
##   citeulike_pdf citeulike_html citeulike_readers citeulike_comments
## 1            NA             NA                27                 NA
##   citeulike_likes citeulike_total crossref_pdf crossref_html
## 1              NA              27           NA            NA
```

### Get detailed data for altmetrics using `almevents`


```r
out <- alm_events(doi = "10.1371/journal.pone.0029797")
names(out)  # names of sources
```

```
##  [1] "citeulike"              "crossref"              
##  [3] "nature"                 "pubmed"                
##  [5] "scopus"                 "counter"               
##  [7] "researchblogging"       "wos"                   
##  [9] "pmc"                    "facebook"              
## [11] "mendeley"               "twitter"               
## [13] "wikipedia"              "scienceseeker"         
## [15] "relativemetric"         "f1000"                 
## [17] "figshare"               "pmceurope"             
## [19] "pmceuropedata"          "openedition"           
## [21] "wordpress"              "reddit"                
## [23] "datacite"               "copernicus"            
## [25] "articlecoverage"        "articlecoveragecurated"
## [27] "plos_comments"
```


```r
out <- out[!out %in% c("sorry, no events content yet", "parser not written yet")]  # remove those with no data
out[["pmc"]]  # get the results for PubMed Central
```

```
## $events_url
## [1] "http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3256195"
## 
## $events
##    scanned.page.browse month cited.by abstract full.text unique.ip pdf
## 1                    0     1        0        1        51        42   8
## 2                    0     2        0        0        15        11   4
## 3                    0     3        0        0        11        12   4
## 4                    0     4        0        1         6         6   2
## 5                    0     5        0        0         5         5   1
## 6                    0     6        0        0         7         9   2
## 7                    0     7        0        1         6         8   3
## 8                    0     8        0        1         5         4   0
## 9                    0     9        0        0        14        13   5
## 10                   0    10        0        1        20        16   4
## 11                   0    12        0        0        13        12   1
## 12                   0     1        0        0        13        14   7
## 13                   0     3        0        1        22        20   2
## 14                   0     2        0        0        13        10   2
## 15                   0     4        1        1        45        24   4
## 16                   0    11        0        1        10         9   1
## 17                   0     5        0        0        18        21   5
## 18                   0     6        0        0        12        11   1
## 19                   0     7        0        0        27        14   1
## 20                   0     8        0        0        21        13   0
## 21                   0     9        0        0        14        13   0
## 22                   0    10        0        0        14        15   3
## 23                   0    11        0        6        18        16   2
## 24                   0    12        0        0        14         9   1
## 25                   0     1        0        0        22        16   1
## 26                   0     2        0        0        13        12   1
## 27                   0     3        0        0        11        10   1
## 28                   0     5        0        0        15        12   0
## 29                   0     6        0        0        12        12   2
##    year figure scanned.summary supp.data
## 1  2012      9               0         0
## 2  2012     11               0         2
## 3  2012      0               0         0
## 4  2012      0               0         0
## 5  2012      0               0         0
## 6  2012      2               0         0
## 7  2012      3               0         0
## 8  2012      0               0         0
## 9  2012      3               0         0
## 10 2012      1               0         0
## 11 2012      1               0         0
## 12 2013      0               0         0
## 13 2013      0               0         0
## 14 2013      0               0         0
## 15 2013      3               0         1
## 16 2012      0               0         0
## 17 2013      0               0         1
## 18 2013      0               0         1
## 19 2013      0               0         0
## 20 2013      0               0         0
## 21 2013      0               0         1
## 22 2013      2               0         0
## 23 2013      0               0         0
## 24 2013      0               0         0
## 25 2014      0               0         0
## 26 2014      0               0         0
## 27 2014      2               0         0
## 28 2014      0               0         1
## 29 2014      0               0         0
## 
## $csl
## list()
```

### Retrieve and plot PLOS article-level metrics signposts.


```r
dat <- alm_signposts(doi = "10.1371/journal.pone.0029797")
plot_signposts(dat)
```

```
## Using doi as id variables
```

![plot of chunk unnamed-chunk-11](inst/assets/img/unnamed-chunk-11.png) 

Or plot many identifiers get a faceted bar chart, note the tick labels have just the last part of the DOI in this case to help you identify each DOI - printing the entire DOI would make lables overlap one another.


```r
dois <- c("10.1371/journal.pone.0001543", "10.1371/journal.pone.0040117", "10.1371/journal.pone.0029797", "10.1371/journal.pone.0039395")
dat <- alm_signposts(doi = dois)
plot_signposts(input = dat)
```

```
## Using doi as id variables
```

![plot of chunk unnamed-chunk-12](inst/assets/img/unnamed-chunk-12.png) 

Or make an interactive chart by doing `plot_signposts(input=dat, type="multiBarChart")`. Try it out! It should open in your browser and you can interact with it.

#### Density and histogram plots from PLOS Article Level Metrics data

Note: Do you the key below in the `searchplos` call in this example, but if you plan to use rplos more, get your own API key [here](http://api.plos.org/).


```r
library('rplos')
library('plyr')
dois <- searchplos(q = "science", fl = "id", fq = list("-article_type:correction", "cross_published_journal_key:PLoSONE", "doc_type:full", "publication_date:[2010-01-01T00:00:00Z TO 2010-12-31T23:59:59Z]"), limit = 50)
dois <- dois$id
```


Collect altmetrics data and combine to a `data.frame` with `ldply`



```r
alm <- alm_ids(doi = dois, total_details = TRUE)
alm <- ldply(alm$data)
```


The default plot



```r
plot_density(alm)
```

![plot of chunk unnamed-chunk-15](inst/assets/img/unnamed-chunk-15.png) 


Plot many sources in different panels in the same plot, and pass in colors just for fun



```r
plot_density(input = alm, source = c("counter_total", "crossref_total",
    "twitter_total", "wos_total"), color = c("#83DFB4", "#EFA5A5", "#CFD470",
    "#B2C9E4"))
```

```
## No id variables; using all as measure variables
```

![plot of chunk unnamed-chunk-16](inst/assets/img/unnamed-chunk-16.png) 


## Meta

Please [report any issues or bugs](https://github.com/ropensci/alm/issues).

License: MIT

This package is part of the [rOpenSci](http://ropensci.org/packages) project.

To cite package `alm` in publications use:


```r
citation(package = 'alm')
```

```
## 
## To cite package 'alm' in publications use:
## 
##   Scott Chamberlain, Carl Boettiger, Karthik Ram and Fenner Martin
##   (2014). alm: R wrapper to the almetrics API platform developed
##   by PLoS. R package version 0.1.9.99.
##   https://github.com/ropensci/alm
## 
## A BibTeX entry for LaTeX users is
## 
##   @Manual{,
##     title = {alm: R wrapper to the almetrics API platform developed by PLoS},
##     author = {Scott Chamberlain and Carl Boettiger and Karthik Ram and Fenner Martin},
##     year = {2014},
##     note = {R package version 0.1.9.99},
##     url = {https://github.com/ropensci/alm},
##   }
```

Get citation information for `alm` in R doing `citation(package = 'alm')`


[![](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
