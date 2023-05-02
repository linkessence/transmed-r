#' Make hash table from dictionary.
#'
#' \code{make_hash_from_dictionary} makes the hash table from a customerized dictionary.
#'
#' @param dictionary a data frame contains a customerized dictionary.
#' @param from_column the column name of the source terms.
#' @param to_column the column name of the target terms.
#'
#' @return a hash table of the dictionary.
#'
#' @details
#' The dictionary should be a data frame with at least two columns. One column is the source terms
#' and another column is the target terms.  You can write the dictionary in a csv file and read it
#' via \code{read.csv}.  To make the hash table, the column names of the source terms and the target
#' terms should be specified in the parameters \code{from_column} and \code{to_column}.
#'
#' @examples
#' dictionary <- data.frame(english = c("apple", "banana", "orange"),
#'                          chinese = c("苹果", "香蕉", "橙子"))
#'
#' hash_en_zh <- make_hash_from_dictionary(dictionary, "english", "chinese")
#' hash_zh_en <- make_hash_from_dictionary(dictionary, "chinese", "english")
#'
#' @export
#'
make_hash_from_dictionary <- function(dictionary,
                                      from_column,
                                      to_column) {
  if (is.null(dictionary)) {
    stop("Parameter dictionary is NULL.")
    return (NULL)
  }

  names <- names(dictionary)

  if (!from_column %in% names) {
    stop("Parameter from_column is not valid.")
    return (NULL)
  }

  if (!to_column %in% names) {
    stop("Parameter to_column is not valid.")
    return (NULL)
  }

  return (hash::hash(tolower(dictionary[[from_column]]), dictionary[[to_column]]))
}

# Path: tests/testthat/test-make_hash_from_dictionary.R
