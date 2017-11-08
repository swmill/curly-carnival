# R-Script Title titanic_original
library(tidyverse)

# 0: Load the data in RStudio

titanic_original <- read.csv("titanic_original.csv")

# 0: Orignal age distribution and summary
Age_histogram_updated <- hist(titanic_original$age)
summary(titanic_original)

# 1: Port of embarkation (base R) 

titanic_original$embarked[titanic_original$embarked == ""] <- "S" 

# 2: Age (base R) 

titanic_original$age[is.na(titanic_original$age)] <- round(mean(titanic_original$age, na.rm = TRUE))

# 3: Lifeboat (base R)

titanic_original$boat[titanic_original$boat == ""] <- NA

# Prepare the output

titanic_clean <- titanic_original %>% 
  
  mutate(
    
    # 1: Port of embarkation 
    
    embarked = replace(embarked, embarked == "", "S"), 
    
    # 2.1: Age of passenger
    
    age = replace(age, is.na(age), round(mean(age, na.rm = TRUE))), 
    
    
    # 3: Lifeboat available
    
    boat = replace(boat, boat == "", NA), 
    
    # 4: Cabin
    
    has_cabin_number = ifelse(cabin == "",0,1)
    
  )

# 2.2 Adjusted view the Age and data
Age_histogram_updated <- hist(titanic_clean$age)
summary(titanic_clean)

# 5: Write the file.
write.csv(titanic_clean, file = "titanic_clean.csv", row.names = FALSE)