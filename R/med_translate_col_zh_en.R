#' Translate a data column form Chinese to English.
#'
#' \code{med_translate_col_zh_en} translates a data column from Chinese to English.
#' @param col a data column to translate.
#' @return a new data frame with English translation, and confidence.
#'
#' @export
#'

med_translate_col_zh_en <- function(col) {
  if (is.null(col)) {
    return(NULL)
  }

  n <- length(col)
  translated <- character(length=n)
  confidence <- integer(length=n)

  for (i in seq_along(col)) {
    if (is.null(col[[i]])) {
      translated[[i]] <- NULL
      confidence[[i]] <- 0
    } else {
      t <- med_translate_str_zh_en(col[[i]])
      translated[[i]] <- t$translated
      confidence[[i]] <- t$confidence
    }
  }

  return (data.frame(translated, confidence))
}
