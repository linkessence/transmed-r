#' Test cases of available_languages.R
#'

testthat::test_that("available_languages", {
  expect_equal(available_languages(), c('en', 'zh'))
})

# Path: tests/testthat/test-available_languages.R
