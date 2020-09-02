context("bs_profile")

skip_on_ci()

test_that("bs_profile works", {
  skip_on_cran()

  vcr::use_cassette("bs_profile", {
    aa <- bs_profile(target = "ftjhin")
  })

  expect_is(aa, "tbl_df")
  expect_is(aa$name, "character")
  expect_is(aa$value, "character")
  expect_equal(NCOL(aa), 2)

  # longer set of target values work
  vcr::use_cassette("bs_profile_test_many", {
    ids <- c("ftjmip", "ftjfasal", "ftjsub", "ftumagdeburgojs", "ftjhsyntax",
      "ftjkimkompakt")
    for (i in ids) expect_is(bs_profile(target = i), "tbl_df")
  })
})

test_that("bs_profile - fails well", {
  skip_on_cran()

  expect_error(bs_profile(5), "class character")
})
