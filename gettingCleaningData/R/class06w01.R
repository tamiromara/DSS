#----------------------------
# Author: Tamir Omara
# Title: Reading Excel files
# Week: 01
# Class: 06
#----------------------------

#Set working directroy
setwd("/home/teomara/gettingCleaningData/")
#Check for directory and create if not found
if(!file.exists("data")) {dir.create("data")}

#Save the URL into a variable for ease of use:
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
#Download file: [you might want to chose another method depending on your OS]
download.file(fileUrl, destfile = "./data/camera.xlsx", method = "wget")
#Record the Download Data:
dateDownloaded <- date()

#Load the xlsx package:
#If you experience problems installing xlsx, have a look at notes/rjava-installation_instructions.md
install.packages("xlsx")
library(xlsx)

#Read data into R and assign it a variable name:
cameraData <- read.xlsx(file = "data/camera.xlsx", sheetIndex = 1, header = TRUE)

#similarly to read.table nrows, we can read specific rows in read.xlsx. columns can be selected as well:
cameraDataSubset <- read.xlsx(file = "data/camera.xlsx", sheetIndex = 1, colIndex = 2:3, rowIndex = 1:4) 
cameraDataSubset
