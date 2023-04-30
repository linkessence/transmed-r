#' Test cases of data frame translations.
#'

source("fake_transformer.R")

make_test_df <- function () {
  Name <- c("John", "Bill", "Maria", "Ben", "Tina")
  Age <- c(23, 41, 32, 58, 26)
  Race <- c("White", "African American", "Black", "Asian", "White")
  Gender <- c("Male", "Male", "Female", "Male", "Female")
  Customerized <- c("a", "b", "c", "a", "b")

  return (data.frame(Name, Age, Race, Gender, Customerized))
}

testthat::test_that("med_translate_df_en_zh", {
  expect_null(med_translate_df_en_zh(NULL, NULL))

  source <- make_test_df()
  target <- med_translate_df_en_zh(source, fake_transformer(), NULL, NULL)

  expect_equal(names(target), names(source))
  expect_equal(length(target[[1]]), length(source[[1]]))
  expect_equal(target$Gender, c("男性", "男性", "女性", "男性", "女性"))
  expect_equal(target$Customerized, c("a", "b", "c", "a", "b"))

  dict <- data.frame(from = c("a", "b", "c"), to = c("A", "B", "C"))
  hash <- make_hash_from_dictionary(dict, "from", "to")
  target <- med_translate_df_en_zh(source, fake_transformer(), NULL, c("Customerized" = hash))
  expect_equal(target$Customerized, c("A", "B", "C", "A", "B"))
})

testthat::test_that("med_translate_df_zh_en", {
  expect_null(med_translate_df_zh_en(NULL, NULL))

  source <- make_test_df()
  source <- med_translate_df_en_zh(source, fake_transformer(), NULL, NULL)
  target <- med_translate_df_zh_en(source, fake_transformer(), NULL, NULL)

  expect_equal(names(target), names(source))
  expect_equal(length(target[[1]]), length(source[[1]]))
  expect_equal(target$Gender, c("Male", "Male", "Female", "Male", "Female"))
  expect_equal(target$Customerized, c("a", "b", "c", "a", "b"))

  dict <- data.frame(from = c("a", "b", "c"), to = c("A", "B", "C"))
  hash <- make_hash_from_dictionary(dict, "from", "to")
  target <- med_translate_df_zh_en(source, fake_transformer(), NULL, c("Customerized" = hash))
  expect_equal(target$Customerized, c("A", "B", "C", "A", "B"))

})

# Path: tests/testthat/test-translate_dataframes.R
