#----------------------------
# Author : Tamir Omara
# Title : Creting new variables
# Week : 03
# Class : 
#----------------------------

restData <- read.csv(file = "./gettingCleaningData/data/resturants.csv")

# Sequencing is used to index different operations that we're going to be doing on data :
sq1 <- seq(1, 10, by = 2)         # Seq from 1 - 10 by increment of 2
sq2 <- seq(1, 10, length = 3)     # starts at 1, ends at 10. creates exactly 3 values
x   <- c(12, 33, 53, 22, 14, 19) 
sq3 <- seq(along = x)             # Seq along the length of x

# Creating a variable which indicates which subset another variable comes from :
restData$nearMe <- restData$neighborhood %in% c("Roland Park", "Homeland")   # new variable as logical vector
table(restData$nearMe)    # Subsetting 

# Creating binary variables :
restData$zipWrong <- ifelse(restData$zipCode < 0, TRUE, FALSE)  # creats a logical vector
table(restData$zipWrong)  # Subsetting. 
table(restData$zipWrong, restData$zipCode < 0)

# Creating categorical variable out of quantitative varible
# apply cut to quantitative variable, zipCode, and break it up according to the quantiles of zipCode :
restData$zipGroups <- cut(restData$zipCode, breaks = quantile(restData$zipCode))  # zipGroups is a factor variable
table(restData$zipGroups)
table(restData$zipGroups, restData$zipCode)

# Creating Factor variables :
restData$zcf <- factor(restData$zipCode)
class(restData$zcf)

# modifying levels of a factor :
yesNo <- sample(c("yes", "no"), size = 10, replace = TRUE)
yesNoFac <- factor(yesNo, levels = c("yes", "no")) 
yesNo
yesNoFac
relevel(yesNoFac, ref = "yes")
as.numeric(yesNoFac)

#hmisc package

