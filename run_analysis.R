library(dplyr)

############ reading all the files contained in the folder ################################

features        <- read.table("./features.txt",header=FALSE)
activity_labels   <- read.table("./activity_labels.txt",header=FALSE)

subject_train    <-read.table("./train/subject_train.txt", header=FALSE, col.names = "Subject")
x_train          <- read.table("./train/X_train.txt", header=FALSE, col.names = features[, 2])
y_train          <- read.table("./train/y_train.txt", header=FALSE, col.names = "Activity")
y_train   <- merge(y_train, activity_labels, by.x = "Activity" , by.y = "V1", all.x = TRUE)
y_train   <- rename(y_train, activity_name = V2)

subject_test   <- read.table("./test/subject_test.txt", header=FALSE, col.names = "Subject")
x_test   <- read.table("./test/x_test.txt", header=FALSE, col.names = features[, 2])
y_test   <- read.table("./test/y_test.txt", header=FALSE, col.names = "Activity")
y_test   <- merge(y_test, activity_labels, by.x = "Activity" , by.y = "V1", all.x = TRUE)
y_test   <- rename(y_test, activity_name = V2)


##################### Joining the data #####################3

test_data <- cbind(subject_test, y_test,  x_test)
train_data <- cbind(subject_train, y_train, x_train)

data_set <- rbind(test_data, train_data)


################ independet data set with the average of the data ##################


tidy_data <- data_set %>%
        group_by(Subject, Activity, activity_name) %>%
        summarise_all(.funs = mean)

write.table("mean_resume.txt", row.name=FALSE)
