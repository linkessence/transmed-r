#' Translate a data column form English to Chinese.
#'
#' \code{med_translate_col_en_zh} translates a data column from English to Chinese.
#'
#' @param col a data column to translate.
#' @param transformer the transformer object, initialized by \code{init_transformer}.
#' @param dict_hash a customerized dictionary hash table, made by \code{make_hash_from_dictionary}.
#' @return a new data frame with Chinese translation, and confidences.
#'
#' @export
#'

med_translate_col_en_zh <- function(col,
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
      t <- med_translate_str_en_zh(col[[i]], transformer, dict_hash)
      translated[[i]] <- t[[1]]
      confidence[[i]] <- as.integer(t[[2]])
    }
  }

  return (data.frame(translated, confidence))
}

# Path: R/med_translate_col_en_zh.R
