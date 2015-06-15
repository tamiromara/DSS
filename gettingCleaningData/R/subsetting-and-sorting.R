#----------------------------
# Author: Tamir Omara
# Title: Subsetting and Sorting
# Week: 03
# Class: 
#----------------------------

# Quick Review :
# Create Data Frame :
x <- data.frame("var1" = sample(1:5), 
                "var2" = sample(6:10), 
                "var3" = sample(11:15))

x <- x[sample(1:5), ]     # Scramble the columns.
x$var2[c(1,3)] <- NA     # Make some of the variables NA.

x[, 1]          # Selecting first column
x[, "var1"]     # Subsetting using variable name.
x[1:2, "var2"]  # Select the first and second rows from the
                # variable name "var2"

x[x$var1 <= 3 & x$var3 > 11, ]  # All the rows of x, where var1 <= 3
                                # AND var3 > 11
x[x$var1 <= 3 | x$var3 > 15, ]  # All the rows of x, where var1 <= 3
                                # OR var3 >15

# NOTE : 
x[x$var2 > 8, ]   # Subsetting on NAs will not produce the rows
x[x$var2 > 8, ]   # which will return the indicies where the statement applies,
                  # and don't return the NAs

sort(x$var1)                    # Sort in increasing order
sort(x$var1, decreasing = TRUE) # Sort in descreasing order
sort(x$var2, na.last = TRUE)    # place NAs at the end

x[order(x$var1), ]          # Ordering DF by a particular variable
x[order(x$var1, x$var3), ]  # Ordering DF by multiple variables:
                            # - Will first sort var1 in increasing order
                            # - if multiple variables are the same, var3 is used to sort.

# Using plyr package :
library(plyr)


arrange(df = x, var1)         # Arrange dataFrame x using variable var1
                              # similar to order
arrange(df = x, desc(var1))   # Arrange in descending order.

x$var4 <- rnorm(5)              # Adding var4 as a column
x <- cbind(x, var5 = rnorm(5))  # Another way.
                                # To bind the variable on left: cbind(rnorm(5),x)
x <- rbind(x, rnorm(5))         # Binds a row at the end of DF
