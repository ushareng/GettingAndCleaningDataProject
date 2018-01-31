## Install and load reshape2 and dplyr packages.
install.packages("reshape2")
install.packages("dplyr")
library(reshape2)
library(dplyr)
## Download the file from the url and unzip in the local folder
path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url , file.path(path, "dataFile.zip"))
  unzip(zipfile = "dataFile.zip")
  
### 1.Merges the training and the test sets to create one data set.
train <- read.table("UCI HAR Dataset/train/X_train.txt")
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
test <- read.table("UCI HAR Dataset/test/X_test.txt")
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
data <- rbind(train , test)
activities <- rbind(trainActivities , testActivities )
subject <- rbind(trainSubjects , testSubjects)
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")
names(data) <- features[,2]
names(activities ) <- "activityId"
names(subject) <- "subjectId"
MergeData <- cbind(subject, activities , data)

###  2. Extracts only the measurements on the mean and standard deviation for each 
##measurement.
colNames <- names(MergeData)[grep("subjectId|activityId|mean..$|std..$",names(MergeData))]
MergeData <- MergeData [colNames]

### 3.Uses descriptive activity names to name the activities in the data set
names(activityLabels) <- c("activityId", "activityName")
MergeData <- merge(MergeData ,activityLabels ,"activityId")

### 4.Appropriately labels the data set with descriptive variable names.
MergeData$activityId <- MergeData$activityName
MergeData <- select(MergeData , -activityName)
MergeData <- rename(MergeData , activityName = activityId)
colNames <- names(MergeData )
ManipulateColNames <- function(x) {
  x <- gsub('^(t)', 'time', x)
  x <- gsub('^(f)', 'freq', x)
  x <- gsub('-mean\\()$', 'Mean', x)
  x <- gsub('-std\\()$', 'StdDev', x)
  x <- gsub('BodyBody', 'Body', x)
  x <- gsub('Mag', 'Magnitude', x)
}
names(MergeData) <- sapply(colNames , ManipulateColNames)

### From the data set in step 4, creates a second, independent tidy data set with the average 
##of each variable for each activity and each subject.
TidyData <- MergeData %>%
group_by(activityName, subjectId) %>%
summarise_all(funs(mean(., na.rm=TRUE))) %>% 
arrange(subjectId) 
write.table(TidyData, "tidy.txt", row.names = FALSE, quote = FALSE)
