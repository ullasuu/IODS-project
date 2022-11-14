# Ulla Suulamo
# 12.11.2022
# IODS Assignment 2. Data wrangling using JYTOPKYS3-data (https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-meta.txt)

library(tidyverse)

#Read in data

student2014  <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", 
                     sep = "\t", header = T)

#  Explore

dim(student2014)
#There are 183 observations and 60 variables
str(student2014)
# 59 of the variables are continuous and 1 is categorical.


#  Fix variables

#Scale Attitude to original scale
student2014$attitude <- student2014$Attitude / 10
#Create combination variables as the means of a selection of variables
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
student2014$deep <- rowMeans(student2014[, deep_questions])
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
student2014$surf <- rowMeans(student2014[, surface_questions])
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
student2014$stra <- rowMeans(student2014[, strategic_questions])


#  Create an analysis dataset
 
learning2014 <- student2014 %>% 
  rename(age = Age) %>% 
  rename(points = Points) %>% 
  select(gender, age, attitude, deep, stra, surf, points) %>% 
  filter(points != 0)


#  Check structure

dim(learning2014)
#There are now 166 observations and 7 variables
str(learning2014)
# 6 of the variables are continuous and 1 is categorical


#  Save

setwd("C:/Users/usuulamo/Introduction to Open Data Science PHD-302/IODS-project")
write_csv(learning2014, "data/learning2014.csv")

lrn2014 <- read_csv("data/learning2014.csv")
str(lrn2014)
head(lrn2014)
# All seems to be be ok: there are 166 observations and 7 variables
# of which 1 is character and 6 numerical 
