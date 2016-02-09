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



# Reading data ------------------------------------------------------------


# Reading data - reading text data ----------------------------------------

# Text data example


# example of reading in a csv file with leading metadata

census_2001_health <- read_csv(file = "data/text/S23.csv") # This fails

census_2001_health <- read_csv(
  file = "data/text/S23.csv",
  skip = 5) # This loads, but produces a warning

problems(census_2001_health)


census_2001_health <- read_csv(
  file = "data/text/S23.csv",
  skip = 5,
  na = "-" # This loads, and produces no warnings. However it has incorrectly defined '-' as missing data.
)

problems(census_2001_health)

census_2001_health <- read_csv(
  file = "data/text/S23.csv",
  skip = 5, 
  col_types = paste0(rep("c", 16), collapse = "")
)

problems(census_2001_health) 
glimpse(census_2001_health)



# Reading binary files ----------------------------------------------------


# Reading binary files part 1 - excel

lookup <- read_excel(
  path = "data/binary/replication_details.xlsx",
  sheet = "code_to_country_lookup"
  )

lookup
problems(lookup)
glimpse(lookup)

# Reading binary files part 2 - spss


poverty <- read_spss(path = "data/binary/poverty_dataset.sav")

poverty <- poverty %>% 
  mutate(
    country_group = as_factor(country_group, labels = "values"),
    high_deathrate = as_factor(high_deathrate, labels = "values")
  )

poverty
glimpse(poverty)



# String Tidying  ---------------------------------------------------------


# This section will work with the census_2001_health dataset, which has been typecase to 'chr' for all
# variables to avoid inducing and error


dta <- data.frame(
  place = rep(c("A", "B"), each = 3), 
  time = 1:3,
  count = c(4, "-", 1, 6, 2, 4)
) %>% tbl_df

dta

glimpse(dta)

dta2 <- dta %>% 
  mutate(
    count2 = as.numeric(str_replace(count, "-", "0"))
  )
dta2
glimpse(dta2)

rm(dta2)

dta <- dta %>% 
  mutate(
    count = as.numeric(str_replace(count, "-", "0"))
  )
dta
glimpse(dta)


# user defined function example of the above

change_dash_to_zero <- function(input){
  output <- input %>% 
    str_replace("-", "0") %>% 
    as.numeric

  return(output)  
}

dta <- data.frame(
  place = rep(c("A", "B"), each = 3), 
  time = 1:3,
  count = c(4, "-", 1, 6, 2, 4)
) %>% tbl_df
dta
glimpse(dta)

dta <- dta %>% 
  mutate(
    count = change_dash_to_zero(count)
  )
dta
glimpse(dta)

# Whitespace example
dta <- data.frame(
  sex = c("male", "male ", " female", "female"),
  value = c("500", "10 000", "40,000", "25")
) %>% tbl_df
dta
glimpse(dta)

clean_values <- function(input){
  output <- input %>% 
    str_replace(",", "") %>% 
    str_replace(" ", "") %>% 
    as.numeric
  
  return(output)
}

dta2 <- dta %>% 
  mutate(
    sex2 = str_trim(sex), 
    value2 = clean_values(value)
  )

dta2
glimpse(dta2)


# remove whitespace and convert to factor 
trim_and_factorise <- function(input){
  output <- input %>% 
    str_trim %>% 
    factor
  
  return(output)
}

dta2 <- dta %>% 
  mutate(
    sex2 = trim_and_factorise(sex), 
    value2 = clean_values(value),
    test1 = value > 2000,
    test2 = value2 > 2000
  )
dta2
glimpse(dta2)


rm(dta2)

dta <- dta %>% 
  mutate(
    sex = trim_and_factorise(sex),
    value = clean_values(value)
  )


census_2001_health %>% 
  gather("occupational_group", "count", -place, -sex, -age_and_health) %>% 
  separate(age_and_health, into = c("age", "health"), sep = "-", extra = "merge"))





# Tidy data extended example ----------------------------------------------

# using the census_2001_health dataframe loaded earlier

#Start by View ing the dataframe
View(census_2001_health)

# now to re-name the first three columns:

names(census_2001_health)[1:3] <- c("place", "sex", "age_and_health")




