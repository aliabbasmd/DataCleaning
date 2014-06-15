#download data file
fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,"uhcdata.zip")

#capture the date on which the file is downloaded
dateDownloaded<-date()

#unzip the file
unzip("uhcdata.zip")

#load the required libraries
library(plyr)
library(reshape)
library(reshape2)
#read in the required data files for test group
features<- read.table("c://data/UCI HAR Dataset/features.txt")
X_test<-read.table("c://data/UCI HAR Dataset/test/X_test.txt")

#name the test file column headers with the word test
names<-features[,2]
test<-"test"
testnames<-paste(test,names,sep="")
names(X_test)<-testnames

#read in the train data and name column headers with the name train in them
X_train<-read.table("c://data/UCI HAR Dataset/train/X_train.txt")
train<-"train"
trainnames<-paste(train,names,sep="")
names(X_train)<-trainnames

Y_train<-read.table("c://data/UCI HAR Dataset/train/Y_train.txt")
Y_test<-read.table("c://data/UCI HAR Dataset/test/Y_test.txt")
subject_train<-read.table("c://data/UCI HAR Dataset/train/subject_train.txt")
subject_test<-read.table("c://data/UCI HAR Dataset/test/subject_test.txt")
names(Y_train)<-"ytrain"
names(Y_test)<-"ytest"
names(subject_train)<-"subjecttrain"
names(subject_test)<-"subjecttest"

# to add labels http://nicercode.github.io/blog/2013-07-09-modifying-data-with-lookup-tables/
activitylabel<-read.table("c://data/UCI HAR Dataset/activity_labels.txt")
activitylabelte<-activitylabel
names(activitylabelte)<-c("ytest","activity")
activitylabeltr<-activitylabel
names(activitylabeltr)<-c("ytrain","activity")

#defining the factors
subjecttest<-as.factor("subjecttest")
subjecttrain<-as.factor("subjecttrain")
ytrain<-as.factor("ytrain")


#create two separate data frames for the test and train groups
testdf<-cbind(subject_test,X_test,Y_test)
traindf<-cbind(subject_train,X_train,Y_train)


#Create two separate data frames for the test ant train groups and then merge them using merge
names(testdf1)[names(testdf1) == 'subjecttest'] <- 'subject'
names(traindf1)[names(traindf1) == 'subjecttrain'] <- 'subject'
traindf1$subject <- row.names(traindf1)
testdf1$subject <- row.names(testdf1)

total <- merge(testdf1, traindf1, by = intersect(names(testdf1), names(traindf1)))

#as there were errors in the merge no matter what method I tried, I decided to merge the data at the end
#select the columns from the data frames that have mean or standard deviation in them

meantestd<-testdf[,c(563,562,1,2,3,4,5,6,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,164,165,166,201,202,214,215,227,228,240,241,253,254,266,267,268,269,270,271,294,295,296,345,346,347,348,349,350,373,374,375,424,425,426,427,428,429,452,453,503,504,513,516,517,529,530,539,557,558,559,560,561)]
meantraind<-traindf[,c(563,562,1,2,3,4,5,6,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,164,165,166,201,202,214,215,227,228,240,241,253,254,266,267,268,269,270,271,294,295,296,345,346,347,348,349,350,373,374,375,424,425,426,427,428,429,452,453,503,504,513,516,517,529,530,539,557,558,559,560,561)]

#Placing the activity label in the data set
meantestdf<-merge(meantestd,activitylabelte,by="ytest",all=TRUE)
meantraindf<-merge(meantraind,activitylabeltr,by="ytrain",all=TRUE)

#drop the ytest variable as labels have been imported from look up table
drops<-c("ytest","ytrain")
meantestdfd<-meantestdf[,!(names(meantestdf) %in% drops)]
meantraindfd<-meantraindf[,!(names(meantraindf) %in% drops)]

#melt the data frames
#http://martinsbioblogg.wordpress.com/2014/03/25/using-r-quickly-calculating-summary-statistics-from-a-data-frame/

meanst<-melt(meantestdfd,id.vars=c("subjecttest","activity"))
meanstr<-melt(meantraindfd,id.vars=c("subjecttrain","activity"))

#Rename the subject column
names(meanst)[names(meanst) == 'subjecttest'] <- 'subject'
names(meanstr)[names(meanstr) == 'subjecttrain'] <- 'subject'

#calculate the means and standard deviations
meanstest<-ddply(meanst,c("subject","activity","variable"),summarize, mean=mean(value),sd=sd(value))
meanstrain<-ddply(meanstr,c("subject","activity","variable"),summarize, mean=mean(value),sd=sd(value))

#the combined data file with neat data (this is where I merge the data)
final<-rbind(meanstest,meanstrain)

#output the data as a .csv file
write.table(final, "c://data/tidy.txt", sep="/t")
