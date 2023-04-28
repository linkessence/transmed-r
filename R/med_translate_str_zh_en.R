#' Translate a string form Chinese to English.
#'
#' \code{med_translate_str_zh_en} translates a string from Chinese to English.
#'
#' @param str a string to be translated.
#' @param transformer the transformer object, initialized by \code{init_transformer}.
#' @param dict_hash a customerized dictionary hash table, made by \code{make_hash_from_dictionary}.
#' @return English translation with confidence.
#'
#' @export
#'
med_translate_str_zh_en <- function(str,
                                    transformer,
                                    dict_hash = NULL) {
  if (is.null(str)) {
    return(NULL)
  }

  str_trimed <- stringr::str_trim(str)

  if (str_trimed == "") {
    return(c("translated" = "", "confidence" = 2))
  }

  if (!is.null(dict_hash)) {
    if (hash::has.key(str_trimed, dict_hash)) {
      return(c("translated" = dict_hash[[str_trimed]], "confidence" = 3))
    }
  }

  if (hash::has.key(str_trimed, med_dict_hash_zh_en)) {
    return(c("translated" = med_dict_hash_zh_en[[str_trimed]], "confidence" = 2))
  }

  if (is.null(transformer)) {
    warning("transformer is NULL.")
    return(c("translated" = str, "confidence" = 0))
  }

  return(c("translated" = transformer$zh_en(str_trimed)[[1]]$translation_text,
           "confidence" = 1))
}

# Path: R/med_translate_str_zh_en.R
