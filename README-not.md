rbace
=====



[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![cran checks](https://cranchecks.info/badges/worst/rbace)](https://cranchecks.info/pkgs/rbace)
[![R-check](https://github.com/ropensci/rbace/workflows/R-check/badge.svg)](https://github.com/ropensci/rbace/actions?query=workflow%3AR-check)
[![rstudio mirror downloads](https://cranlogs.r-pkg.org/badges/rbace?color=C9A115)](https://github.com/r-hub/cranlogs.app)
[![cran version](https://www.r-pkg.org/badges/version/rbace)](https://cran.r-project.org/package=rbace)


Client for interacting with the Bielefeld Academic Search Engine API.

Docs: https://docs.ropensci.org/rbace/

BASE API docs: https://www.base-search.net/about/download/base_interface.pdf

Access: The BASE API is IP address AND user-agent (see note below) restricted. The user agent is set correctly if you use this package, but you still need to get your IP address(es) white-listed by BASE. Request access at: https://www.base-search.net/about/en/contact.php - Note: the BASE website has a search portal you can use from anywhere; it's just the API that is IP and user-agent restricted.

Terminology:

- an IP address is the numeric label identifying a computer or server. the IP address for a computer can change, e.g., if you connect to a VPN
- a user-agent is a string of text that identifies the software requesting data from a server (in this case BASE's API).

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

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/rbace/issues).
* License: MIT
* Get citation information for `rbace` in R doing `citation(package = 'rbace')`
* Please note that this package is released with a [Contributor Code of Conduct](https://ropensci.org/code-of-conduct/). By contributing to this project, you agree to abide by its terms.

[![ropensci_footer](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org)
