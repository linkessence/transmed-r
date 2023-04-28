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

\item{transformer}{functions to transform the string, initialized by \code{init_transformers}.}

\item{dict_hash}{a customerized dictionary hash table, made by \code{make_hash_from_dictionary}.}
}
\value{
English translation with confidence.
}
\description{
\code{med_translate_str_zh_en} translates a string from Chinese to English.
}