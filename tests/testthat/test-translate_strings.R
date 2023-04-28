#' Test cases of string translations.
#'

source("fake_transformer.R")

testthat::test_that("med_translate_str_en_zh", {
  expect_null(med_translate_str_en_zh(NULL, NULL))
  expect_equal(med_translate_str_en_zh("", NULL), c("translated" = "", "confidence" = 2))
  expect_equal(med_translate_str_en_zh("one ", NULL), c("translated" = "一", "confidence" = 2))
  expect_equal(med_translate_str_en_zh("male", NULL), c("translated" = "男性", "confidence" = 2))
  expect_equal(med_translate_str_en_zh("aabbcc", fake_transformer()),
               c("translated" = "aabbcc", "confidence" = 1))
})

testthat::test_that("med_translate_str_zh_en", {
  expect_null(med_translate_str_zh_en(NULL, NULL))
  expect_equal(med_translate_str_zh_en("", NULL), c("translated" = "", "confidence" = 2))
  expect_equal(med_translate_str_zh_en("一 ", NULL), c("translated" = "One", "confidence" = 2))
  expect_equal(med_translate_str_zh_en("男性", NULL), c("translated" = "Male", "confidence" = 2))
  expect_equal(med_translate_str_zh_en("aabbcc", fake_transformer()),
               c("translated" = "aabbcc", "confidence" = 1))
})

testthat::test_that("med_translate_str_en_zh_with_dict_hash", {
  dict <- data.frame(from = c("a", "b", "c"), to = c("A", "B", "C"))
  hash <- make_hash_from_dictionary(dict, "from", "to")
  expect_equal(med_translate_str_en_zh("a", NULL, hash), c("translated" = "A", "confidence" = 3))
})

testthat::test_that("med_translate_str_zh_en_with_dict_hash", {
  dict <- data.frame(from = c("a", "b", "c"), to = c("A", "B", "C"))
  hash <- make_hash_from_dictionary(dict, "from", "to")
  expect_equal(med_translate_str_zh_en("a", NULL, hash), c("translated" = "A", "confidence" = 3))
})

# Path: tests/testthat/test-translate_strings.R
