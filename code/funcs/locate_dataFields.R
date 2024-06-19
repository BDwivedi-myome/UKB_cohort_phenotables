install.packages("reticulate")
install.packages("stringdist")
reticulate::install_python(version = '3.10')
library(reticulate)
library(stringdist)
py_install("pandas")
source_python("/home/bhakti/projects/repos/code/funcs/read_pkl.py")

setwd("/home/bhakti")

## read the list of data fields 
df <- read.csv(file="/home/bhakti/projects/repos/datasets/CKD_data_filed_id.txt", sep="\t", header=F)
df_ids <- df$V1

## read the list of pickle data files
data_dir <- "/myome/share/ukb/dnanexus/datasets/"
pkl_files_in_dir <- list.files(data_dir, pattern="pkl")

aval_dfs <- c()
for(i in seq_along(pkl_files_in_dir)){
  print(pkl_files_in_dir[i])
  ls_pkl <- read_pkl_file(paste0(data_dir, pkl_files_in_dir[i]))
  col_names <- names(ls_pkl)
  edit_col_names <- gsub("^p|_.*", "", col_names)
  aval_dfs <- c(aval_dfs, edit_col_names)
}

## compare the pickle data fields to list of needed data fields
## find what is existing and what is missing
uniqaval_dfs <- unique(aval_dfs)
not_found <- setdiff(df_ids, uniqaval_dfs)
found <- intersect(df_ids, uniqaval_dfs)
