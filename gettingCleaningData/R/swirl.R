# -----------------------
# Author : Tamir Omara
# Title : Swirl Activity
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
# rename    : rename variables in a dataframe

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
arrange(cran2, desc(ip_id))       # arrange rows of cran descendingly according to ip_id
arrange(cran2, package, ip_id)    # arrange rows ascendingly according to package names THEN ip_id
arrange(cran2, country, desc(r_version), ip_id)

# ----------------------------------------------------------------------------------------
# mutate    : add new variables/columns or transform existing ones                       -
# ----------------------------------------------------------------------------------------
cran3 <- select(cran, ip_id, package, size)
mutate(cran3, size_mb = size / 2^20)  # create size_mb variable and add to the end of df 
mutate(cran3, size_mb = size / 2^20, size_gb = size_mb / 2^10)
mutate(cran3, correct_size = size + 1000)

# ----------------------------------------------------------------------------------------
# summarize : generate summary statistics                                                -
# ----------------------------------------------------------------------------------------
summarize(cran, avg_bytes = mean(size)) # returns mean of all values in the size column!

# summarize if more interesting when used with data that has been grouped by values of
# a particular variable.
# The main idea behind grouping data is that you want to break up your dataset into groups
# of rows based on the values of one or more variables. This can be done with group_by

cran <- tbl_df(mydf)                  # put mydf into a data frame table.
by_package <- group_by(cran, package) # any operation applied to the grouped data will take
                                      # place on a per package basis.

summarize(by_package, mean(size)) # mean download size for each package, df is grouped by package already.

# n()                : total no. of rows i.e. downloads for each package.
# n_distinct(ip_id)  : total no. of unique downloads for each package measured by distinct ip_id
# n_distinct(country): no. of countries in which each package was downloaded.
# mean(size)         : average download size for each package in bytes.
pack_sum <- summarize(by_package,
                      count     = n(),
                      unique    = n_distinct(ip_id),
                      countries = n_distinct(country),
                      avg_byte  = mean(size))

# What was the most popular package on that day based on count ie no. of downloads?
quantile(pack_sum$count, probs = 0.99)      # 1. find the 0.99 or 99%, sample quantile and bottom 99%
top_counts <- filter(pack_sum, count > 679) # 2. isolate packages which had more than 679 total downloads.
top_counts_sorted <- arrange(top_counts, desc(count)) # arrange from most to less based on count.

quantile(pack_sum$unique, probs = 0.99)
top_unique <- filter(pack_sum, unique > 465)
