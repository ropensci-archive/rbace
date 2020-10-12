skip_on_ci()
skip_on_cran()

test_that("utils: ct", {
  expect_is(ct, "function")
  expect_length(ct(list(NULL, 5)), 1)
})

test_that("utils: bs_base", {
  expect_is(bs_base, "function")
  expect_is(bs_base(), "character")
  expect_match(bs_base(), "BaseHttpSearchInterface")
})

test_that("utils: rbace_ua", {
  expect_is(rbace_ua, "function")
  expect_is(rbace_ua(), "character")
  expect_match(rbace_ua(), "crul")
  expect_match(rbace_ua(), "rOpenSci")
})

test_that("utils: assert", {
  expect_is(assert, "function")
  expect_null(assert("asdf", "character"))
})
