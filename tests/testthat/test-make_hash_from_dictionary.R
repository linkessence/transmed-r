#' Test cases of make_hash_from_dictionary.R
#'

testthat::test_that("make_hash_from_dictionary", {
  dict <- data.frame(from = c("a", "b", "c"), to = c("A", "B", "C"))
  hash <- make_hash_from_dictionary(dict, "from", "to")
  expect_equal(hash[["a"]], "A")
  expect_equal(hash[["b"]], "B")
})

# Path: tests/testthat/test-make_hash_from_dictionary.R
