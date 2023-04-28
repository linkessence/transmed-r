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
