#' Translate a string form English to Chinese.
#'
#' \code{med_translate_str_en_zh} translates a string from English to Chinese.
#'
#' @param str a string to be translated.
#' @param transformer functions to transform the string, initialized by \code{init_transformers}.
#' @return Chinese translation with confidence.
#'
#' @export
#'
med_translate_str_en_zh <- function(str, transformer) {
  if (is.null(str)) {
    return(c("translated" = NULL, "confidence" = 2))
  }

  str_lower <- stringr::str_trim(tolower(str))

  if (str_lower == "") {
    return(c("translated" = "", "confidence" = 2))
  }

  if (is.null(med_dict_hash_en_zh)) {
    load(system.file("data/med_dict_hash.rda", package = "medtrans"))
  }

  if (hash::has.key(str_lower, med_dict_hash_en_zh)) {
    return(c("translated" = med_dict_hash_en_zh[[str_lower]], "confidence" = 2))
  }

  if (is.null(transformer)) {
    warning("transformer is NULL.")
    return(c("translated" = "", "confidence" = 0))
  }

  return(c("translated" = transformer$en_zh(str_lower)[[1]]$translation_text,
           "confidence" = 1))
}
