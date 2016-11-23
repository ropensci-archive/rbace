rbace
=====



[![Build Status](https://travis-ci.org/ropenscilabs/rbace.svg?branch=master)](https://travis-ci.org/ropenscilabs/rbace)

* [BASE API docs][docs]
* [BASE - request access][token]


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
(res <- bs_search(coll = 'it', query = 'dccreator:manghi', boost = "oa"))
#> # A tibble: 10 × 32
#>                                                             dcdocid
#>                                                               <chr>
#> 1  f898519257644410854586b3d0592ae2029580618017b56c73afa9761d8ecd88
#> 2  af11266426e4e17db308dd11cb9f1a39557545ed43eeba87a5431d05a1fb47b9
#> 3  90f58aae63988159d62b3f1bf3c7d9c8be2cd3a03fd6ddd6865e97c33c2007c3
#> 4  fcaa8f5f53d9195e418324565c6a43487ee8264a7b5aee30272e0d1b65bce144
#> 5  b4843e373d17a5310790ad7430b3fd2180c4895b4c8e36a8c1986f9f5f524d81
#> 6  967c7f525368ecac33718d2ec5e1feb73b9368a5be84e21cf8efdda93ec848f4
#> 7  3d820d06c163b43bf2fce2329f876df36c368987761cef1ab5a13ed7bd50aeb0
#> 8  9be017c21bfdb3141ab9c520881b19cd1803b4d6b987d05278dadc526db9595c
#> 9  242b251efd929998e12c53076c8f56bf0d3495c00f9797dde527a59edc1b5038
#> 10 2c669c2f1eff18ed419fb5c7c34423ff1c8e6e375c54f1a7ef9393a86cf897f7
#> # ... with 31 more variables: dcrelation <chr>, dccontinent <chr>,
#> #   dclang <chr>, dcrights <chr>, dctitle <chr>, dcdescription <chr>,
#> #   dcdate <chr>, dcyear <chr>, dchdate <chr>, dccountry <chr>,
#> #   dcdoi <chr>, dclink <chr>, dccreator <chr>, dcperson <chr>,
#> #   dccollection <chr>, dcprovider <chr>, dctypenorm <chr>,
#> #   dcidentifier <chr>, dctype <chr>, dcoa <chr>, dcsource <chr>,
#> #   dcformat <chr>, dccontenttype <chr>, dclanguage <chr>,
#> #   dcsubject <chr>, dcpublisher <chr>, dcautoclasscode <chr>,
#> #   dcdeweytens <chr>, dcdeweyones <chr>, dcdeweyhuns <chr>,
#> #   dcdeweyfull <chr>
```

get the search metadata


```r
bs_meta(res)
#> $query
#> # A tibble: 1 × 4
#>                q
#>            <chr>
#> 1 creator:manghi
#> # ... with 3 more variables: fl <chr>, fq <chr>, start <chr>
#> 
#> $response
#> # A tibble: 1 × 2
#>   status num_found
#>    <chr>     <chr>
#> 1      0      1034
```


## Meta

* Please [report any issues or bugs](https://github.com/ropenscilabs/rbace/issues).
* License: MIT
* Get citation information for `rbace` in R doing `citation(package = 'rbace')`
* Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.

[![ropensci_footer](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org)

[docs]: https://www.base-search.net/about/download/base_interface.pdf
[token]: https://www.base-search.net/about/en/contact.php
