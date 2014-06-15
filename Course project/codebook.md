#DataCleaning#


##Data Cleaning Course Project - Code Book##

###Line 1 sets the working directory###
fileurl is a variable that specifies the url from which the data are to be downloaded

The url is specified as http instead of https to avoid download errors

The downloaded file is saved to the working directory


###The unzip function unzips the data###


Lines 14-16 load the required libraries


###The data required for the project are read into R using read.table###

features data frame contains two columns v1 which is a vector of numbers and v2 which is the names of variables


X_test is a data frame which contains 561 variables 2947 observations of data from the test 
group
names is a factor vector which contains the v2 column of the features data frame

test is a character variable containing the word "test"

testnames is a character variable where the word test is prefixed to the variable names
X_test data.frame columns are named using the testnames vector


X_train is a data frame which contains 561 variables 7352 observations of data from the test group

train is a character variable containing the word "train"

trainnames is a character variable where the word train is prefixed to the variable names
X_train data.frame 
columns are named using the testnames vector


Y_train is a data frame with a single column with 7352 rows

Y_test is a data frame with a single column with 7352 rows


subject_train is a data frame with one column and 7352 rows

subject_test is a data frame with one column and 2947 rows


The columns of the data frames Y_train, Y_test, subject_train, subject_test were labelled ytrain, ytest, subjecttrain, subjecttest respectively


###Lookup Table###

The data table Y_test had numeric values with lookup values contained in a separate file activity_labels.txt

activitylabel is a data frame with one column and six rows

Data frames activitylabelte and activitylabeltr were set to equal activitylabel

The names function was used on activitylabelte and activitylabeltr to result in a data table with two columns with six variable each. Each value of the ytrain variable matched a value in the activity label


The vectors subjecttest,subjecttrain and ytrain were set as factors

###Binding the data###


The function cbind was used to bind the columns from subject_test,x_test and y_test into testdf and subject_train, x_train and y_train were bound into traindf. testdf had 563 columns and 2947 rows, whilst traindf had 563 columns and 7352 rows


A partially successful attempt was made to merge two data frames with different numbers of rows. 
I was not completely successful at this

As this was partially successful new datasets traindf1 and testdf1 which were identical to traindf and testdf were used

The column names of subjecttest and subjecttrain were changed to subject in each table using the names function

The column subject in traindf1 and testdf1 were set as indices using row.names


The data frame total should have 2947 + 7352 rows ie 10,299 rows; however it has 2947 rows instead thus this was not successful despite multiple attempts

###Change in merge strategy###



At this point of time it was felt best to use separate data frames, pick the columns needed and merge them after meling the data sets


Two datasets meantestd and meantraind were created wherein 80 colums each were selected with variables whose names indicated that the data included mean and standard deviation data. 
meantestd has 2947 rows and meantraind has 7352


Datasets meantestfd and meantrainfd had the previously created activitylabelte and activitylabeltr datasets merged into the meantestdf and meantraindf data frames. 
####Dropping variables####
At this point in time a new character variable drops was created which contained "ytest" and "ytrain". 
In subsequent datasets meantestdfd and meantraindfd the "ytest" and "ytrain" were dropped leaving the label names intact.

Data frame meantestdfd has 80 columns and 2947 rows whilst meantraindfd has 80 columns and 7352 rows

An understanding of how to melt the dataframes was achieved by reading 
http://martinsbioblogg.wordpress.com/2014/03/25/using-r-quickly-calculating-summary-statistics-from-a-data-frame/

Data frame meanst has 4 columns and 229866 rows whilst meanstr has 4 columns and 573456 rows
These columns are subject, activity, variable and value.

The names subjecttest and subjecttrain were renamed at this time to subject

Means and standard deviation were calculated using the ddply function
The data were subgrouped by subject and then activity and mean and sd were calculated for each group individually
The data frame meanstest has 5 columns and 4212 rows whilst meanstrain has 5 columns and 9828 rows

These columns in meanstest include object, activity, variable, mean and sd
The data frame meanstrain has the same columns
###Creating the final data set###



Data frame final was created using rbind to bind meanstest and meanstrain. 
It has 5 variable and 14040 rows


Finally write.table was used to create a tab separated tidy.txt file
