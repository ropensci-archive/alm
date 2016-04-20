

<pre>
       .__
_____  |  |   _____
\__  \ |  |  /     \
 / __ \|  |_|  Y Y  \
(____  /____/__|_|  /
     \/           \/
</pre>

[![Build Status](https://api.travis-ci.org/ropensci/alm.png?branch=v6)](https://travis-ci.org/ropensci/alm?branch=v6)
[![Build status](https://ci.appveyor.com/api/projects/status/w7mrpr5owh9deepq/branch/v6)](https://ci.appveyor.com/project/sckott/alm/branch/v6)
[![codecov.io](https://codecov.io/github/ropensci/alm/coverage.svg?branch=v6)](https://codecov.io/github/ropensci/alm?branch=v6)
[![Research software impact](http://depsy.org/api/package/cran/alm/badge.svg)](http://depsy.org/package/r/alm)


## What it is!?

The `alm` package is a set of functions to access article level metrics via a RESTful API from the Rails app `Lagotto` created by the Public Library of Science (PLOS). `Lagotto` is being used by PLOS, and a number of other publishers:

* PLOS (all their journals) at [http://alm.plos.org/](http://alm.plos.org/)
* PLOS test server at [http://labs.lagotto.io/](http://labs.lagotto.io/)
* Copernicus (seems to be down for now)
* Public Knowledge Project (PKP) at [http://pkp-alm.lib.sfu.ca/](http://pkp-alm.lib.sfu.ca/)
* Crossref at [http://det.labs.crossref.org/](http://det.labs.crossref.org/)
* eLife at [http://lagotto.svr.elifesciences.org/](http://lagotto.svr.elifesciences.org/)
* Pensoft at [http://alm.pensoft.net:81/](http://alm.pensoft.net:81/)
* Making Dat Count at [http://dlm.plos.org](http://dlm.plos.org)

A good place to look for the status of various installations of Lagotto is this status page: http://articlemetrics.github.io/status/ (which also includes what version of Lagotto each is running)

## Help with Lagotto

Lagotto has a nice support site at [http://discuss.lagotto.io/](http://discuss.lagotto.io/) for any questions about it.

## What is an article level metric?

Glad you asked. The canonical URL for this is perhaps [altmetrics.org](http://altmetrics.org/manifesto/). Basically it is a metric that measures something about an article. This is in stark contrast to journal level metrics, like the [Journal Impact Factor](http://www.wikiwand.com/en/Impact_factor).

## Are there other altmetrics data providers?

Yes indeedy, but see notes

+ [ImpactStory](http://impactstory.org/) - No open data (except for your own data)
+ [Altmetric.com](http://altmetric.com/) - Some open data
+ [PlumAnalytics](http://www.plumanalytics.com/) - No open data

## Authentication

You only need an API key for the publishers PKP and Pensoft. You can set the key in your options just for the current session by executing `options(PlosApiKey = "YOUalmAPIKEY")`, or pass in to each function call with the `key` parameter, or save in your `.Rprofile` file.

## URLs

The default URL is set for the PLOS data sources: http://alm.plos.org/api/v5/articles
You can change this URL. For example, if you want to get data from the Crossref instance, set the `api_url` parameter to http://alm.labs.crossref.org/api/v5/articles

## Other languages

If R is not your thing, there are Lagotto clients in development for [Ruby](https://github.com/articlemetrics/lagotto-rb) and [Python](https://github.com/articlemetrics/pyalm).

## Install

Or the development version by installing with `install_github()`


```r
install.packages("devtools")
devtools::install_github("ropensci/alm@v6")
```

Load the package


```r
library('alm')
```

The first function we'll look at is `alm_ids()`, named with `ids` since we search for data by one of four different choices of identifier.

## Get altmetrics data for a single paper


```r
alm_works("10.1371/journal.pone.0029797")
#> $meta
#> $meta$status
#> [1] "ok"
#>
#> $meta$`message-type`
#> [1] "work"
#>
#> $meta$`message-version`
#> [1] "6.0.0"
#>
#>
#> $work
#> $work$id
#> [1] "http://doi.org/10.1371/journal.pone.0029797"
#>
...
```

## Search on many identifiers


```r
dois <- c("10.1371/journal.pone.0001543", "10.1371/journal.pone.0040117", "10.1371/journal.pone.0029797", "10.1371/journal.pone.0039395")
lapply(dois, function(z) alm_works(z)$work$publisher_id)
#> [[1]]
#> [1] 340
#>
#> [[2]]
#> [1] 340
#>
#> [[3]]
#> [1] 340
#>
#> [[4]]
#> [1] 340
```

## Get detailed data for altmetrics using `almevents`


```r
out <- alm_events(doi = "10.1371/journal.pone.0029797")
names(out)  # names of sources
```


```r
out <- out[!out %in% c("sorry, no events content yet", "parser not written yet")]  # remove those with no data
out[["pmc"]]  # get the results for PubMed Central
```

## Work with data from non-PLOS publishers

Crossref


```r
crurl <- "http://det.crossref.org"
alm_works('10.15468/DL.O8YDNB', api_url = crurl)
#> $meta
#> $meta$status
#> [1] "ok"
#>
#> $meta$`message-type`
#> [1] "work"
#>
#> $meta$`message-version`
#> [1] "6.0.0"
#>
#>
#> $work
#> $work$id
#> [1] "http://doi.org/10.15468/DL.O8YDNB"
#>
...
```

Datacite labs


```r
dlmurl <- 'https://dlm.labs.datacite.org'
alm_works('10.5061/dryad.79dq1/1', api_url = dlmurl)
#> $meta
#> $meta$status
#> [1] "ok"
#>
#> $meta$`message-type`
#> [1] "work"
#>
#> $meta$`message-version`
#> [1] "6.0.0"
#>
#>
#> $work
#> $work$id
#> [1] "http://doi.org/10.5061/dryad.79dq1/1"
#>
...
```

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/alm/issues).
* License: MIT
* Get citation information for `alm` in R doing `citation(package = 'alm')`
* Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.

[![ropensci_footer](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
