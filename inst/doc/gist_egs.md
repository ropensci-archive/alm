Install libraries


```coffee
install_github("alm", "ropensci")
install_github("rplos", "ropensci")
install.packages("plyr")
```


Load libraries


```coffee
library(alm)
library(rplos)
library(plyr)
```


Get DOIs from PLOS search api


```coffee
dois <- searchplos(terms = "*:*", fields = "id", toquery = list("cross_published_journal_key:PLoSONE", 
    "doc_type:full", "publication_date:[2010-01-01T00:00:00Z TO 2010-12-31T23:59:59Z]"), 
    limit = 200)
```


Then search for altmetrics on each DOI, and combine results for each DOI to a data.frame 


```coffee
alm <- alm(doi = do.call(c, dois$id), total_details = TRUE)
alm <- ldply(alm)
```


Default plot gives Scopus citations


```coffee
plot_density(alm)
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5.png) 


Or give histogram instead of density


```coffee
plot_density(alm, plot_type = "hist")
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6.png) 


Note that you can get the possible data source by doing `str(alm)` or `head(alm)`. Change color of density plot


```coffee
plot_density(alm, color = "#DCA121")
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-7.png) 


Change Title


```coffee
plot_density(alm, title = "Scopus citations from 2010")
```

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-8.png) 


Change title and description


```coffee
plot_density(alm, title = "Scopus citations from 2010", description = "Probablity of X number of citations for a paper")
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-9.png) 


Change just description


```coffee
plot_density(alm, description = "Probablity of X number of citations for a paper")
```

![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-10.png) 


Use the source crossref_citations


```coffee
plot_density(input = alm, source = "crossref_citations")
```

![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-11.png) 


Use number of tweets 


```coffee
plot_density(input = alm, source = "twitter_total")
```

![plot of chunk unnamed-chunk-12](figure/unnamed-chunk-12.png) 


Use totoal PLOS usage data (views, downloads, etc.) 


```coffee
plot_density(input = alm, source = "counter_total")
```

![plot of chunk unnamed-chunk-13](figure/unnamed-chunk-13.png) 


Use two souces, PLOS counter and crossref citations


```coffee
plot_density(input = alm, source = c("counter_total", "crossref_citations"))
```

![plot of chunk unnamed-chunk-14](figure/unnamed-chunk-14.png) 


Same as above but histogram plot type


```coffee
plot_density(input = alm, source = c("counter_total", "crossref_citations"), 
    plot_type = "hist")
```

`ust this. stat_bin: binwidth defaulted to range/30.
## Use 'binwidth = x' to adjust this.
```

![plot of chunk unnamed-chunk-15](figure/unnamed-chunk-15.png) 


Three sources


```coffee
plot_density(input = alm, source = c("counter_total", "crossref_citations", 
    "twitter_total"))
```

![plot of chunk unnamed-chunk-16](figure/unnamed-chunk-16.png) 


Three sources, and use different color for each source


```coffee
plot_density(input = alm, source = c("counter_total", "crossref_citations", 
    "twitter_total"), color = c("#DBAC6A", "#E09B33", "#A06D34"))
```

![plot of chunk unnamed-chunk-17](figure/unnamed-chunk-17.png) 


Four different sources


```coffee
plot_density(input = alm, source = c("counter_total", "crossref_citations", 
    "twitter_total", "wos_citations"))
```

```
## Warning: Removed 128 rows containing non-finite values (stat_density).
```

![plot of chunk unnamed-chunk-18](figure/unnamed-chunk-18.png) 


Two sources and a title


```coffee
plot_density(input = alm, source = c("counter_total", "crossref_citations"), 
    title = "Counter, Crossref, Twitter, and Web of Science")
```

![plot of chunk unnamed-chunk-19](figure/unnamed-chunk-19.png) 


Four sources, and separate color for each panel


```coffee
plot_density(input = alm, source = c("counter_total", "crossref_citations", 
    "twitter_total", "wos_citations"), color = c("#83DFB4", "#EFA5A5", "#CFD470", 
    "#B2C9E4"))
```

![plot of chunk unnamed-chunk-20](figure/unnamed-chunk-20.png) 

