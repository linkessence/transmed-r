#' Translate a data column form English to Chinese.
#'
#' \code{med_translate_col_en_zh} translates a data column from English to Chinese.
#'
#' @param col a data column to translate.
#' @return a new data frame with Chinese translation, and confidences.
#'
#' @export
#'

med_translate_col_en_zh <- function(col) {
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
      t <- med_translate_str_en_zh(col[[i]])
      translated[[i]] <- t$translated
      confidence[[i]] <- t$confidence
    }
  }

  return (data.frame(translated, confidence))
}
