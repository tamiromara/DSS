# -----------------------
# Author : Tamir Omara
# Title : Introduction to dplyr
# Week : 03
# Class : 
# -----------------------

# --------------------------------------------------------------------------------------------------
# Summary       : Exploring publicly available download logs of RStudio's CRAN mirror through dplyr.
# Source        : http://cran-logs.rstudio.com/
# File source   : http://cran-logs.rstudio.com/2014/2014-07-08.csv.gz
# instructions  :   1. Download File & extract into project dir 
#                   2. set destfile value to match your desired downloaded destination.
#                   3. method "wget" worked on my ubuntu  14.04 x64 machine.
#                   4. Call read.csv with stringsAsFactors = FALSE

# Load necessary libraries :
library(dplyr)
library(R.utils)

# Download File : 
downUrl <- "http://cran-logs.rstudio.com/2014/2014-07-08.csv.gz"
download.file(url      = downUrl, 
              destfile = "./gettingCleaningData/data/2014-07-08.csv.gz", 
              method   = "wget")
download.date <- date()   # Record download date

# Unconpress file :
gunzip("./gettingCleaningData/data/2014-07-08.csv.gz")

# Read Data Frame and assign to mydf
mydf <- read.csv(file = "./gettingCleaningData/data/2014-07-08.csv", stringsAsFactors = FALSE)

dim(mydf)                 # view dimensions
head(mydf)                # preview data at the top of table
packageVersion("dplyr")   # check package version

# To work with dplyr, first we must load the data into the "Data Frame Table" or tbl_df :
cran <- tbl_df(mydf)
rm("mydf")    # remove df to avoide confusion


# ----------------------------------------------------------------------------------------
# select    : returns a subset of columns of a dataframe                                 -
# ----------------------------------------------------------------------------------------
select(cran, ip_id, package, country) # select three variables from cran
select(cran, r_arch:country)          # select r_arch through country
select(cran, country:r_arch)          # select country through r_arch
select(cran, -(X:size))               # select and drop x through size variables

# ----------------------------------------------------------------------------------------
# filter    : extract a subset of rows from a df based on logical condition              -
# ----------------------------------------------------------------------------------------
filter(cran, country == "IN", r_version <= "3.0.2") # filter by IN AND version
filter(cran, country == "US" | country == "IN")     # filter by US OR IN
filter(cran, size > 100500, r_os == "linux-gnu")    # filter by size AND r_os
filter(cran, !is.na(r_version))                     # filter non NA values from r_version

# ----------------------------------------------------------------------------------------
# arrange   : reorder rows of dataset according to values of a variable                  -
# ----------------------------------------------------------------------------------------
cran2 <- select(cran, size:ip_id) # select 
arrange(cran2, ip_id)             # arrange rows of cran ascendingly according to ip_id 




# rename    : rename variables in a dataframe
# mutate    : add new variables/columns or transform existing ones
# summarize : generate summary statistics 