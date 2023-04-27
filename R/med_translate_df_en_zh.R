#' Translate a data frame form English to Chinese.
#'
#' \code{med_translate_df_en_zh} translates a data frame from English to Chinese.
#'
#' @param df a data frame to translate.
#' @param col_names a vector of column names to translate. If \code{NULL}, all columns will be translated.
#' @return a new data frame with Chinese translation.
#'
#' @export
#'

med_translate_col_en_zh <- function(df, col_names) {
    if (is.null(df)) {
        return(NULL)
    }

    if (is.null(col_names)) {
        col_names <- names(df)
    }

    res <- df

    for (col_name in names(df)) {
      if (col_name %in% col_names && typeof(df[[col_name]]) == "character") {
          res[[col_name]] <- med_translate_col_en_zh(df[[col_name]])
      } else {
          res[[col_name]] <- df[[col_name]]
      }
    }

    return(df)
}
