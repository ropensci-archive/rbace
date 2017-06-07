context("bs_search")

test_that("bs_search works", {
  skip_on_cran()

  aa <- bs_search(target = 'ftubbiepub', query = 'lossau summann')

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

  aa <- bs_search(coll = 'it', query = 'dccreator:manghi', boost_oa = TRUE)

  expect_is(aa, "list")
  expect_is(aa$docs, "tbl_df")
  expect_is(aa$facets, "list")
})

test_that("bs_search - facets work", {
  skip_on_cran()

  aa <- bs_search(coll = 'it', query = 'dccreator:manghi', boost_oa = TRUE)

  expect_is(aa, "list")
  expect_is(aa$docs, "tbl_df")
  expect_is(aa$facets, "list")
})

# test_that("bs_search - fails well", {
#   skip_on_cran()
#
#   expect_error(
#     bs_search(coll = 'it', query = 'dccreator:manghi', boost = "oa"),
#     ""
#   )
# })
