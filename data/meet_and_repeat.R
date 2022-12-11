# Ulla Suulamo
# 10.12.2022
# IODS Assignment 6. Data wrangling

library(dplyr); library(tidyverse)

#  Load data sets (BPRS and RATS)
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", 
                   sep = "", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt",
                   sep = "", header = T)


#  Take a look - check variable names, view data contents, structure and summaries of variables 
names(BPRS); glimpse(BPRS); summary(BPRS)
#40 observations and 11 integer variables. One row for each subject and weekly ratings in columns
names(RATS); glimpse(RATS); summary(RATS)
#16 observations and 11 integer variables. One row for each rat and recorded weights in columns


#  Categorical variables to factors
#In BPRS data variables treatment & subject
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
#In RATS data variables ID & Group
RATS <- RATS %>% rename(id = ID, group = Group)
RATS$id <- factor(RATS$id)
RATS$group <- factor(RATS$group)


#  Convert to long form
BPRSL <-  pivot_longer(BPRS, cols=-c(treatment, subject),
                       names_to = "weeks", values_to = "bprs") %>% 
  mutate(week = as.integer(substr(weeks,5,5))) %>% # Add a week variable
  arrange(weeks)

RATSL <-  pivot_longer(RATS, cols=-c(group, id),
                       names_to = "WD", values_to = "weight") %>% 
  mutate(time = as.integer(substr(WD,3,5))) %>% # Add a time variable
  arrange(time)


#  Take a look at the new data sets 
names(BPRSL); str(BPRSL); head(BPRSL); summary(BPRSL)
#360 observations (20*9*2) and 5 variables. Several rows per subject, weekly ratings in separate rows
names(RATSL); glimpse(RATSL); summary(RATSL)
#176 observations (16*11) and 5 variables. Several rows per rat, recorded weights in separate rows


#  Save
setwd("C:/Users/usuulamo/Introduction to Open Data Science PHD-302/IODS-project")
write_csv(BPRSL, "data/BPRSL.csv")
write_csv(RATSL, "data/RATSL.csv")
