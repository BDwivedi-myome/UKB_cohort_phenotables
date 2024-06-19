####
# 
# This script converts the pickle-formatted files to rda-object
#
#
####

# required libraries
pkgs <- c("reticulate")
notFound <- pkgs[!(pkgs %in% installed.packages()[, "Package"])]
if(length(notFound)) install.packages(notFound)
library(reticulate)
#reticulate::install_python(version = '3.10')
#py_install("pandas")

# define function to load pickle formatted files
source_python("/home/bhakti/projects/repos/code/funcs/read_pkl.py")

# assign input and output directories for datasets
output.dir <- "/home/bhakti/projects/repos/datasets/"
input.dir <- "/myome/share/ukb/dnanexus/datasets/"

# read all relevant pickle file names
age_vars_pkl <- file.path(input.dir, "age_vars.pkl") #2GB file!
diag_vars_pkl <- file.path(input.dir, "diagnosis_vars.pkl")
dreg_vars_pkl <- file.path(input.dir, "dreg_vars.pkl")
smoke_vars_pkl <- file.path(input.dir, "smoke_vars.pkl")
alc_vars_pkl <- file.path(input.dir, "alc_vars.pkl")
phys_act_vars_pkl <- file.path(input.dir, "phys_act_vars.pkl")
base_vars_pkl <- file.path(input.dir, "base_vars.pkl")
pop_vars_pkl <- file.path(input.dir, "pop_vars.pkl")
sysbp_vars_pkl <- file.path(input.dir, "sysbp_vars.pkl")
diabp_vars_pkl <- file.path(input.dir, "diabp_vars.pkl")
hb_vars_pkl <- file.path(input.dir, "hb_vars.pkl")
trigly_vars_pkl <- file.path(input.dir, "trigly_vars.pkl")
urate_vars_pkl <- file.path(input.dir, "urate_vars.pkl")
urine_vars_pkl <- file.path(input.dir, "urine_df.pkl")
meds_vars_pkl <- file.path(input.dir, "meds_vars.pkl")
rel_vars_pkl <- file.path(input.dir, "ukb_rel.dat")

# name the resepctive rda files
age_vars_rda <- file.path(output.dir, "age_vars.Rda") #2GB file!
diag_vars_rda <- file.path(output.dir, "diagnosis_vars.Rda")
dreg_vars_rda <- file.path(output.dir, "dreg_vars.Rda")
smoke_vars_rda <- file.path(output.dir, "smoke_vars.Rda")
alc_vars_rda <- file.path(output.dir, "alc_vars.Rda")
phys_act_vars_rda <- file.path(output.dir, "phys_act_vars.Rda")
base_vars_rda <- file.path(output.dir, "base_vars.Rda")
pop_vars_rda <- file.path(output.dir, "pop_vars.Rda")
sysbp_vars_rda <- file.path(output.dir, "sysbp_vars.Rda")
diabp_vars_rda <- file.path(output.dir, "diabp_vars.Rda")
hb_vars_rda <- file.path(output.dir, "hb_vars.Rda")
trigly_vars_rda <- file.path(output.dir, "trigly_vars.Rda")
urate_vars_rda <- file.path(output.dir, "urate_vars.Rda")
urine_vars_rda <- file.path(output.dir, "urine_df.Rda")
meds_vars_rda <- file.path(output.dir, "meds_vars.Rda")
rel_vars_rda <- file.path(output.dir, "ukb_rel.Rda")


# relatedness data [.dat file]
rel_vars <- read.csv(rel_vars_pkl, sep=" ", header=T)
dim(rel_vars)
saveRDS(rel_vars, file=rel_vars_rda)

# age / recuritment dates
age_dates <- c(paste0("p53_i", 0:3), paste0("p41280_a", 0:258), paste0("p41281_a", 0:46))
age_vars <- read_pkl_file(age_vars_pkl, date_cols=age_dates)
saveRDS(age_vars, file=age_vars_rda)

# diagnosis
diag_vars <- read_pkl_file(diag_vars_pkl, date_cols=NULL)
dim(diag_vars)
saveRDS(diag_vars, file=diag_vars_rda)

# death registry
dreg_dates <- paste0("p40000_i", 0:1)
dreg_vars <- read_pkl_file(dreg_vars_pkl, date_cols=dreg_dates)
dim(dreg_vars)
saveRDS(dreg_vars, file=dreg_vars_rda)

# smoking
smoke_vars <- read_pkl_file(smoke_vars_pkl, date_cols=NULL)
dim(smoke_vars)
saveRDS(smoke_vars, file=smoke_vars_rda)

# alcohol
alc_vars <- read_pkl_file(alc_vars_pkl, date_cols=NULL)
dim(alc_vars)
saveRDS(alc_vars, file=alc_vars_rda)

# physical activity
phy_act_vars <- read_pkl_file(phys_act_vars_pkl, date_cols = NULL)
dim(phy_act_vars)
saveRDS(phy_act_vars, file=phys_act_vars_rda)

# baseline measurments
base_vars <- read_pkl_file(base_vars_pkl, date_cols = NULL)
dim(base_vars)
saveRDS(base_vars, file=base_vars_rda)

# ethnicity
pop_vars <- read_pkl_file(pop_vars_pkl, date_cols = NULL)
dim(pop_vars)
saveRDS(pop_vars, file=pop_vars_rda)

# blood pressure
sysbp_vars <- read_pkl_file(sysbp_vars_pkl, date_cols = NULL)
diabp_vars <- read_pkl_file(diabp_vars_pkl, date_cols = NULL)
saveRDS(sysbp_vars, file=sysbp_vars_rda)
saveRDS(diabp_vars, file=diabp_vars_rda)

# hemoglobin
assay_dates <- paste0("p30022_i", 0:2)
hb_vars <- read_pkl_file(hb_vars_pkl, date_cols = assay_dates)
saveRDS(hb_vars, file=hb_vars_rda)

# serum urate
assay_dates <- paste0("p30881_i", 0:1)
urate_vars <- read_pkl_file(urate_vars_pkl, date_cols = assay_dates)
saveRDS(urate_vars, file=urate_vars_rda)

# triglycerides and cholesterol
assay_dates = c(paste0("p30871_i", 0:1),
                paste0("p30781_i", 0:1),
                paste0("p30761_i", 0:1), 
                paste0("p30741_i", 0:1), 
                paste0("p30751_i", 0:1))
trigly_vars <- read_pkl_file(trigly_vars_pkl, date_cols = assay_dates)
saveRDS(trigly_vars, file=trigly_vars_rda)

# urine assays
assay_dates = c(paste0("p30701_i", 0:1),
                paste0("p30502_i", 0:1),
                paste0("p30512_i", 0:1))
urine_vars <- read_pkl_file(urine_vars_pkl, date_cols = assay_dates)
saveRDS(urine_vars, file=urine_vars_rda)

# medications / treatments
meds_vars <- read_pkl_file(meds_vars_pkl, date_cols = NULL)
dim(meds_vars)
saveRDS(meds_vars, file=meds_vars_rda)


