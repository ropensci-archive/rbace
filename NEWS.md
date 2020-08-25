rbace 0.2.0
===========

### MINOR IMPROVEMENTS

First version to CRAN.

* replace `dplyr` with `data.table::rbindlist` (#6)
* two new functions: `bs_profile()`, `bs_repositories()` (#9)
* add faceting to `bs_search()` (#10)
* `bs_search()` now uses RETRY/GET http requests (#14)
* `bs_search()` gains new parameter `filter` that's passed to `fq` param for the Solr server (#15)
* `filter` parameter in `bs_search()` can be `character` and `AsIs` in case you need to prevent html escaping (#16)
