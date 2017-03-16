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

  # data are ; separated when more than 1 result
  ## dcsubject
  expect_match(aa$dcsubject[1], ";")
  expect_equal(length(strsplit(aa$dcsubject[1], ";")[[1]]), 5)

  ## dcidentifiers
  expect_match(aa$dcidentifier[1], ";")
  expect_equal(length(strsplit(aa$dcidentifier[1], ";")[[1]]), 2)
})

test_that("bs_search - bs_meta", {
  skip_on_cran()

  aa <- bs_search(coll = 'it', query = 'dccreator:manghi', boost = "oa")

  expect_is(aa, "tbl_df")
})

# test_that("bs_search - fails well", {
#   skip_on_cran()
#
#   expect_error(
#     bs_search(coll = 'it', query = 'dccreator:manghi', boost = "oa"),
#     ""
#   )
# })
