#----------------------------
# Author: Tamir Omara
# Title: Reading XML
# Week: 01
# Class: 07
#----------------------------


library(XML)              #Load XML
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileUrl, useInternalNodes = TRUE) #Loads data
rootNode <- xmlRoot(doc)  #Wrapper element for the entire
xmlName(rootNode)         #Returns name of the document
names(rootNode)           #Returns names of the rootNode

rootNode[[1]]             #access the first element
rootNode[[1]][[2]]        #access the second element of the first element
xmlSApply(rootNode, xmlValue)
#
#Get the items on the list and their prices:
xpathSApply(rootNode, "//name", xmlValue)
xpathSApply(rootNode, "//price", xmlValue)
#
# TO BE CONTINUED --------->