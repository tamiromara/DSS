#----------------------------
# Author: Tamir Omara
# Title: Summarizing Data
# Week: 03
# Class: 
#----------------------------

# Creat Directory :
if(!file.exists("./gettingCleaningData/data")) {dir.create(data)}

# Download File :
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(url      = fileUrl, 
              destfile = "./gettingCleaningData/data/resturants.csv", 
              method   = "wget")
# Read File :
resData <- read.csv("gettingCleaningData/data/resturants.csv")

head(resData, 3)    # Display the top 3 rows of the data frame.
tail(resData, 3)    # Display the bottom 3 rows of the data frame.
summary(resData)    # Overall summary of the data frame.
str(resData)        # More information about the data frame.

quantile(resData$councilDistrict, na.rm = TRUE)             #   
quantile(resData$councilDistrict, probs = c(0.5, 0.75,0.9)) # look at different quantiles of the distribution

table(resData$zipCode, useNA = "ifany")         # Make a table of certain variable(s) 
                                                # useNA will add a column to the table and count NA values.
                                                # table donsn't give the no. of missiong values by default.
table(resData$councilDistrict, resData$zipCode) # Creates two dimensional table. Discrit in rows. Zip in Columns

sum(is.na(resData$councilDistrict)) # is.na will return 1 if missing. 0 otherwise.
any(is.na(resData$councilDistrict)) # if any value is TRUE, TRUE is returned. otherwise FALSE.
all(resData$zipCode > 0)
colSums(is.na(resData)) # Calculate sums accross columns 
all(colSums(is.na(resData)) == 0) # TRUE if all are equal to 0. No missing values.

table(resData$zipCode %in% c("21212"))              # Find all the zip codes with specified value. Notice double quotes.
table(resData$zipCode %in% c("21212", "21213"))     # Either equal to one or the other

resData[resData$zipCode %in% c("21212", "21213"), ] # Subsetting

# Cross Tabs
# Flat tables

object.size(resData)                      # Calculate the size of dataset in bytes.
print(object.size(resData), units = "Mb") #Calculate the size of dataset in MB.



