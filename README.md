rbace
=====



[![Project Status: WIP - Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![Build Status](https://travis-ci.org/ropensci/rbace.svg?branch=master)](https://travis-ci.org/ropensci/rbace)
[![codecov](https://codecov.io/gh/ropensci/rbace/branch/master/graph/badge.svg)](https://codecov.io/gh/ropensci/rbace)
[![rstudio mirror downloads](https://cranlogs.r-pkg.org/badges/rbace)](https://github.com/metacran/cranlogs.app)


* [BASE API docs][docs]
* [BASE - request access][token]

Data from BASE (Bielefeld Academic Search Engine) <https://www.base-search.net>

[<img src="inst/img/BASE_search_engine_logo.svg.png" width="300">](https://www.base-search.net)

## Install

CRAN version


```r
install.packages("rbace")
```

Development version


```r
devtools::install_github("ropensci/rbace")
```


```r
library("rbace")
```

## search

perform a search


```r
(res <- bs_search(coll = 'it', query = 'dccreator:manghi', boost = TRUE))
#> $docs
#> # A tibble: 10 x 32
#>    dchdate dcdocid dccontinent dccountry dccollection dcprovider dctitle
#>    <chr>   <chr>   <chr>       <chr>     <chr>        <chr>      <chr>  
#>  1 2017-0… af1126… ceu         it        ftpuma       PUMAlab (… DRIVER…
#>  2 2017-0… fcaa8f… ceu         it        ftpuma       PUMAlab (… DRIVER…
#>  3 2017-0… b4843e… ceu         it        ftpuma       PUMAlab (… DRIVER…
#>  4 2019-1… 338c5e… ceu         it        ftunivmodena Archivio … Multi-…
#>  5 2017-0… 90f58a… ceu         it        ftpuma       PUMAlab (… Sfide …
#>  6 2017-0… 2c669c… ceu         it        ftpuma       PUMAlab (… OpenAI…
#>  7 2017-0… 9be017… ceu         it        ftpuma       PUMAlab (… DRIVER…
#>  8 2017-0… 412c04… ceu         it        ftpuma       PUMAlab (… EFG191…
#>  9 2017-0… 967c7f… ceu         it        ftpuma       PUMAlab (… OpenAI…
#> 10 2017-0… 3d820d… ceu         it        ftpuma       PUMAlab (… DRIVER…
#> # … with 25 more variables: dccreator <chr>, dcperson <chr>, dcsubject <chr>,
#> #   dcdescription <chr>, dcdate <chr>, dcyear <chr>, dctype <chr>,
#> #   dctypenorm <chr>, dcformat <chr>, dccontenttype <chr>, dcidentifier <chr>,
#> #   dclink <chr>, dcsource <chr>, dclanguage <chr>, dcrelation <chr>,
#> #   dcrights <chr>, dcoa <chr>, dclang <chr>, dcdoi <chr>, dcpublisher <chr>,
#> #   dcautoclasscode <chr>, dcdeweyfull <chr>, dcdeweyhuns <chr>,
#> #   dcdeweytens <chr>, dcdeweyones <chr>
#> 
#> $facets
#> list()
#> 
#> attr(,"status")
#> [1] NA
#> attr(,"QTime")
#> [1] "0"
#> attr(,"q")
#> [1] "creator:manghi"
#> attr(,"fl")
#> [1] "dccollection,dccontenttype,dccontinent,dccountry,dccreator,dcauthorid,dcdate,dcdescription,dcdocid,dcdoi,dcformat,dcidentifier,dclang,dclanguage,dclink,dcperson,dcpublisher,dcrights,dcsource,dcsubject,dctitle,dcyear,dctype,dcclasscode,dctypenorm,dcdeweyfull,dcdeweyhuns,dcdeweytens,dcdeweyones,dcautoclasscode,dcrelation,dccontributor,dccoverage,dchdate,dcoa,dcrightsnorm"
#> attr(,"fq")
#> [1] " country:it -collection:ftpenamultimedia"
#> attr(,"bq")
#> [1] "oa:1^2"
#> attr(,"name")
#> [1] "response"
#> attr(,"numFound")
#> [1] 4500
#> attr(,"start")
#> [1] 0
#> attr(,"maxScore")
#> [1] "6.2059293"
```

get the search metadata


```r
bs_meta(res)
#> $query
#> # A tibble: 1 x 4
#>   q          fl                                     fq                     start
#>   <chr>      <chr>                                  <chr>                  <dbl>
#> 1 creator:m… dccollection,dccontenttype,dccontinen… " country:it -collect…     0
#> 
#> $response
#> # A tibble: 1 x 2
#>   status num_found
#>    <dbl>     <dbl>
#> 1     NA      4500
```


## Meta

* Please [report any issues or bugs](https://github.com/ropensci/rbace/issues).
* License: MIT
* Get citation information for `rbace` in R doing `citation(package = 'rbace')`
* Please note that this project is released with a [Contributor Code of Conduct][coc].
By participating in this project you agree to abide by its terms.

[![ropensci_footer](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org)

[docs]: https://www.base-search.net/about/download/base_interface.pdf
[token]: https://www.base-search.net/about/en/contact.php
