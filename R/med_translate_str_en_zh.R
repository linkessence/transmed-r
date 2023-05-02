#' Translate a string form English to Chinese.
#'
#' \code{med_translate_str_en_zh} translates a string from English to Chinese.
#'
#' @param str a string to be translated.
#' @param transformer the transformer object, initialized by \code{init_transformer}. if NULL,
#'        translation will be performed by dictionaries only.
#' @param dict_hash a customerized dictionary hash table, made by \code{make_hash_from_dictionary}.
#' @return Chinese translation with confidence.
#'
#' @details
#' \code{med_translate_str_en_zh} translates a string from English to Chinese.  If the customized dictionary,
#' i.e. the parameter \code{dict_hash} is given, the function first checks if the given string is in the
#' customized dictionary. If the string is not found, or the customized dictionary is not given, the function
#' checks the system dictionary in the package data.  If the string is still not found, and the transformer
#' is given, the function tries to translate the string with as a free text with the transformer.
#'
#' The returned value is a named vector with \code{translated} and \code{confidence}.  \code{translated}
#' is the translated text, and \code{confidence} is an integer number:
#'
#' \itemize{
#'      \item \code{confidence} = 3:  Translated with customerized dictionary.
#'      \item \code{confidence} = 2:  Translated with system dictionary in the package.
#'      \item \code{confidence} = 1:  Translated as a free text with transformer.
#'      \item \code{confidence} = 0:  Not translated.  The \code{translated} is copied from the input string.
#'}
#'
#' @examples
#' # Initialize the transformer:
#' transformer <- init_transformer("C:/Users/<MyUserName>/Anaconda3/envs/transmed")
#'
#' # Translate a string:
#' med_translate_str_en_zh("Enteritis", transformer)
#'
#' # Translate a string with customerized dictionary:
#' dict <- data.frame(en = c("Enteritis", "Gastritis"), zh = c("肠炎", "胃炎"))
#' dict_hash <- make_hash_from_dictionary(dict, from_column="en", to_column="zh")
#' med_translate_str_en_zh("Enteritis", transformer, dict_hash)
#'
#' # Translate a string with customerized dictionary, and prohibit free-text translation:
#' med_translate_str_en_zh("Enteritis", NULL, dict_hash)
#'
#' @seealso init_transformer, make_hash_from_dictionary, med_translate_str_zh_en
#' @export
#'
med_translate_str_en_zh <- function(str,
                                    transformer,
                                    dict_hash = NULL) {
  if (is.null(str)) {
    return(NULL)
  }

  str_lower <- stringr::str_trim(tolower(str))

  if (str_lower == "") {
    return(c("translated" = "", "confidence" = 2))
  }

  if (!is.null(dict_hash)) {
    if (hash::has.key(str_lower, dict_hash)) {
      return(c("translated" = dict_hash[[str_lower]], "confidence" = 3))
    }
  }

  if (hash::has.key(str_lower, med_dict_hash_en_zh)) {
    return(c("translated" = med_dict_hash_en_zh[[str_lower]], "confidence" = 2))
  }

  if (is.null(transformer)) {
    return(c("translated" = str, "confidence" = 0))
  }

  return(c("translated" = transformer$en_zh(str_lower)[[1]]$translation_text,
           "confidence" = 1))
}

# Path: R/med_translate_str_en_zh.R
