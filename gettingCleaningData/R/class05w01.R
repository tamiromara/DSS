#----------------------------
# Author: Tamir Omara
# Title: Reading local files
# Week: 01
# Class: 05
#----------------------------

#Read file into R and assign it to a variable name
#read.file() will assume the file is tab seperated
cameraDataTable <- read.table("./data/camera.csv", header = TRUE, sep = ",")

#Reading limited rows before loading the entire dataset is a good practice.
#nrows,set the no. of rows to read
#skip, how many lines to skip before reading
cameraPreview <- read.table(file = "./data/camera.csv", nrows = 10, skip = 5, header = TRUE, sep = ",")
cameraPreview

#Look at the top 6 rows of the data
head(cameraDataTable)
#you can specify how many rows your want the head command to display:
head(cameraDataTable, 3)

#read.csv assument the file is comma seperated and sets header to TRUE
cameraDataCSV <- read.csv("data/camera.csv")
head(cameraDataCSV, 3)
