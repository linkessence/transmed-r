#' Make a fake transformer for tests.
#'

pass_through <- function(str) {
  t <- list("translation_text" = str)
  return(list(t))
}

fake_transformer <- function() {
  return(c("en_zh" = pass_through, "zh_en" = pass_through))
}
