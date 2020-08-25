rbace
=====



[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Build Status](https://travis-ci.org/ropensci/rbace.svg?branch=master)](https://travis-ci.org/ropensci/rbace)
[![codecov](https://codecov.io/gh/ropensci/rbace/branch/master/graph/badge.svg)](https://codecov.io/gh/ropensci/rbace)


Client for interacting with the Bielefeld Academic Search Engine API.

Docs: https://docs.ropensci.org/rbace/

BASE API docs: https://www.base-search.net/about/download/base_interface.pdf

Access: The BASE API is IP address AND user-agent (see note below) restricted. The user agent is set correctly if you use this package, but you still need to get your IP address(es) white-listed by BASE. Request access at: https://www.base-search.net/about/en/contact.php - Note: the BASE website has a search portal you can use from anywhere; it's just the API that is IP and user-agent restricted.

Terminology:

- an [IP address](https://en.wikipedia.org/wiki/IP_address) is the numeric label identifying a computer or server. the IP address for a computer can change, e.g., if you connect to a VPN
- a [user-agent](https://en.wikipedia.org/wiki/User_agent) is a string of text that identifies the software requesting data from a server (in this case BASE's API).

Data from BASE (Bielefeld Academic Search Engine) https://www.base-search.net

[<img src="man/figures/BASE_search_engine_logo.svg.png" width="300">](https://www.base-search.net)

## Install


```r
install.packages("rbace")
```

or the dev version


```r
remotes::install_github("ropensci/rbace")
# OR the below should install the same thing
install.packages("rbace", repos = "https://dev.ropensci.org")
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
#> 5 num_oa_cc_records  279                                             
#> 6 num_oa_pd_records  0                                               
#> 7 num_oa_records     279                                             
#> 8 num_records        279
```

## List repositories for a collection



```r
bs_repositories(coll = "ceu")
#> # A tibble: 3,027 x 2
#>    name                                                          internal_name  
#>    <chr>                                                         <chr>          
#>  1 Ukrainian Journal of Radiology and Oncology                   ftjukroj       
#>  2 M@n@gement (E-Journal)                                        ftjmgmt        
#>  3 Blick in die Wissenschaft (E-Journal)                         ftjbidw        
#>  4 thebmj (via Crossref)                                         crjcrbmj       
#>  5 UARTPress: OJS                                                ftuartpressojs 
#>  6 IOP Publishing (via Crossref)                                 crioppubl      
#>  7 Royal Society of Chemistry Journals, books & databases (via … crroyalschem   
#>  8 Brill (via Crossref)                                          crbrillap      
#>  9 Különbség (E-Journal)                                         ftjkulonbseg   
#> 10 Acta Cybernetica (E-Journal)                                  ftjactacyberne…
#> # … with 3,017 more rows
```

## Search

perform a search


```r
(res <- bs_search(coll = 'it', query = 'dccreator:manghi', boost = TRUE))
#> $docs
#> # A tibble: 10 x 32
#>    dchdate dcdocid dccontinent dccountry dccollection dcprovider dctitle
#>    <chr>   <chr>   <chr>       <chr>     <chr>        <chr>      <chr>  
#>  1 2017-0… 9be017… ceu         it        ftpuma       PUMAlab (… DRIVER…
#>  2 2017-0… 90f58a… ceu         it        ftpuma       PUMAlab (… Sfide …
#>  3 2017-0… 2c669c… ceu         it        ftpuma       PUMAlab (… OpenAI…
#>  4 2020-0… 338c5e… ceu         it        ftunivmodena Archivio … Multi-…
#>  5 2017-0… af1126… ceu         it        ftpuma       PUMAlab (… DRIVER…
#>  6 2017-0… fcaa8f… ceu         it        ftpuma       PUMAlab (… DRIVER…
#>  7 2017-0… b4843e… ceu         it        ftpuma       PUMAlab (… DRIVER…
#>  8 2017-0… 412c04… ceu         it        ftpuma       PUMAlab (… EFG191…
#>  9 2017-0… 967c7f… ceu         it        ftpuma       PUMAlab (… OpenAI…
#> 10 2017-0… 3d820d… ceu         it        ftpuma       PUMAlab (… DRIVER…
#> # … with 25 more variables: dccreator <chr>, dcperson <chr>, dcsubject <chr>,
#> #   dcdescription <chr>, dcdate <chr>, dcyear <chr>, dctype <chr>,
#> #   dctypenorm <chr>, dcformat <chr>, dccontenttype <chr>, dcidentifier <chr>,
#> #   dclink <chr>, dcsource <chr>, dclanguage <chr>, dcrelation <chr>,
#> #   dcrights <chr>, dcoa <chr>, dclang <chr>, dcpublisher <chr>,
#> #   dcautoclasscode <chr>, dcdeweyfull <chr>, dcdeweyhuns <chr>,
#> #   dcdeweytens <chr>, dcdeweyones <chr>, dcdoi <chr>
#> 
#> $facets
#> list()
#> 
#> attr(,"status")
#> [1] 0
#> attr(,"QTime")
#> [1] "124"
#> attr(,"q")
#> [1] "creator:manghi"
#> attr(,"fl")
#> [1] "dccollection,dccontenttype,dccontinent,dccountry,dccreator,dcauthorid,dcdate,dcdescription,dcdocid,dcdoi,dcformat,dcidentifier,dclang,dclanguage,dclink,dcorcid,dcperson,dcpublisher,dcrights,dcsource,dcsubject,dctitle,dcyear,dctype,dcclasscode,dctypenorm,dcdeweyfull,dcdeweyhuns,dcdeweytens,dcdeweyones,dcautoclasscode,dcrelation,dccontributor,dccoverage,dchdate,dcoa,dcrightsnorm"
#> attr(,"fq")
#> [1] " country:it -collection:(ftjmethode OR ftpenamultimedia)"
#> attr(,"bq")
#> [1] "oa:1^2"
#> attr(,"name")
#> [1] "response"
#> attr(,"numFound")
#> [1] 4866
#> attr(,"start")
#> [1] 0
#> attr(,"maxScore")
#> [1] "6.511785"
```

get the search metadata


```r
bs_meta(res)
#> $query
#> # A tibble: 1 x 4
#>   q         fl                                  fq                         start
#>   <chr>     <chr>                               <chr>                      <dbl>
#> 1 creator:… dccollection,dccontenttype,dcconti… " country:it -collection:…     0
#> 
#> $response
#> # A tibble: 1 x 2
#>   status num_found
#>    <dbl>     <dbl>
#> 1      0      4866
```


## Meta

* Please [report any issues or bugs](https://github.com/ropensci/rbace/issues).
* License: MIT
* Get citation information for `rbace` in R doing `citation(package = 'rbace')`
* Please note that this package is released with a [Contributor Code of Conduct](https://ropensci.org/code-of-conduct/). By contributing to this project, you agree to abide by its terms.

[![ropensci_footer](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org)
