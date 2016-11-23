context("bs_search")

test_that("bs_search works", {
  skip_on_cran()

  aa <- bs_search(target = 'ftubbiepub', query = 'lossau summann')

  expect_is(aa, "tbl_df")
  expect_is(aa$dcdocid, "character")
  expect_is(aa$dctitle, "character")

  # attributes
  expect_type(attr(aa, "start"), "double")
  expect_type(attr(aa, "numFound"), "double")
  expect_type(attr(aa, "q"), "character")
  expect_type(attr(aa, "fl"), "character")
  expect_type(attr(aa, "fq"), "character")
})

test_that("bs_search - bs_meta", {
  skip_on_cran()

  aa <- bs_search(coll = 'it', query = 'dccreator:manghi', boost = "oa")

  expect_is(aa, "tbl_df")
})
