DataCleaning
============

Data Cleaning Course Project Readme File
Line 1 sets the working directory
fileurl is a variable that specifies the url from which the data are to be downloaded
The url is specified as http instead of https to avoid download errors
The downloaded file is saved to the working directory
The unzip function unzips the data

Lines 14-16 load the required libraries

The data required for the project are read into R using read.table
features data frame contains two columns v1 which is a vector of numbers and v2 which is the names of variables

X_test is a data frame which contains 561 variables 2947 observations of data from the test group
names is a factor vector which contains the v2 column of the features data frame
test is a character variable containing the word "test"


