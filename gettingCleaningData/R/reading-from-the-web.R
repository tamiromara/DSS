#----------------------------
# Author: Tamir Omara
# Title: Reading from the Web
# Week: 02
# Class: 12
#----------------------------

#Open connection to the URL:
con <- url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hI=en")    #https not supported. Lookup!

#Read out the data from that connection:
htmlCode <- readLines(con)    #Lines with an s and capital L, not line.

#HTML code is stored in htmlCode, now close our established connection
close(con)

#When viewing htmlCode it'll be very difficult to read it.
#One method to deal with this is to parse the html document with XML.
library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hI=en"
html.1 <- htmlTreeParse(url, useInternalNodes = TRUE)    #useInternalNodes, will give us the complete structure out.

#Extracting the page's title:
xpathSApply(html.1, "//title", xmlValue)

#Extracting where the citation appeard:
citedAt <- xpathSApply(html.1, "//div[@class='gsc_a_at']", xmlValue)

#Extracting who cited:
citedBy <- xpathSApply(html.1, "//div[@class='gs_gray']", xmlValue)

#Extracting the citation count:
citedCount <- xpathSApply(html.1, "//a[@class='gsc_a_ac']", xmlValue) 


#Another approach is to use GET command of httr package
#Accessing open webiste can be easier using the connection method, as mentioned above.
#GET is better suited 
library(httr)
#Read HTML code from the URL
html.2 <- GET(url)

#Extract the content from html as a long string:
content.2 <- content(html.2, as = "text")

#Parse text into html (same output as the XML package function htmlTreeParse):
htmlParsed <- htmlParse(content.2, asText = TRUE)

#Finally, use xpathSApply to extract the info:
xpathSApply(htmlParsed, "//title", xmlValue)

#Accessing password protected websites, using GET:
protectedPage <- GET("http://httpbin.org/basic-auth/user/passwd", authenticate(user = "user", password = "passwd"))
protectedPage
names(protectedPage)
