rbace
=====



[![Project Status: WIP - Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](http://www.repostatus.org/badges/latest/wip.svg)](http://www.repostatus.org/#wip)
[![Build Status](https://travis-ci.org/ropenscilabs/rbace.svg?branch=master)](https://travis-ci.org/ropenscilabs/rbace)
[![codecov](https://codecov.io/gh/ropenscilabs/rbace/branch/master/graph/badge.svg)](https://codecov.io/gh/ropenscilabs/rbace)
[![rstudio mirror downloads](https://cranlogs.r-pkg.org/badges/rbace)](https://github.com/metacran/cranlogs.app)


* [BASE API docs][docs]
* [BASE - request access][token]

Data from BASE (Bielefeld Academic Search Engine) <https://www.base-search.net>

[<img src="inst/img/BASE_search_engine_logo.svg.png" width="300">](https://www.base-search.net)

## Install

Development version


```r
devtools::install_github("ropenscilabs/rbace")
```


```r
library("rbace")
```

## search

perform a search


```r
(res <- bs_search(coll = 'it', query = 'dccreator:manghi', boost = TRUE))
#> # A tibble: 10 × 32
#>                 dchdate
#>                   <chr>
#> 1  2015-03-26T21:03:04Z
#> 2  2015-03-26T21:03:37Z
#> 3  2015-03-26T21:03:04Z
#> 4  2015-03-26T21:03:37Z
#> 5  2015-03-26T21:03:37Z
#> 6  2015-03-26T21:03:37Z
#> 7  2015-03-26T21:03:49Z
#> 8  2015-03-26T21:02:27Z
#> 9  2015-03-26T21:03:37Z
#> 10 2015-03-26T21:03:24Z
#> # ... with 31 more variables: dcdocid <chr>, dccontinent <chr>,
#> #   dccountry <chr>, dccollection <chr>, dcprovider <chr>, dctitle <chr>,
#> #   dccreator <chr>, dcperson <chr>, dcsubject <chr>, dcdescription <chr>,
#> #   dcdate <chr>, dcyear <chr>, dctype <chr>, dctypenorm <chr>,
#> #   dcformat <chr>, dccontenttype <chr>, dcidentifier <chr>, dclink <chr>,
#> #   dcsource <chr>, dclanguage <chr>, dcrelation <chr>, dcrights <chr>,
#> #   dcdoi <chr>, dcoa <chr>, dclang <chr>, dcautoclasscode <chr>,
#> #   dcdeweyfull <chr>, dcdeweyhuns <chr>, dcdeweytens <chr>,
#> #   dcdeweyones <chr>, dcpublisher <chr>
```

get the search metadata


```r
bs_meta(res)
#> $query
#> # A tibble: 1 × 4
#>                q
#>            <chr>
#> 1 creator:manghi
#> # ... with 3 more variables: fl <chr>, fq <chr>, start <dbl>
#> 
#> $response
#> # A tibble: 1 × 2
#>   status num_found
#>    <dbl>     <dbl>
#> 1      0      1285
```


## Meta

* Please [report any issues or bugs](https://github.com/ropenscilabs/rbace/issues).
* License: MIT
* Get citation information for `rbace` in R doing `citation(package = 'rbace')`
* Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.

[![ropensci_footer](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org)

[docs]: https://www.base-search.net/about/download/base_interface.pdf
[token]: https://www.base-search.net/about/en/contact.php
