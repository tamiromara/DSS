#----------------------------
# Author: Tamir Omara
# Title: Downloading Files
# Week: 01
# Class: 04
#----------------------------

#Move into your working directory
setwd("/home/teomara/gettingCleaningData/")
#Check if the file exists in the directory
if(!file.exists("data")) {dir.create("data")}

#Save the URL into a variable for ease of use:
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
#Download file: [you might want to chose another method depending on your OS]
download.file(fileUrl, destfile = "data/camera.csv", method = "wget")
#Record the Download Data:
dateDownloaded <- date()

#List Files available on the directory:
list.files("data/")
