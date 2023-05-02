#' Initialize transformer
#'
#' \code{init_transformers} initialize the transformer for translation.
#' @param condaenv path of the conda environment to use.
#' @param model_en_zh model for English to Chinese translation.
#' @param model_zh_en model for Chinese to English translation.
#'
#' @return the transformer object.
#'
#' @details
#' The transformer is initialized by the conda environment specified in the parameter \code{condaenv}.
#' To make the environment, you must install the Anaconda or Miniconda first.  Anaconda can be
#' downloaded from https://www.anaconda.com/download.
#'
#' The conda environment can be created by the following command in the Anaconda terminal:
#' \preformatted{
#' conda create -n transmed python=3.10
#' }
#'
#' After creating the environment, you can install the transformers package by the following command:
#' \preformatted{
#' conda activate transmed
#' conda install numpy scipy scikit-learn ipython
#' conda install pytorch -c pytorch
#' conda install transformers sentencepiece sacremoses
#' }
#'
#' The next step we recommend is to enter the \code{ipython} in the terminal, and load transformer models
#' into the cache:
#' \preformatted{
#' from transformers import pipeline
#' trans_en_to_zh = pipeline("translation", model="Helsinki-NLP/opus-mt-en-zh")
#' trans_zh_to_en = pipeline("translation", model="Helsinki-NLP/opus-mt-zh-en")
#' }
#'
#' The transformer will download models automatically from \code{HuggingFace}. If no error occurs,
#' the transformer and models are ready to use.  You can exit \code{ipython} by typing \code{exit()}.
#'
#' After installed Anaconda, created the conda environment, and loaded the models into the cache, you
#' will have created a new dictionary in your home dictionary, like
#' \preformatted{
#' C:/Users/<MyUserName>/Anaconda3/envs/transmed
#' }
#'
#' This dictionary will be the parameter \code{condaenv} in the function \code{init_transformer}.
#'
#' @examples
#' transformer <- init_transformer("C:/Users/<MyUserName>/Anaconda3/envs/transmed")
#'
#' @export
#'
init_transformer <- function (condaenv,
                              model_en_zh = "Helsinki-NLP/opus-mt-en-zh",
                              model_zh_en = "Helsinki-NLP/opus-mt-zh-en") {

  if (is.null(condaenv) || condaenv == "") {
    stop("condaenv is not specified.")
    return(NULL)
  }

  if (condaenv == "C:/Users/<MyUserName>/Anaconda3/envs/transmed") {
    # Fake condaenv for examples
    return(NULL)
  }

  reticulate::use_condaenv(condaenv)
  reticulate::import("transformers")
  reticulate::use_condaenv(condaenv, required = TRUE)

  transformers <- reticulate::import("transformers")
  trans_en_zh <- transformers$pipeline("translation", model = model_en_zh)
  trans_zh_en <- transformers$pipeline("translation", model = model_zh_en)

  return (c("en_zh" = trans_en_zh, "zh_en" = trans_zh_en))
}

# Path: R/init_transformer.R
