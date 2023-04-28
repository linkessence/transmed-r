#' Translate a string form English to Chinese.
#'
#' \code{med_translate_str_en_zh} translates a string from English to Chinese.
#'
#' @param str a string to be translated.
#' @param transformer the transformer object, initialized by \code{init_transformer}.
#' @param dict_hash a customerized dictionary hash table, made by \code{make_hash_from_dictionary}.
#' @return Chinese translation with confidence.
#'
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
    warning("transformer is NULL.")
    return(c("translated" = str, "confidence" = 0))
  }

  return(c("translated" = transformer$en_zh(str_lower)[[1]]$translation_text,
           "confidence" = 1))
}

# Path: R/med_translate_str_en_zh.R
