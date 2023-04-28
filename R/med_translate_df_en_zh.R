#' Translate a data frame form English to Chinese.
#'
#' \code{med_translate_df_en_zh} translates a data frame from English to Chinese.
#'
#' @param df a data frame to translate.
#' @param transformer the transformer object, initialized by \code{init_transformer}.
#' @param col_names a vector of column names to translate. If \code{NULL}, all columns will be translated.
#' @param dict_map a named vector of customerized dictionary.
#' @return a new data frame with Chinese translation.
#'
#' @export
#'

med_translate_df_en_zh <- function(df,
                                   transformer,
                                   col_names = NULL,
                                   dict_map = NULL) {
    if (is.null(df)) {
        return(NULL)
    }

    if (is.null(col_names)) {
        col_names <- names(df)
    }

    res <- df

    for (col_name in names(df)) {
      dict <- NULL
      if (!is.null(dict_map) && col_name %in% names(dict_map)) {
        dict <- dict_map[[col_name]]
      }

      if (col_name %in% col_names && typeof(df[[col_name]]) == "character") {
          res[[col_name]] <- med_translate_col_en_zh(df[[col_name]], transformer, dict)[[1]]
      }
    }

    return(res)
}

# Path: R/med_translate_df_en_zh.R
