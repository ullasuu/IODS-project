# Ulla Suulamo
# 21.11.2022
# IODS Assignment 3. Data wrangling using Student Performance Data (https://archive.ics.uci.edu/ml/datasets/Student+Performance)

library(tidyverse)
library(dplyr)

setwd("C:/Users/usuulamo/Introduction to Open Data Science PHD-302/IODS-project")


# Read in data stored in the data folder of the IODS course project and explore structure and dimensions

mat <- read_csv2("data/student-mat.csv")
por <- read_csv2("data/student-por.csv")

dim(mat)
str(mat)
dim(por)
str(por)
#Both datasets contain 33 variables. Student-mat has 395 observations, and student-por 649 observations.


#  Join datasets

#Vector of "failures", "paid", "absences", "G1", "G2", "G3"
out_cols <- c("failures", "paid", "absences", "G1", "G2", "G3")
#Variables other than "out_cols"
in_cols <- setdiff(colnames(por), out_cols)
#Join using selected identifiers in in_cols. inner_join() keeps students that are present in mat AND por
mat_por <- inner_join(mat, por, by = in_cols, suffix = c(".mat", ".por"))
dim(mat_por)
str(mat_por)
#The combined dataset contain 39 variables and 370 observations


#  Get rid of duplicates. I just apply solution a.

alc <- select(mat_por, all_of(in_cols)) # a new data frame with the joined columns only
for(col_name in out_cols) {
  two_cols <- select(mat_por, starts_with(col_name))
  first_col <- select(two_cols, 1)[[1]]
  if(is.numeric(first_col)) {
    alc[col_name] <- round(rowMeans(two_cols))
  } else { 
    alc[col_name] <- first_col
  }
}
# glimpse at the new combined data
glimpse(alc)
#After fixing the duplicated answers now we have 33 variables and 370 observations


#  Create new variables

alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)  # Weekly alcohol consumption
alc <- mutate(alc, high_use = alc_use > 2) # High_use of alcohol


#  Check structure and save

dim(alc)
#The joined data has 370 observations of 35 variables
write_csv(alc, "data/alc.csv")






