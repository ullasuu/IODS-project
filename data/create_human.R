# Ulla Suulamo
# 28.11.2022
# IODS Assignment 4. Data wrangling for week 5 assignment

setwd("C:/Users/usuulamo/Introduction to Open Data Science PHD-302/IODS-project")

library(tidyverse)


# Read in “Human development” and “Gender inequality” data sets

hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

# Structure and dimensions
str(hd); dim(hd) # 195 observations of 8 variables
str(gii); dim(gii) # 195 observations of 10 variables


summary(hd)
summary(gii)


# Rename

hd <- hd %>% 
  rename(
    hdi_rank = `HDI Rank`,
    country = Country,
    hdi = `Human Development Index (HDI)`,
    le = `Life Expectancy at Birth`,
    ex_ed = `Expected Years of Education`,
    mean_ed = `Mean Years of Education`,
    gni = `Gross National Income (GNI) per Capita`,
    gni_hdi = `GNI per Capita Rank Minus HDI Rank`    
  )

gii <- gii %>%
  rename(
    gii_rank = `GII Rank`,
    country = `Country`,
    gii = `Gender Inequality Index (GII)`,               
    mmr = `Maternal Mortality Ratio`,
    abr = `Adolescent Birth Rate`,
    rep_parl = `Percent Representation in Parliament`,
    edusec_f = `Population with Secondary Education (Female)`,
    edusec_m = `Population with Secondary Education (Male)`,
    labo_f = `Labour Force Participation Rate (Female)`,    
    labo_m = `Labour Force Participation Rate (Male)`
  )


# New variables

gii <- gii %>%
  mutate(
    edusec_fm = edusec_f / edusec_m,
    labo_fm = labo_f / labo_m
  )

head(gii)


# Join datasets

human <- inner_join(hd, gii, by="country")
dim(human) # 195 observations of 19 variables


# Save
write_csv(human, "data/human.csv")

