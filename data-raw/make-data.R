#' Make dataset for the package
#'
#' \code{make_data} makes the default dataset for the package.
#'
#' @details
#' This function should be called once, to make the default dataset \code{R/sysdata.rda} for the
#' package form preset dictionaries.
#'


# The medical dictionary
med_dict <- read.csv("data-raw/med-dict.csv", stringsAsFactors = FALSE)

med_dict_hash_en_zh <- hash::hash(tolower(med_dict$en), med_dict$zh)
med_dict_hash_zh_en <- hash::hash(med_dict$zh, med_dict$en)

# The common dictionary
common_dict <- read.csv("data-raw/common-dict.csv", stringsAsFactors = FALSE)

for (i in seq_along(common_dict$en)) {
  med_dict_hash_en_zh[[tolower(common_dict$en[i])]] <- common_dict$zh[i]
  med_dict_hash_zh_en[[common_dict$zh[i]]] <- common_dict$en[i]
}

# You can add more dictionaries here

# Save dictionaries into "R/sysdata.rda" file.
save(med_dict_hash_en_zh, med_dict_hash_zh_en, file = "R/sysdata.rda", compress = "xz")

# Clean up
rm(med_dict_hash_en_zh, med_dict_hash_zh_en, med_dict, common_dict)

print("Data files are generated / updated.")
print("Done.")

#Path: data-raw/make-data.R
