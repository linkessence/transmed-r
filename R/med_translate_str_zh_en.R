#' Translate a string form Chinese to English.
#'
#' \code{med_translate_str_zh_en} translates a string from Chinese to English.
#'
#' @param str a string to be translated.
#' @param transformer functions to transform the string, initialized by \code{init_transformers}.
#' @return English translation with confidence.
#'
#' @export
#'
med_translate_str_zh_en <- function(str, transformer) {
  if (is.null(str)) {
    return(c("translated" = NULL, "confidence" = 2))
  }

  str_trimed <- stringr::str_trim(str)

  if (str_trimed == "") {
    return(c("translated" = "", "confidence" = 2))
  }

  if (is.null(med_dict_hash_zh_en)) {
    load(system.file("data/med_dict_hash.rda", package = "medtrans"))
  }

  if (hash::has.key(str_trimed, med_dict_hash_zh_en)) {
    return(c("translated" = med_dict_hash_en_zh[[str_trimed]], "confidence" = 2))
  }

  if (is.null(transformer)) {
    warning("transformer is NULL.")
    return(c("translated" = "", "confidence" = 0))
  }

  return(c("translated" = transformer$zh_en(str_trimed)[[1]]$translation_text,
           "confidence" = 1))
}
