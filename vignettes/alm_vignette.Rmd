<!--
%\VignetteEngine{knitr::knitr}
%\VignetteIndexEntry{alm vignette}
-->




alm tutorial
======

## What are article level metrics? 

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

## Install and load

You can get this package by installing via `install_github()` within Hadley Wickham's devtools package.


```r
install.packages("devtools")
require(devtools)
install_github("alm", "rOpenSci")
```



```r
library(alm)
```


## The default call with either doi, pmid, pmcid, or mdid without specifying an argument for info

(We'll not print a few columns so the table prints nicely)


```r
alm(doi = "10.1371/journal.pone.0029797")[, -c(6:8)]
```

```
                      .id  pdf  html shares groups  total
1               citeulike   NA    NA      1     NA      1
2                crossref   NA    NA     NA     NA      7
3                  nature   NA    NA     NA     NA      4
4                  pubmed   NA    NA     NA     NA      2
5                  scopus   NA    NA     NA     NA      0
6                 counter 2371 27772     NA     NA  30251
7        researchblogging   NA    NA     NA     NA      1
8                     wos   NA    NA     NA     NA      6
9                     pmc   64   416     NA     NA    480
10               facebook   NA    NA      0     NA      0
11               mendeley   NA    NA     69      0     69
12                twitter   NA    NA     NA     NA     11
13              wikipedia   NA    NA     NA     NA     49
14          scienceseeker   NA    NA     NA     NA      0
15         relativemetric   NA    NA     NA     NA 150729
16                  f1000   NA    NA     NA     NA      0
17               figshare    0     8     NA     NA      8
18              pmceurope   NA    NA     NA     NA      4
19          pmceuropedata   NA    NA     NA     NA     10
20            openedition   NA    NA     NA     NA      0
21              wordpress   NA    NA     NA     NA      0
22                 reddit   NA    NA     NA     NA      0
23               datacite   NA    NA     NA     NA      0
24             copernicus   NA    NA     NA     NA      0
25        articlecoverage   NA    NA     NA     NA      0
26 articlecoveragecurated   NA    NA     NA     NA      0
27          plos_comments   NA    NA     NA     NA     16
```



## Details for a single DOI


```r
out <- alm(doi = "10.1371/journal.pone.0029797", info = "detail")
## totals
out[["totals"]][, -c(6:8)]
```

```
                      .id  pdf  html shares groups  total
1               citeulike   NA    NA      1     NA      1
2                crossref   NA    NA     NA     NA      7
3                  nature   NA    NA     NA     NA      4
4                  pubmed   NA    NA     NA     NA      2
5                  scopus   NA    NA     NA     NA      0
6                 counter 2371 27772     NA     NA  30251
7        researchblogging   NA    NA     NA     NA      1
8                     pmc   64   416     NA     NA    480
9                facebook   NA    NA      0     NA      0
10               mendeley   NA    NA     69      0     69
11                twitter   NA    NA     NA     NA     11
12              wikipedia   NA    NA     NA     NA     49
13          scienceseeker   NA    NA     NA     NA      0
14         relativemetric   NA    NA     NA     NA 150729
15                  f1000   NA    NA     NA     NA      0
16               figshare    0     8     NA     NA      8
17              pmceurope   NA    NA     NA     NA      4
18          pmceuropedata   NA    NA     NA     NA     10
19            openedition   NA    NA     NA     NA      0
20              wordpress   NA    NA     NA     NA      0
21                 reddit   NA    NA     NA     NA      0
22               datacite   NA    NA     NA     NA      0
23             copernicus   NA    NA     NA     NA      0
24        articlecoverage   NA    NA     NA     NA      0
25 articlecoveragecurated   NA    NA     NA     NA      0
26          plos_comments   NA    NA     NA     NA     16
```

```r
## history
head(out[["history"]])
```

```
        .id      dates totals
1 citeulike 2014-01-27      1
2  crossref 2014-01-26      7
3    nature 2014-01-30      4
4    pubmed 2014-01-25      2
5   counter 2014-02-25  30251
6   counter 2014-02-24  30238
```


## Search using various identifiers, including pubmed id, pmc id, and mendeley id


```r
# A single PubMed ID (pmid)
alm(pmid = 22590526)[, -c(6:8)]
```

```
                      .id  pdf  html shares groups total
1               citeulike   NA    NA      5     NA     5
2                crossref   NA    NA     NA     NA     3
3                  nature   NA    NA     NA     NA     1
4                  pubmed   NA    NA     NA     NA     5
5                  scopus   NA    NA     NA     NA     0
6                 counter 1032 14687     NA     NA 15760
7        researchblogging   NA    NA     NA     NA     1
8                     pmc   31   119     NA     NA   150
9                facebook   NA    NA      0     NA     0
10               mendeley   NA    NA     59      0    59
11                twitter   NA    NA     NA     NA   143
12              wikipedia   NA    NA     NA     NA     0
13          scienceseeker   NA    NA     NA     NA     0
14         relativemetric   NA    NA     NA     NA 33527
15                  f1000   NA    NA     NA     NA     0
16               figshare   NA    NA     NA     NA     0
17              pmceurope   NA    NA     NA     NA     4
18          pmceuropedata   NA    NA     NA     NA     0
19            openedition   NA    NA     NA     NA     0
20              wordpress   NA    NA     NA     NA     1
21                 reddit   NA    NA     NA     NA     0
22               datacite   NA    NA     NA     NA     0
23             copernicus   NA    NA     NA     NA     0
24        articlecoverage   NA    NA     NA     NA     0
25 articlecoveragecurated   NA    NA     NA     NA     0
26          plos_comments   NA    NA     NA     NA     3
```

```r

# A single PubMed Central ID (pmcid)
alm(pmcid = 212692)[, -c(6:8)]
```

```
                      .id  pdf  html shares groups   total
1               citeulike   NA    NA      8     NA       8
2                crossref   NA    NA     NA     NA     150
3                  nature   NA    NA     NA     NA       0
4                  pubmed   NA    NA     NA     NA     149
5                  scopus   NA    NA     NA     NA     324
6                 counter 2533 20295     NA     NA   22979
7        researchblogging   NA    NA     NA     NA       0
8                     pmc 2331  4898     NA     NA    7229
9                facebook   NA    NA      0     NA       0
10               mendeley   NA    NA    104      0     104
11                twitter   NA    NA     NA     NA       0
12              wikipedia   NA    NA     NA     NA       0
13          scienceseeker   NA    NA     NA     NA       0
14         relativemetric   NA    NA     NA     NA 1346375
15                  f1000   NA    NA     NA     NA       0
16               figshare    1     4     NA     NA       5
17              pmceurope   NA    NA     NA     NA     192
18          pmceuropedata   NA    NA     NA     NA      52
19            openedition   NA    NA     NA     NA       0
20              wordpress   NA    NA     NA     NA       0
21                 reddit   NA    NA     NA     NA       0
22               datacite   NA    NA     NA     NA       0
23             copernicus   NA    NA     NA     NA       0
24        articlecoverage   NA    NA     NA     NA       0
25 articlecoveragecurated   NA    NA     NA     NA       0
26          plos_comments   NA    NA     NA     NA       0
```

```r

# A single Mendeley UUID (mdid)
alm(mdid = "35791700-6d00-11df-a2b2-0026b95e3eb7")[, -c(6:8)]
```

```
NULL
```



## Search on many identifiers


```r
dois <- c("10.1371/journal.pone.0001543", "10.1371/journal.pone.0040117", "10.1371/journal.pone.0029797", 
    "10.1371/journal.pone.0039395")
out <- alm(doi = dois)
lapply(out, head)
```

```
[[1]]
        .id pdf html shares groups comments likes citations total
1 citeulike  NA   NA      0     NA       NA    NA        NA     0
2  crossref  NA   NA     NA     NA       NA    NA         3     3
3    nature  NA   NA     NA     NA       NA    NA         0     0
4    pubmed  NA   NA     NA     NA       NA    NA         1     1
5    scopus  NA   NA     NA     NA       NA    NA         5     5
6   counter 298 1408     NA     NA       NA    NA        NA  1719

[[2]]
        .id pdf html shares groups comments likes citations total
1 citeulike  NA   NA      0     NA       NA    NA        NA     0
2  crossref  NA   NA     NA     NA       NA    NA         0     0
3    nature  NA   NA     NA     NA       NA    NA         0     0
4    pubmed  NA   NA     NA     NA       NA    NA         1     1
5    scopus  NA   NA     NA     NA       NA    NA         0     0
6   counter 201  994     NA     NA       NA    NA        NA  1217

[[3]]
        .id  pdf  html shares groups comments likes citations total
1 citeulike   NA    NA      1     NA       NA    NA        NA     1
2  crossref   NA    NA     NA     NA       NA    NA         7     7
3    nature   NA    NA     NA     NA       NA    NA         4     4
4    pubmed   NA    NA     NA     NA       NA    NA         2     2
5    scopus   NA    NA     NA     NA       NA    NA         0     0
6   counter 2371 27772     NA     NA       NA    NA        NA 30251

[[4]]
        .id pdf html shares groups comments likes citations total
1 citeulike  NA   NA      0     NA       NA    NA        NA     0
2  crossref  NA   NA     NA     NA       NA    NA         7     7
3    nature  NA   NA     NA     NA       NA    NA         0     0
4    pubmed  NA   NA     NA     NA       NA    NA         6     6
5    scopus  NA   NA     NA     NA       NA    NA         8     8
6   counter 426 2580     NA     NA       NA    NA        NA  3046
```


## Get altmetrics by year

You can also get metrics by day (`sum_metrics='day'`) or month (`sum_metrics='month'`)


```r
alm(doi = "10.1371/journal.pone.0036240", sum_metrics = "year")[, -c(6:8)]
```

```
                      .id year pdf  html shares citations total  x
1               citeulike 2012  NA    NA      5        NA     5 NA
2                crossref 2013  NA    NA     NA         3     3 NA
3                  nature   NA  NA    NA     NA        NA    NA NA
4                  pubmed   NA  NA    NA     NA        NA    NA NA
5                  scopus   NA  NA    NA     NA        NA    NA NA
6                 counter 2012 699 10502     NA        NA 11234 NA
7                 counter 2013 299  3605     NA        NA  3911 NA
8                 counter 2014  34   580     NA        NA   615 NA
9        researchblogging 2013  NA    NA     NA         1     1 NA
10                    pmc 2012  16    53     NA        NA    69 NA
11                    pmc 2013  13    66     NA        NA    79 NA
12                    pmc 2014   2     0     NA        NA     2 NA
13               facebook   NA  NA    NA     NA        NA    NA NA
14               mendeley   NA  NA    NA     NA        NA    NA NA
15                twitter 2012  NA    NA     NA        NA   103 NA
16                twitter 2013  NA    NA     NA        NA    33 NA
17                twitter 2014  NA    NA     NA        NA     7 NA
18              wikipedia   NA  NA    NA     NA        NA    NA NA
19          scienceseeker   NA  NA    NA     NA        NA    NA NA
20         relativemetric   NA  NA    NA     NA        NA    NA NA
21                  f1000   NA  NA    NA     NA        NA    NA NA
22               figshare   NA  NA    NA     NA        NA    NA NA
23              pmceurope   NA  NA    NA     NA        NA    NA NA
24          pmceuropedata   NA  NA    NA     NA        NA    NA NA
25            openedition   NA  NA    NA     NA        NA    NA NA
26              wordpress 2012  NA    NA     NA         1     1 NA
27                 reddit   NA  NA    NA     NA        NA    NA NA
28               datacite   NA  NA    NA     NA        NA    NA NA
29             copernicus   NA  NA    NA     NA        NA    NA NA
30        articlecoverage   NA  NA    NA     NA        NA    NA NA
31 articlecoveragecurated   NA  NA    NA     NA        NA    NA NA
32          plos_comments   NA  NA    NA     NA        NA    NA NA
```


## Output an-easy-to-combine-with-other-results data.frame


```r
alm(doi = "10.1371/journal.pone.0035869", total_details = TRUE)[, 3:10]
```

```
      publication_date citeulike_pdf citeulike_html citeulike_shares
1 2012-05-11T07:00:00Z            NA             NA               25
  citeulike_groups citeulike_comments citeulike_likes citeulike_citations
1               NA                 NA              NA                  NA
```


## Get altmetrics data for a single paper, and visualize the total data across dates


```r
out <- alm(doi = "10.1371/journal.pone.0001543", info = "detail")
almplot(out, type = "totalmetrics")
```

![plot of chunk totalmets](figure/totalmets.png) 


## Get detailed data for altmetrics using `almevents`


```r
out <- almevents(doi = "10.1371/journal.pone.0029797")
names(out)  # names of sources
```

```
 [1] "citeulike"              "crossref"              
 [3] "nature"                 "pubmed"                
 [5] "scopus"                 "counter"               
 [7] "researchblogging"       "pmc"                   
 [9] "facebook"               "mendeley"              
[11] "twitter"                "wikipedia"             
[13] "scienceseeker"          "relativemetric"        
[15] "f1000"                  "figshare"              
[17] "pmceurope"              "pmceuropedata"         
[19] "openedition"            "wordpress"             
[21] "reddit"                 "datacite"              
[23] "copernicus"             "articlecoverage"       
[25] "articlecoveragecurated" "plos_comments"         
```

```r
out <- out[!out %in% c("sorry, no events content yet", "parser not written yet")]  # remove those with no data
out[["pmc"]]  # get the results for PubMed Central
```

```
   abstract cited-by figure full-text month pdf scanned-page-browse
1         1        0      9        51     1   8                   0
2         0        0     11        15     2   4                   0
3         0        0      0        11     3   4                   0
4         1        0      0         6     4   2                   0
5         0        0      0         5     5   1                   0
6         0        0      2         7     6   2                   0
7         1        0      3         6     7   3                   0
8         1        0      0         5     8   0                   0
9         0        0      3        14     9   5                   0
10        1        0      1        20    10   4                   0
11        0        0      1        13    12   1                   0
12        0        0      0        13     1   7                   0
13        1        0      0        22     3   2                   0
14        0        0      0        13     2   2                   0
15        1        1      3        45     4   4                   0
16        1        0      0        10    11   1                   0
17        0        0      0        18     5   5                   0
18        0        0      0        12     6   1                   0
19        0        0      0        27     7   1                   0
20        0        0      0        21     8   0                   0
21        0        0      0        14     9   0                   0
22        0        0      2        14    10   3                   0
23        6        0      0        18    11   2                   0
24        0        0      0        14    12   1                   0
25        0        0      0        22     1   1                   0
   scanned-summary supp-data unique-ip year
1                0         0        42 2012
2                0         2        11 2012
3                0         0        12 2012
4                0         0         6 2012
5                0         0         5 2012
6                0         0         9 2012
7                0         0         8 2012
8                0         0         4 2012
9                0         0        13 2012
10               0         0        16 2012
11               0         0        12 2012
12               0         0        14 2013
13               0         0        20 2013
14               0         0        10 2013
15               0         1        24 2013
16               0         0         9 2012
17               0         1        21 2013
18               0         1        11 2013
19               0         0        14 2013
20               0         0        13 2013
21               0         1        13 2013
22               0         0        15 2013
23               0         0        16 2013
24               0         0         9 2013
25               0         0        16 2014
```

```r
out[["twitter"]]  # get the results for twitter (boo, there aren't any)
```

```
                   id
1  237088032224849920
2  237088322290331648
3  263798980054487041
4  263799348842872832
5  263960642589949953
6  282528931503038464
7  282528931612082177
8  284131287810338818
9  313850610174799873
10 403828926247878656
11 435274395284553728
                                                                                                                                           text
1                                   #PLOS: Ecological Guild Evolution and the Discovery of the World's Smallest Vertebrate http://t.co/yEGLyWTf
2                                   #PLOS: Ecological Guild Evolution and the Discovery of the World's Smallest Vertebrate http://t.co/497NRrMR
3         Happy #Halloween from Maria @PLOSONE, dressed as a tiny frog, complete with dime for scale! http://t.co/YWcdPoGP http://t.co/lAxWAHOG
4  RT @multidiscipl1ne: Happy #Halloween from Maria @PLOSONE, dressed as a tiny frog, complete with dime for scale! http://t.co/YWcdPoGP ht ...
5  RT @multidiscipl1ne: Happy #Halloween from Maria @PLOSONE, dressed as a tiny frog, complete with dime for scale! http://t.co/YWcdPoGP ht ...
6               2012: Discovery of the World's Smallest Vertebrate: a frog http://t.co/BwkxRTdm in @PLOSONE via http://t.co/rnM3iFD0 @Hominidos
7                2012: Descubrimiento del vertebrado más pequeño: una rana http://t.co/BwkxRTdm in @PLOSONE via http://t.co/rnM3iFD0 @Hominidos
8                                                                                                           @JayBeeAndCrew http://t.co/okFRfXfA
9                                        Ecological Guild Evolution and the Discovery of the World's Smallest Vertebrate http://t.co/2G6fQJvFhq
10       @Specklet Cool! We had a paper on the smallest frog too, but picture is of it sitting on a dime not a finger :( http://t.co/xJUPb4T3mU
11                                                                                               My son Derrick Thompson http://t.co/btDVdo8TdH
                       created_at            user          user_name
1  Sun Aug 19 07:26:06 +0000 2012        opdebult     Jan ten Hoopen
2  Sun Aug 19 07:27:15 +0000 2012      forestalis     forestalis.org
3  Thu Nov 01 00:25:53 +0000 2012 multidiscipl1ne     Lindsay Kelley
4  Thu Nov 01 00:27:20 +0000 2012     BernScience   Rachel Bernstein
5  Thu Nov 01 11:08:16 +0000 2012 mattjhodgkinson    Matt Hodgkinson
6  Sat Dec 22 16:52:01 +0000 2012 sferrebenedicto     Salva Ferré B.
7  Sat Dec 22 16:52:01 +0000 2012 sferrebenedicto     Salva Ferré B.
8  Thu Dec 27 02:59:12 +0000 2012     LeeAnaconda             LeeAnn
9  Tue Mar 19 03:13:11 +0000 2013       didicikit                FGÇ
10 Fri Nov 22 10:14:53 +0000 2013 mattjhodgkinson    Matt Hodgkinson
11 Mon Feb 17 04:47:57 +0000 2014  MsMeechieMeech Demetrice Thompson
                                                                                        user_profile_image
1                                           http://a0.twimg.com/profile_images/1741153180/Tidan_normal.jpg
2                                    http://a0.twimg.com/profile_images/654250700/ForestalisIco_normal.jpg
3  http://a0.twimg.com/profile_images/1910116023/261235_920680811178_6708085_43508969_7138379_n_normal.jpg
4                                             http://a0.twimg.com/profile_images/1788875907/new_normal.jpg
5                           http://a0.twimg.com/profile_images/2595571976/bc2za9tnyui0wxobreb0_normal.jpeg
6               http://a0.twimg.com/profile_images/2935384666/94c858315bbf621ae3916019026a6c24_normal.jpeg
7               http://a0.twimg.com/profile_images/2935384666/94c858315bbf621ae3916019026a6c24_normal.jpeg
8               http://a0.twimg.com/profile_images/2765018809/5b540749006aaf85c5661c67d93b68e7_normal.jpeg
9                                             http://a0.twimg.com/profile_images/1809269429/hop_normal.jpg
10                         http://pbs.twimg.com/profile_images/2595571976/bc2za9tnyui0wxobreb0_normal.jpeg
11                             http://pbs.twimg.com/profile_images/416963593188302848/WNE4ujvS_normal.jpeg
```

```r
out[c("twitter", "crossref")]  # get the results for two sources
```

```
$twitter
                   id
1  237088032224849920
2  237088322290331648
3  263798980054487041
4  263799348842872832
5  263960642589949953
6  282528931503038464
7  282528931612082177
8  284131287810338818
9  313850610174799873
10 403828926247878656
11 435274395284553728
                                                                                                                                           text
1                                   #PLOS: Ecological Guild Evolution and the Discovery of the World's Smallest Vertebrate http://t.co/yEGLyWTf
2                                   #PLOS: Ecological Guild Evolution and the Discovery of the World's Smallest Vertebrate http://t.co/497NRrMR
3         Happy #Halloween from Maria @PLOSONE, dressed as a tiny frog, complete with dime for scale! http://t.co/YWcdPoGP http://t.co/lAxWAHOG
4  RT @multidiscipl1ne: Happy #Halloween from Maria @PLOSONE, dressed as a tiny frog, complete with dime for scale! http://t.co/YWcdPoGP ht ...
5  RT @multidiscipl1ne: Happy #Halloween from Maria @PLOSONE, dressed as a tiny frog, complete with dime for scale! http://t.co/YWcdPoGP ht ...
6               2012: Discovery of the World's Smallest Vertebrate: a frog http://t.co/BwkxRTdm in @PLOSONE via http://t.co/rnM3iFD0 @Hominidos
7                2012: Descubrimiento del vertebrado más pequeño: una rana http://t.co/BwkxRTdm in @PLOSONE via http://t.co/rnM3iFD0 @Hominidos
8                                                                                                           @JayBeeAndCrew http://t.co/okFRfXfA
9                                        Ecological Guild Evolution and the Discovery of the World's Smallest Vertebrate http://t.co/2G6fQJvFhq
10       @Specklet Cool! We had a paper on the smallest frog too, but picture is of it sitting on a dime not a finger :( http://t.co/xJUPb4T3mU
11                                                                                               My son Derrick Thompson http://t.co/btDVdo8TdH
                       created_at            user          user_name
1  Sun Aug 19 07:26:06 +0000 2012        opdebult     Jan ten Hoopen
2  Sun Aug 19 07:27:15 +0000 2012      forestalis     forestalis.org
3  Thu Nov 01 00:25:53 +0000 2012 multidiscipl1ne     Lindsay Kelley
4  Thu Nov 01 00:27:20 +0000 2012     BernScience   Rachel Bernstein
5  Thu Nov 01 11:08:16 +0000 2012 mattjhodgkinson    Matt Hodgkinson
6  Sat Dec 22 16:52:01 +0000 2012 sferrebenedicto     Salva Ferré B.
7  Sat Dec 22 16:52:01 +0000 2012 sferrebenedicto     Salva Ferré B.
8  Thu Dec 27 02:59:12 +0000 2012     LeeAnaconda             LeeAnn
9  Tue Mar 19 03:13:11 +0000 2013       didicikit                FGÇ
10 Fri Nov 22 10:14:53 +0000 2013 mattjhodgkinson    Matt Hodgkinson
11 Mon Feb 17 04:47:57 +0000 2014  MsMeechieMeech Demetrice Thompson
                                                                                        user_profile_image
1                                           http://a0.twimg.com/profile_images/1741153180/Tidan_normal.jpg
2                                    http://a0.twimg.com/profile_images/654250700/ForestalisIco_normal.jpg
3  http://a0.twimg.com/profile_images/1910116023/261235_920680811178_6708085_43508969_7138379_n_normal.jpg
4                                             http://a0.twimg.com/profile_images/1788875907/new_normal.jpg
5                           http://a0.twimg.com/profile_images/2595571976/bc2za9tnyui0wxobreb0_normal.jpeg
6               http://a0.twimg.com/profile_images/2935384666/94c858315bbf621ae3916019026a6c24_normal.jpeg
7               http://a0.twimg.com/profile_images/2935384666/94c858315bbf621ae3916019026a6c24_normal.jpeg
8               http://a0.twimg.com/profile_images/2765018809/5b540749006aaf85c5661c67d93b68e7_normal.jpeg
9                                             http://a0.twimg.com/profile_images/1809269429/hop_normal.jpg
10                         http://pbs.twimg.com/profile_images/2595571976/bc2za9tnyui0wxobreb0_normal.jpeg
11                             http://pbs.twimg.com/profile_images/416963593188302848/WNE4ujvS_normal.jpeg

$crossref
                  issn                             journal_title
1 1439-6092; 1618-1077           Organisms Diversity & Evolution
2 1313-2970; 1313-2989                                   ZooKeys
3             00218790                 Journal of Animal Ecology
4 1936-6426; 1936-6434         Evolution: Education and Outreach
5 0018-0831; 1938-5099                             Herpetologica
6             10557903     Molecular Phylogenetics and Evolution
7             00244066 Biological Journal of the Linnean Society
                   journal_abbreviation
1                       Org Divers Evol
2                               ZOOKEYS
3                           J Anim Ecol
4                      Evo Edu Outreach
5                         Herpetologica
6 Molecular Phylogenetics and Evolution
7                  Biol J Linn Soc Lond
                                                                                                                                                                         article_title
1 New insights into the systematics and molecular phylogeny of the Malagasy snake genus Liopholidophis suggest at least one rapid reversal of extreme sexual dimorphism in tail length
2                                                                                                Accelerating innovative publishing in taxonomy and systematics: 250 issues of ZooKeys
3                                                                                                                    The evolutionary ecology of dwarfism in three-spined sticklebacks
4                                                                                                                                           Heterochrony: the Evolution of Development
5                                                 A New Species of Miniaturized Toadlet, GenusBrachycephalus(Anura: Brachycephalidae), from the Atlantic Forest of Southeastern Brazil
6                                              Genetic diversity, phylogeny and evolution of alkaloid sequestering in Cuban miniaturized frogs of the Eleutherodactylus limbatus group
7                                                                                               Are diminutive turtles miniaturized? The ontogeny of plastron shape in emydine turtles
                                                                                               contributor
1                    Frank Glaw; Christoph Kucharzewski; Zoltán T. Nagy; Oliver Hawlitschek; Miguel Vences
2                                                Terry Erwin; Lyubomir Penev; Pavel Stoev; Teodor Georgiev
3                                              Andrew D. C. MacColl; Aliya El Nagar; Job de Roij; Tom Webb
4                                                                                      Kenneth J. McNamara
5 Rute B. G Clemente-Carvalho; Ariovaldo A Giaretta; Thais H Condez; Célio F. B Haddad; Sergio F. dos Reis
6                               Ariel Rodríguez; Dennis Poth; Stefan Schulz; Marcelo Gehara; Miguel Vences
7                                                                  Kenneth D. Angielczyk; Chris R. Feldman
  year publication_type                                doi fl_count volume
1 2013        full_text          10.1007/s13127-013-0152-4        0   <NA>
2 2012        full_text           10.3897/zookeys.251.4516        2    251
3 2013        full_text            10.1111/1365-2656.12028        0     82
4 2012        full_text          10.1007/s12052-012-0420-3        2      5
5 2012        full_text 10.1655/HERPETOLOGICA-D-11-00085.1        0     68
6 2013        full_text        10.1016/j.ympev.2013.04.031        0     68
7 2013        full_text                  10.1111/bij.12010        1    108
  issue first_page
1  <NA>       <NA>
2     0          1
3     3        642
4     2        203
5     3        365
6     3        541
7     4        727
```


## Alt-metrics total citations from all sources.


```r
almtotals(doi = "10.1371/journal.pbio.0000012")
```

```
  views shares bookmarks citations
1 30208      0       112       324
```


## Get title of article by inputting the doi for the article.


```r
almtitle(doi = "10.1371/journal.pbio.0000012")
```

```
[1] "Genome-Wide RNAi of C. elegans Using the Hypersensitive rrf-3 Strain Reveals Novel Gene Functions"
```



## Retrieve and plot PLOS article-level metrics signposts.


```r
dat <- signposts(doi = "10.1371/journal.pone.0029797")
plot_signposts(input = dat)
```

![plot of chunk signposts1](figure/signposts1.png) 


Or plot many identifiers gives a line chart


```r
dois <- c("10.1371/journal.pone.0001543", "10.1371/journal.pone.0040117", "10.1371/journal.pone.0029797", 
    "10.1371/journal.pone.0039395")
dat <- signposts(doi = dois)
plot_signposts(input = dat)
```

![plot of chunk signposts2](figure/signposts2.png) 


Or make an interactive chart by doing `plot_signposts(input=dat, type="multiBarChart")`. Try it out! It should open in your browser and you can interact with it.

## Density and histogram plots from PLOS Article Level Metrics data

Note: Do you the key below in the `searchplos` call in this example, but if you plan to use rplos more, get your own API key [here](http://api.plos.org/).


```r
library(rplos)
library(plyr)
dois <- searchplos(terms = "science", fields = "id", toquery = list("cross_published_journal_key:PLoSONE", 
    "doc_type:full", "publication_date:[2010-01-01T00:00:00Z TO 2010-12-31T23:59:59Z]"), 
    limit = 200)
```


Remove non-full article DOIs


```r
dois <- dois$id
dois <- dois[!grepl("annotation", dois)]
```


Collect altmetrics data and combine to a `data.frame` with `ldply`


```r
alm <- alm(doi = dois, total_details = TRUE)
alm <- ldply(alm)
```


The default plot


```r
plot_density(alm)
```

![plot of chunk plot_densityplot1](figure/plot_densityplot1.png) 


You can change the color of the density plot


```r
plot_density(alm, color = "#EFA5A5")
```

![plot of chunk plot_densityplot2](figure/plot_densityplot2.png) 


Pass in a title or description subtending the title


```r
plot_density(alm, title = "Scopus citations from 2010")
```

![plot of chunk plot_densityplot3](figure/plot_densityplot3.png) 


Plot a particular source


```r
names(alm)[1:35]
```

```
 [1] ".id"                 "doi"                 "title"              
 [4] "publication_date"    "citeulike_pdf"       "citeulike_html"     
 [7] "citeulike_shares"    "citeulike_groups"    "citeulike_comments" 
[10] "citeulike_likes"     "citeulike_citations" "citeulike_total"    
[13] "crossref_pdf"        "crossref_html"       "crossref_shares"    
[16] "crossref_groups"     "crossref_comments"   "crossref_likes"     
[19] "crossref_citations"  "crossref_total"      "nature_pdf"         
[22] "nature_html"         "nature_shares"       "nature_groups"      
[25] "nature_comments"     "nature_likes"        "nature_citations"   
[28] "nature_total"        "pubmed_pdf"          "pubmed_html"        
[31] "pubmed_shares"       "pubmed_groups"       "pubmed_comments"    
[34] "pubmed_likes"        "pubmed_citations"   
```

```r
plot_density(input = alm, source = "crossref_citations")
```

![plot of chunk plot_densityplot4](figure/plot_densityplot4.png) 


Plot many sources in different panels in the same plot, and pass in colors just for fun


```r
plot_density(input = alm, source = c("counter_total", "crossref_citations", 
    "twitter_total", "wos_citations"), color = c("#83DFB4", "#EFA5A5", "#CFD470", 
    "#B2C9E4"))
```

![plot of chunk plot_densityplot5](figure/plot_densityplot5.png) 

