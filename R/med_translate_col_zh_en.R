#' Translate a data column form Chinese to English.
#'
#' \code{med_translate_col_zh_en} translates a data column from Chinese to English.
#' @param col a data column to translate.
#' @param transformer the transformer object, initialized by \code{init_transformer}.
#' @param dict_hash a customerized dictionary hash table, made by \code{make_hash_from_dictionary}.
#' @return a new data frame with English translation, and confidence.
#'
#' @export
#'

med_translate_col_zh_en <- function(col,
                                    transformer,
                                    dict_hash = NULL) {
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
      t <- med_translate_str_zh_en(col[[i]], transformer, dict_hash)
      translated[[i]] <- t[[1]]
      confidence[[i]] <- as.integer(t[[2]])
    }
  }

  return (data.frame(translated, confidence))
}

# Path: R/med_translate_col_zh_en.R
