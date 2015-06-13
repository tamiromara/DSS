#----------------------------
# Title: Reading from the Web
# Author: Tamir Omara
# Week: 02
# Class: 13
#----------------------------

library(httr) #PUSH FIX: http://goo.gl/LXyaGQ
library(jsonlite)

#oauth, will start the authorization process for our application:
myapp <- oauth_app(appname = "twitter", 
                   key = "YourConsumerKey", 
                   secret = "YourConsumerSecret")

#Sign in using the myapp above: #PUSH FIX
sigAuth <- sign_oauth1.0(app = myapp, 
                    token = "YourAccessToken",
                    token_secret = "YourAccessTokenSecret")

#Get my Home time line tweets in a jSon format:
homeTL <- GET("https://api.twitter.com/1.1/statuses/user_timeline.json", sigAuth)

#Converting the Json object:
jsonData <- content(homeTL) #this will return a structured R object, which is hard to read.
#Instead, we can use the jasonlite package to reformat it as a Data Frame:
jsonDF <- jsonlite::fromJSON(toJSON(jsonData))

