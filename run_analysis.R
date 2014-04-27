srcFeatures <- read.table("features.txt")
features <-srcFeatures[[2]]
isMeanFeature <- sapply(features, function(s) { length(grep("mean\\(\\)",s)) >0})
isStdFeature <- sapply(features, function(s) { length(grep("std\\(\\)",s)) >0})
isMeanOrStdFeature <- isMeanFeature | isStdFeature
srcActivityLabels <- read.table("activity_labels.txt")
activityLables <- srcActivityLabels[[2]]
#srcTestData <- read.table("test/X_test.txt")
#srcTestActivities <-read.table("test/y_test.txt")
activities <- lapply(srcTestActivities, function (i) {activityLables[i]})
tidyData <- cbind(activities, srcTestData[isMeanOrStdFeature])
colnames(tidyData) <- c("Activity", as.character(features[isMeanOrStdFeature]))
