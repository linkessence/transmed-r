% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/med_translate_str_zh_en.R
\name{med_translate_str_zh_en}
\alias{med_translate_str_zh_en}
\title{Translate a string form Chinese to English.}
\usage{
med_translate_str_zh_en(str, transformer, dict_hash = NULL)
}
\arguments{
\item{str}{a string to be translated.}

\item{transformer}{the transformer object, initialized by \code{init_transformer}. if NULL,
translation will be performed by dictionaries only.}

\item{dict_hash}{a customerized dictionary hash table, made by \code{make_hash_from_dictionary}.}
}
\value{
English translation with confidence.
}
\description{
\code{med_translate_str_zh_en} translates a string from Chinese to English.
}
\details{
\code{med_translate_str_zh_en} translates a string from Chinese to English.  If the customized dictionary,
i.e. the parameter \code{dict_hash} is given, the function first checks if the given string is in the
customized dictionary. If the string is not found, or the customized dictionary is not given, the function
checks the system dictionary in the package data.  If the string is still not found, and the transformer
is given, the function tries to translate the string with as a free text with the transformer.

The returned value is a named vector with \code{translated} and \code{confidence}.  \code{translated}
is the translated text, and \code{confidence} is an integer number:

\itemize{
\item \code{confidence} = 3:  Translated with customerized dictionary.
\item \code{confidence} = 2:  Translated with system dictionary in the package.
\item \code{confidence} = 1:  Translated as a free text with transformer.
\item \code{confidence} = 0:  Not translated.  The \code{translated} is copied from the input string.
}
}
\examples{
# Initialize the transformer:
transformer <- init_transformer("C:/Users/<MyUserName>/Anaconda3/envs/transmed")

# Translate a string:
med_translate_str_zh_en("肠炎", transformer)

# Translate a string with customerized dictionary:
dict <- data.frame(en = c("Enteritis", "Gastritis"), zh = c("肠炎", "胃炎"))
dict_hash <- make_hash_from_dictionary(dict, from_column="zh", to_column="en")
med_translate_str_zh_en("肠炎", transformer, dict_hash)

# Translate a string with customerized dictionary, and prohibit free-text translation:
med_translate_str_zh_en("肠炎", NULL, dict_hash)

}
\seealso{
init_transformer, make_hash_from_dictionary, med_translate_str_en_zh
}
