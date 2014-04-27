library(plyr)
run_analysis <- function() {
    srcFeatures <- read.table("features.txt")
    features <-srcFeatures[[2]]
    isMeanFeature <- sapply(features, function(s) { length(grep("mean\\(\\)",s)) >0})
    isStdFeature <- sapply(features, function(s) { length(grep("std\\(\\)",s)) >0})
    isMeanOrStdFeature <- isMeanFeature | isStdFeature
    srcActivityLabels <- read.table("activity_labels.txt")
    activityLables <- srcActivityLabels[[2]]
    srcTestData <- rbind(read.table("test/X_test.txt", colClasses="numeric"), 
                         read.table("train/X_train.txt", colClasses="numeric"))
    srcTestActivities <-rbind(read.table("test/y_test.txt"), read.table("train/y_train.txt"))
    activities <- lapply(srcTestActivities, function (i) {activityLables[i]})
    tidyData <- cbind(activities, srcTestData[isMeanOrStdFeature])
    colnames(tidyData) <- c("Activity", as.character(features[isMeanOrStdFeature]))
    #save the first tidy dataset
    write.table(tidyData,"tidySet1.txt")
    srcSubjects <- rbind(read.table("test/subject_test.txt", col.names="Subject"), read.table("train/subject_train.txt", col.names="Subject"))
    tidyDataWithSubject <- cbind(srcSubjects, tidyData)
    tidyData2 <- aggregate(. ~ Activity + Subject, data= tidyDataWithSubject, mean)
    tidyData2 <- arrange(tidyData2, Activity, Subject)
    # save the second tidy dataset
    write.table(tidyData2,"tidySet2.txt")
}