rbace
=====



[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Build Status](https://travis-ci.org/ropensci/rbace.svg?branch=master)](https://travis-ci.org/ropensci/rbace)
[![codecov](https://codecov.io/gh/ropensci/rbace/branch/master/graph/badge.svg)](https://codecov.io/gh/ropensci/rbace)


Client for interacting with the Bielefeld Academic Search Engine API.

* BASE API docs: https://www.base-search.net/about/download/base_interface.pdf
* You may have to ask for access for one or more of IP addresses you'll be accessing BASE from, but you may not. It used to be the case, but now seems like it's not IP restricted anymore. If you do need to, request access: https://www.base-search.net/about/en/contact.php

Data from BASE (Bielefeld Academic Search Engine) https://www.base-search.net

[<img src="man/figures/BASE_search_engine_logo.svg.png" width="300">](https://www.base-search.net)

## Install


```r
remotes::install_github("ropensci/rbace")
```


```r
library("rbace")
```

## Get the profile for a repository



```r
bs_profile(target = "ftjhin")
#> # A tibble: 8 x 2
#>   name               value                                           
#>   <chr>              <chr>                                           
#> 1 activation_date    2019-12-05                                      
#> 2 country            de                                              
#> 3 name               HiN - Alexander von Humboldt im Netz (E-Journal)
#> 4 num_non_oa_records 0                                               
#> 5 num_oa_cc_records  273                                             
#> 6 num_oa_pd_records  0                                               
#> 7 num_oa_records     273                                             
#> 8 num_records        273
```

## List repositories for a collection



```r
bs_repositories(coll = "ceu")
#> # A tibble: 2,870 x 2
#>    name                                                          internal_name  
#>    <chr>                                                         <chr>          
#>  1 Redescriptions: Political Thought, Conceptual History and Fe… ftjredescripti…
#>  2 Open archive Nord universitet                                 ftnorduniv     
#>  3 Open archive  Nofima                                          ftnofima       
#>  4 NHH Brage Norges Handelshøyskole                              ftnorgehandels…
#>  5 International Journal of Agricultural and Natural Sciences    ftjijans       
#>  6 EUDL European Union Digital Library                           fteudl         
#>  7 SURF Data Repository                                          ftsurfsara     
#>  8 Zeitschrift für Parteienwissenschaften (E-Journal)            ftjmip         
#>  9 Revista Portuguesa de Investigação Comportamental e Social (… ftjrpics       
#> 10 Erciyes University Research Information System                fterciyesuniv  
#> # … with 2,860 more rows
```

## Search

perform a search


```r
(res <- bs_search(coll = 'it', query = 'dccreator:manghi', boost = TRUE))
#> $docs
#> # A tibble: 10 x 31
#>    dchdate dcdocid dccontinent dccountry dccollection dcprovider dctitle
#>    <chr>   <chr>   <chr>       <chr>     <chr>        <chr>      <chr>  
#>  1 2017-0… 90f58a… ceu         it        ftpuma       PUMAlab (… Sfide …
#>  2 2017-0… 2c669c… ceu         it        ftpuma       PUMAlab (… OpenAI…
#>  3 2017-0… 9be017… ceu         it        ftpuma       PUMAlab (… DRIVER…
#>  4 2017-0… 412c04… ceu         it        ftpuma       PUMAlab (… EFG191…
#>  5 2017-0… 967c7f… ceu         it        ftpuma       PUMAlab (… OpenAI…
#>  6 2017-0… 3d820d… ceu         it        ftpuma       PUMAlab (… DRIVER…
#>  7 2017-0… 242b25… ceu         it        ftpuma       PUMAlab (… DRIVER…
#>  8 2017-0… af1126… ceu         it        ftpuma       PUMAlab (… DRIVER…
#>  9 2017-0… fcaa8f… ceu         it        ftpuma       PUMAlab (… DRIVER…
#> 10 2017-0… b4843e… ceu         it        ftpuma       PUMAlab (… DRIVER…
#> # … with 24 more variables: dccreator <chr>, dcperson <chr>, dcsubject <chr>,
#> #   dcdescription <chr>, dcpublisher <chr>, dcdate <chr>, dcyear <chr>,
#> #   dctype <chr>, dctypenorm <chr>, dcformat <chr>, dccontenttype <chr>,
#> #   dcidentifier <chr>, dclink <chr>, dcsource <chr>, dclanguage <chr>,
#> #   dcrelation <chr>, dcrights <chr>, dcoa <chr>, dclang <chr>,
#> #   dcautoclasscode <chr>, dcdeweyfull <chr>, dcdeweyhuns <chr>,
#> #   dcdeweytens <chr>, dcdeweyones <chr>
#> 
#> $facets
#> list()
#> 
#> attr(,"status")
#> [1] 0
#> attr(,"QTime")
#> [1] "40"
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
#> [1] 4504
#> attr(,"start")
#> [1] 0
#> attr(,"maxScore")
#> [1] "6.2445545"
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
#> 1      0      4504
```


## Meta

* Please [report any issues or bugs](https://github.com/ropensci/rbace/issues).
* License: MIT
* Get citation information for `rbace` in R doing `citation(package = 'rbace')`
* Please note that this project is released with a [Contributor Code of Conduct][coc].
By participating in this project you agree to abide by its terms.

[![ropensci_footer](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org)

[coc]: https://github.com/ropensci/rbace/blob/master/CODE_OF_CONDUCT.md
