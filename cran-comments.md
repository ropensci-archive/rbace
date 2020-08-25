## Test environments
* local R installation, R 4.0.2
* ubuntu 16.04 (on travis-ci), R 4.0.2
* win-builder (devel)

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.

I have read and agree to the the CRAN policies at
https://cran.r-project.org/web/packages/policies.html

This package's main purpose is performing HTTP requests to a remote server. We can not unfortunately have examples run real HTTP requests because the service restricts access based on IP addresses. The unit tests are mocked though and so package behavior is tested even when HTTP requests can not be made.
