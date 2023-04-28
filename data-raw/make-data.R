#' Make dataset for the package
#'

med_dict <- read.csv("data-raw/med-dict.csv", stringsAsFactors = FALSE)

med_dict_hash_en_zh <- hash::hash(tolower(med_dict$en), med_dict$zh)
med_dict_hash_zh_en <- hash::hash(med_dict$zh, med_dict$en)

common_dict <- read.csv("data-raw/common-dict.csv", stringsAsFactors = FALSE)

for (i in seq_along(common_dict$en)) {
  med_dict_hash_en_zh[[tolower(common_dict$en[i])]] <- common_dict$zh[i]
  med_dict_hash_zh_en[[common_dict$zh[i]]] <- common_dict$en[i]
}

save(med_dict_hash_en_zh, med_dict_hash_zh_en, file = "R/sysdata.rda", compress = "xz")

rm(med_dict_hash_en_zh, med_dict_hash_zh_en, med_dict, common_dict)

print("Data files are generated / updated.")
print("Done.")

#Path: data-raw/make-data.R
