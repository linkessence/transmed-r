#' Initialize transformers
#'
#' \code{init_transformers} initialize transformers for translation.
#' @param condaenv path of the conda environment to use.
#' @param model_en_zh model for English to Chinese translation.
#' @param model_zh_en model for Chinese to English translation.
#'
#' @return the transformer object.
#'
#' @export
#'
init_transformers <- function (condaenv,
                               model_en_zh = "Helsinki-NLP/opus-mt-en-zh",
                               model_zh_en = "Helsinki-NLP/opus-mt-zh-en") {
  reticulate::use_condaenv(condaenv)
  reticulate::import("transformers")
  reticulate::use_condaenv(condaenv, required = TRUE)

  transformers <- reticulate::import("transformers")
  trans_en_zh <- transformers$pipeline("translation", model = model_en_zh)
  trans_zh_en <- transformers$pipeline("translation", model = model_zh_en)

  return (c("en_zh" = trans_en_zh, "zh_en" = trans_zh_en))
}

# Path: R/init_transformer.R
