rbace
=====



[![Build Status](https://travis-ci.org/ropenscilabs/rbace.svg?branch=master)](https://travis-ci.org/ropenscilabs/rbace)

* [BASE API docs][docs]
* [BASE - request access][token]

Data from Bielefeld Academic Search Engine <https://www.base-search.net>

<img src="inst/img/BASE_search_engine_logo.svg" width="300">

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
#>                                                                     dctitle
#>                                                                       <chr>
#> 1  Sfide tecnologiche per l'accesso aperto a tutti i prodotti della ricerca
#> 2                    EFG1914 - EFG metadata schema extension: documentation
#> 3                OpenAIREplus - OpenAIREPlus specification and release plan
#> 4                      DRIVER II - Compound object model integration report
#> 5                                      DRIVER II - Information space report
#> 6                                       OpenAIRE - Data Model Specification
#> 7       Traps for sacrifice: Bateson's schizophrenic and Girard's scapegoat
#> 8              DRIVER - A European Digital Repository Infrastructure - Demo
#> 9                           DRIVER II - Compound object model specification
#> 10                                        DRIVER II - Software release plan
#> # ... with 31 more variables: dcdescription <chr>, dccountry <chr>,
#> #   dccreator <chr>, dcperson <chr>, dcsource <chr>, dccollection <chr>,
#> #   dcprovider <chr>, dctypenorm <chr>, dcpublisher <chr>, dcdocid <chr>,
#> #   dcrelation <chr>, dccontinent <chr>, dclang <chr>, dcformat <chr>,
#> #   dcrights <chr>, dccontenttype <chr>, dcdate <chr>, dcyear <chr>,
#> #   dclanguage <chr>, dchdate <chr>, dcdoi <chr>, dclink <chr>,
#> #   dcidentifier <chr>, dcsubject <chr>, dctype <chr>, dcoa <chr>,
#> #   dcautoclasscode <chr>, dcdeweytens <chr>, dcdeweyones <chr>,
#> #   dcdeweyhuns <chr>, dcdeweyfull <chr>
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
#> 1      0      1061
```


## Meta

* Please [report any issues or bugs](https://github.com/ropenscilabs/rbace/issues).
* License: MIT
* Get citation information for `rbace` in R doing `citation(package = 'rbace')`
* Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.

[![ropensci_footer](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org)

[docs]: https://www.base-search.net/about/download/base_interface.pdf
[token]: https://www.base-search.net/about/en/contact.php
