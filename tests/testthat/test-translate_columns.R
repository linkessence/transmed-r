#' Test cases of column translations.
#'

source("fake_transformer.R")

testthat::test_that("med_translate_col_en_zh", {
  expect_null(med_translate_col_en_zh(NULL, NULL))

  dict <- data.frame(from = c("a", "b", "c"), to = c("A", "B", "C"))
  hash <- make_hash_from_dictionary(dict, "from", "to")

  col <- c("", "one", "male", "aabbcc", "a")
  res <- med_translate_col_en_zh(col, fake_transformer(), hash)
  expect_equal(res$translated, c("", "一", "男性", "aabbcc", "A"))
  expect_equal(res$confidence, c(2, 2, 2, 1, 3))
})

testthat::test_that("med_translate_col_zh_en", {
  expect_null(med_translate_col_zh_en(NULL, NULL))

  dict <- data.frame(from = c("a", "b", "c"), to = c("A", "B", "C"))
  hash <- make_hash_from_dictionary(dict, "from", "to")

  col <- c("", "一", "男性", "aabbcc", "a")
  res <- med_translate_col_zh_en(col, fake_transformer(), hash)
  expect_equal(res$translated, c("", "One", "Male", "aabbcc", "A"))
  expect_equal(res$confidence, c(2, 2, 2, 1, 3))
})

# Path: tests/testthat/test-translate_columns.R