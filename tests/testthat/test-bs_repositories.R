context("bs_repositories")

test_that("bs_repositories works", {
  skip_on_cran()

  vcr::use_cassette("bs_repositories", {
    aa <- bs_repositories(coll = "ceu")
  })

  expect_is(aa, "tbl_df")
  expect_is(aa$name, "character")
  expect_is(aa$internal_name, "character")
  expect_gt(NROW(aa), 20)
})

test_that("bs_repositories - fails well", {
  skip_on_cran()

  expect_error(bs_repositories(5), "class character")
})
