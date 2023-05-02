#' Translate a data column form English to Chinese.
#'
#' \code{med_translate_col_en_zh} translates a data column from English to Chinese.
#'
#' @param col a data column to translate.
#' @param transformer the transformer object, initialized by \code{init_transformer}. if NULL,
#'        translation will be performed by dictionaries only.
#' @param dict_hash a customerized dictionary hash table, made by \code{make_hash_from_dictionary}.
#' @return a new data frame with Chinese translation, and confidences.
#'
#' @details
#' \code{med_translate_col_en_zh} translates a data column, or a vector of strings, from English to Chinese.
#' It returns a data frame with two named columns.  The first column named \code{translated} contains
#' the translated strings, the second column named \code{confidence} contains confidence numbers of each
#' translated string.
#'
#' \itemize{
#'      \item \code{confidence} = 3:  Translated with customerized dictionary.
#'      \item \code{confidence} = 2:  Translated with system dictionary in the package.
#'      \item \code{confidence} = 1:  Translated as a free text with transformer.
#'      \item \code{confidence} = 0:  Not translated.  The \code{translated} is copied from the input string.
#' }
#'
#' Same as \code{med_translate_str_en_zh}, the \code{med_translate_col_en_zh} also accepts customerized
#' dictionary, which is a hash table generated from \code{make_hash_from_dictionary}.
#'
#' @examples
#' # Initialize the transformer:
#' transformer <- init_transformer("C:/Users/<MyUserName>/Anaconda3/envs/transmed")
#'
#' # Translate a vector of string:
#' src_data = c("Enteritis", "Gastritis")
#' med_translate_col_en_zh(src_data, transformer)
#'
#' # Translate a vector of string with customerized dictionary:
#' dict <- data.frame(en = c("Enteritis", "Gastritis"), zh = c("肠炎", "胃炎"))
#' dict_hash <- make_hash_from_dictionary(dict, from_column="en", to_column="zh")
#' med_translate_col_en_zh(src_data, transformer, dict_hash)
#'
#' # Translate a vector of string with customerized dictionary, and prohibit free-text translation:
#' med_translate_col_en_zh(src_data, NULL, dict_hash)
#'
#' @seealso med_translate_col_zh_en, med_translate_str_en_zh, init_transformer, make_hash_from_dictionary
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
