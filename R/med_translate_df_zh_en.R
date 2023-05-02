#' Translate a data frame form Chinese to English.
#'
#' \code{med_translate_df_zh_en} translates a data frame from Chinese to English.
#'
#' @param df a data frame to translate.
#' @param transformer the transformer object, initialized by \code{init_transformer}. if NULL,
#'        translation will be performed by dictionaries only.
#' @param col_names a vector of column names to translate. If \code{NULL}, all columns will be translated.
#' @param dict_map a named vector of customerized dictionary.
#' @return a new data frame with English translation.
#'
#' @details
#' \code{med_translate_df_zh_en} translates a data frame from Chinese to English. It returns a new data frame
#' with translation.  The number of rows and columns of the output data frame, along with column names, will be
#' the same as the input data frame.
#'
#' You may select which columns to be translated with the \code{col_names} parameter.  If the parameter
#' \code{col_names} is NULL, the function checkes the data type of each column first.  Only character columns
#' are translated; columns with data type other than \code{character} will be copied.
#'
#' You may also use customized dictionaries for some of the columns.  To use customerize dictionaries,
#' you need to convert them into hash tables with the \code{make_hash_from_dictionary} first, then make a
#' named vector of \code{Column name, Hash table} as the parameter \code{dict_map}.
#'
#' @examples
#' # Initialize the transformer:
#' transformer <- init_transformer("C:/Users/<MyUserName>/Anaconda3/envs/transmed")
#'
#' # Translate a data frame:
#' df <- data.frame(
#'   Name = c("John", "Mary"),
#'   Age = c(29, 32),
#'   Gender = c("男性", "女性"),
#'   Disease = c("肠炎", "胃炎")
#' )
#'
#' med_translate_df_zh_en(df, transformer, col_names = c("Gender", "Disease"))
#'
#' # Translate with customerized dictionaries:
#' dict_gender <- data.frame(en = c("Male", "Female"), zh = c("男性", "女性"))
#' dict_gender_hash <- make_hash_from_dictionary(dict_gender, from_column="zh", to_column="en")
#'
#' dict_disease <- data.frame(en = c("Enteritis", "Gastritis"), zh = c("肠炎", "胃炎"))
#' dict_disease_hash <- make_hash_from_dictionary(dict_disease, from_column="zh", to_column="en")
#'
#' med_translate_df_zh_en(df,
#'                        transformer,
#'                        col_names = c("Gender", "Disease"),
#'                        dict_map = c(Gender = dict_gender, Disease = dict_disease))
#'
#' @seealso med_translate_df_en_zh, init_transformer, make_hash_from_dictionary
#'
#' @export
#'

med_translate_df_zh_en <- function(df,
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
      res[[col_name]] <- med_translate_col_zh_en(df[[col_name]], transformer, dict)[[1]]
    } 
  }

  return(res)
}

# Path: R/med_translate_df_zh_en.R
