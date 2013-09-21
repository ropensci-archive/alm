<pre>
         __      | 			|\      /|
        /  \     | 			| \    / |
       / -- \    | 			|  \  /  |
      /      \   | 			|   \/   |
     /        \  |_______ 	|        |
</pre>

<!-- [![Build Status](https://api.travis-ci.org/ropensci/alm.png)](https://travis-ci.org/ropensci/alm) -->

### What it is!?

`alm` is a set of functions to access article level metrics from the Public Library of Science journals using their ALM API. 


### What is an article level metric? 

Glad you asked. The canonical URL for this is perhaps [altmetrics.org](http://altmetrics.org/manifesto/). Basically it is a metric that measures something about an article. This is in stark contrast to journal level metrics, like the Journal Impact Factor. 

### Are there other altmetrics data providers?

Yes indeedy. 

+ [ImpactStory](http://impactstory.it/)
+ [Altmetric.com](http://altmetric.com/)
+ [PlumAnalytics](http://www.plumanalytics.com/)

### Authentication

You aren't currently not required to use an API key to access the PLoS ALM API, but soon will need to.

Get your PLoS API key [here](http://api.plos.org/)

Put your API key in your .Rprofile file using exactly this: 
options(PlosApiKey = "YOUalmAPIKEY"), 
and the functions within this package will be able to use your API key without you having to enter it every time you run a search. 

### Tutorials and help

*Coming soon* 

<!-- alm tutorial at rOpenSci website [here](#) -->

### Quick start

#### Install

You can get this package by installing via `install_github()` within Hadley Wickham's devtools package.

```ruby
install.packages("devtools")
require(devtools)
install_github("alm", "rOpenSci")
require(alm)
```

#### Get altmetrics data for a single paper, and visualize the total data across dates

```ruby
out <- alm(doi='10.1371/journal.pone.0001543', info='detail')
almplot(out, type='totalmetrics') # just totalmetrics data
```

![](inst/assets/img/altmetrics.png)


#### Get altmetrics by year

```ruby
alm(doi='10.1371/journal.pone.0036240', sum_metrics='year')

                .id  x year pdf html shares groups comments likes citations total
1         bloglines NA   NA  NA   NA     NA     NA       NA    NA        NA    NA
2         citeulike NA 2012  NA   NA      5     NA       NA    NA        NA     5
3          connotea NA   NA  NA   NA     NA     NA       NA    NA        NA    NA
4          crossref NA 2013  NA   NA     NA     NA       NA    NA         3     3
5            nature NA   NA  NA   NA     NA     NA       NA    NA        NA    NA
6       postgenomic NA   NA  NA   NA     NA     NA       NA    NA        NA    NA
7            pubmed NA   NA  NA   NA     NA     NA       NA    NA        NA    NA
8            scopus NA   NA  NA   NA     NA     NA       NA    NA        NA    NA
9           counter NA   NA  NA   NA     NA     NA       NA    NA        NA    NA
10 researchblogging NA   NA  NA   NA     NA     NA       NA    NA        NA    NA
11             biod NA   NA  NA   NA     NA     NA       NA    NA        NA    NA
12              wos NA   NA  NA   NA     NA     NA       NA    NA        NA    NA
13              pmc NA 2012  16   53     NA     NA       NA    NA        NA    69
14              pmc NA 2013   3   29     NA     NA       NA    NA        NA    32
15         facebook NA   NA  NA   NA     NA     NA       NA    NA        NA    NA
16         mendeley NA   NA  NA   NA     NA     NA       NA    NA        NA    NA
17          twitter NA 2012  NA   NA     NA     NA      103    NA        NA   103
18          twitter NA 2013  NA   NA     NA     NA       14    NA        NA    14
19        wikipedia NA   NA  NA   NA     NA     NA       NA    NA        NA    NA
20    scienceseeker NA   NA  NA   NA     NA     NA       NA    NA        NA    NA
21   relativemetric NA   NA  NA   NA     NA     NA       NA    NA        NA    NA
```

#### Output an-easy-to-combine-with-other-results data.frame

```ruby
alm(doi='10.1371/journal.pone.0035869', total_details=TRUE)

                                                       title     publication_date bloglines_citations
1 Research Blogs and the Discussion of Scholarly Information 2012-05-11T07:00:00Z                   0
  bloglines_total citeulike_shares citeulike_total connotea_citations connotea_total crossref_citations
1               0               22              22                  0              0                  2
  crossref_total nature_citations nature_total postgenomic_citations postgenomic_total pubmed_citations
1              2                4            4                     0                 0                1
  pubmed_total scopus_citations scopus_total counter_pdf counter_html counter_total
1            1                2            2           0            0         13598
  researchblogging_citations researchblogging_total biod_total wos_citations wos_total pmc_pdf pmc_html
1                          6                      6          0             1         1      85      429
  pmc_total facebook_shares facebook_comments facebook_likes facebook_total mendeley_shares
1       514              27                13             18             58              65
  mendeley_groups mendeley_total twitter_citations twitter_total wikipedia_citations wikipedia_total
1               8             73                48            48                   0               0
  scienceseeker_citations scienceseeker_total relativemetric_total
1                       3                   3                32898
```

### >>> alm is part of the [rOpenSci Project](http://ropensci.github.com)