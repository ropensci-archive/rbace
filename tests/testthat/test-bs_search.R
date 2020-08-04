context("bs_search")

test_that("bs_search works", {
  skip_on_cran()

  vcr::use_cassette("bs_search", {
    aa <- bs_search(target = 'ftubbiepub', query = 'lossau summann')
  })

  expect_is(aa, "list")
  expect_is(aa$docs, "tbl_df")
  expect_is(aa$facets, "list")
  expect_is(aa$docs$dcdocid, "character")
  expect_is(aa$docs$dctitle, "character")

  # attributes
  expect_type(attr(aa, "start"), "double")
  expect_type(attr(aa, "numFound"), "double")
  expect_type(attr(aa, "q"), "character")
  expect_type(attr(aa, "fl"), "character")
  expect_type(attr(aa, "fq"), "character")

  # data are ; separated when more than 1 result
  ## dcsubject
  expect_match(aa$docs$dcsubject[1], ";")
  expect_equal(length(strsplit(aa$docs$dcsubject[1], ";")[[1]]), 5)

  ## dcidentifiers
  expect_match(aa$docs$dcidentifier[1], ";")
  expect_equal(length(strsplit(aa$docs$dcidentifier[1], ";")[[1]]), 2)
})

test_that("bs_search - bs_meta", {
  skip_on_cran()

  vcr::use_cassette("bs_search_meta", {
    aa <- bs_search(coll = 'it', query = 'dccreator:manghi', boost_oa = TRUE) 
  })

  expect_is(aa, "list")
  expect_is(aa$docs, "tbl_df")
  expect_is(aa$facets, "list")
})

test_that("bs_search - facets work", {
  skip_on_cran()

  vcr::use_cassette("bs_search_facets", {
    aa <- bs_search(coll = 'it', query = 'dccreator:manghi', boost_oa = TRUE)
  })

  expect_is(aa, "list")
  expect_is(aa$docs, "tbl_df")
  expect_is(aa$facets, "list")
})

test_that("bs_search - fails well", {
  skip_on_cran()

  expect_error(
    bs_search(target = 'ftubbiepub', boost_oa = 5),
    "class logical"
  )
  expect_error(
    bs_search(target = 'ftubbiepub', raw = 5),
    "class logical"
  )
  expect_error(
    bs_search(target = 'ftubbiepub', offset = ""),
    "class integer"
  )
})

test_that("bs_retry_options", {
  expect_is(bs_retry_options, "function")
  expect_is(bs_retry_options(), "list")
  expect_named(bs_retry_options())
  expect_equal(bs_retry_options(times=5)$times, 5)
  expect_error(bs_retry_options(a=5))
})

test_that("bs_search - retry options", {
  skip_on_cran()
  skip_if_not_installed("webmockr")
  tr <- function(...) tryCatch(..., error = function(e) e)

  loadNamespace("webmockr")
  webmockr::enable()

  webmockr::stub_request("get", 
    "https://api.base-search.net/cgi-bin/BaseHttpSearchInterface.fcgi?func=PerformSearch&query=lossau%20summann&facet_limit=100") %>% 
    webmockr::to_return(status = 429)
  retries_0 <- system.time(tr(bs_search(query = 'lossau summann')))
  webmockr::stub_registry_clear()

  webmockr::stub_request("get", 
    "https://api.base-search.net/cgi-bin/BaseHttpSearchInterface.fcgi?func=PerformSearch&query=lossau%20summann&facet_limit=100") %>% 
    webmockr::to_return(status = 429, times = 3)
  retries_2 <- system.time(tr(bs_search(query = 'lossau summann', retry = bs_retry_options(pause_min = 2))))
  webmockr::stub_registry_clear()

  expect_gt(retries_2[["elapsed"]], retries_0[["elapsed"]])

  webmockr::disable()
})
