# Script - looking at data from Caroline 

# need to use haven
rm(list = ls())


require(readr)
require(haven)
require(readxl)

require(stringr)
require(tidyr)
require(plyr)
require(dplyr)
require(car)

require(ggplot2)


mfsdata <- read_spss(path = "data/patient_level/MFSData_v1_2.sav")


mfsdata %>% 
  mutate(sex2 = as_factor(sex, levels = c("label"))) %>% View

mfsdata %>% 
  mutate(over2 = as_factor(over, levels = c("label"))) %>% View

xtabs(~ sex + over, data = mfsdata)


# > sex2 <- as.numeric(mfsdata$sex)
# > sex2
# [1] 0 1 1 0 0 1 0 0 1 1 1 0 1 1 0 1 1 0 1 0 0 1 1 1 1 0 1 1 0 1 0 1 1 0 1 1 1 0 1 0 1 1 0 1
# [45] 1 0 0 1 1 1 1 0 0 0 0 1 1 1 1 0 0 1 1 0 1 0 1 0 1 0 1 0 1 0 0 0 0 1 1 1 0 0 0 1 0 0 1 0
# [89] 1 0 0 1 1 1 0 1 1 0 0 1 0 1 1 1 0 0 0 0 1 1 0 0 0 0 1 1 0 1 0 1 0 1 0 0 0 1 0 1 1 0 1 1
# [133] 0 0 1 0 0 0 0 1 1 0 0 0 0 1 1 1 1 1 0 1 1 1 0 1 0 0 1 0 0 1 1 1 1 1 0 0 0 0 1 0 1 0 0 1
# [177] 1 1 1 0 0 0 1 1 1 0 1 0 1 1 1 0 0 1 0 1 1 1 0 0
# > l_sex <- attr(mfsdata$sex, "labels")
# > l_sex
# Male Female 
# 0      1 

# > factor(sex2, levels = c(0, 1), labels = l_sex)
# [1] 0 1 1 0 0 1 0 0 1 1 1 0 1 1 0 1 1 0 1 0 0 1 1 1 1 0 1 1 0 1 0 1 1 0 1 1 1 0 1 0 1 1 0 1
# [45] 1 0 0 1 1 1 1 0 0 0 0 1 1 1 1 0 0 1 1 0 1 0 1 0 1 0 1 0 1 0 0 0 0 1 1 1 0 0 0 1 0 0 1 0
# [89] 1 0 0 1 1 1 0 1 1 0 0 1 0 1 1 1 0 0 0 0 1 1 0 0 0 0 1 1 0 1 0 1 0 1 0 0 0 1 0 1 1 0 1 1
# [133] 0 0 1 0 0 0 0 1 1 0 0 0 0 1 1 1 1 1 0 1 1 1 0 1 0 0 1 0 0 1 1 1 1 1 0 0 0 0 1 0 1 0 0 1
# [177] 1 1 1 0 0 0 1 1 1 0 1 0 1 1 1 0 0 1 0 1 1 1 0 0
# Levels: 0 1
# > factor(sex2, levels = c(0, 1), labels = names(l_sex))
# This works 
# There seems to be an issue with the first level being 0 rather than 1
# 
 # Also note the need to use of names(...) rather than (...) for labels 


# test this by looking at educ, where first value is 1



