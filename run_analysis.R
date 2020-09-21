setwd("C:/Users/Jrronal Ramos/Desktop/DESKTOP FILES/Proyecto Getting and cleaning data/UCI HAR Dataset")

#### Merge training and test sets to create one data set #####

library(dplyr)

features        <- read.table("./features.txt",header=FALSE)
activity_labels   <- read.table("./activity_labels.txt",header=FALSE)

subject_train    <-read.table("./train/subject_train.txt", header=FALSE, col.names = "Subject")
x_train          <- read.table("./train/X_train.txt", header=FALSE, col.names = features[, 2])
y_train          <- read.table("./train/y_train.txt", header=FALSE, col.names = "Activity")

##### Use descriptive activities names for activity measurements ###########

y_train   <- merge(y_train, activity_labels, by.x = "Activity" , by.y = "V1", all.x = TRUE)
y_train   <- rename(y_train, activity_name = V2)

subject_test   <- read.table("./test/subject_test.txt", header=FALSE, col.names = "Subject")
x_test   <- read.table("./test/x_test.txt", header=FALSE, col.names = features[, 2])
y_test   <- read.table("./test/y_test.txt", header=FALSE, col.names = "Activity")

##### Use descriptive activities names for activity measurements ###########

y_test   <- merge(y_test, activity_labels, by.x = "Activity" , by.y = "V1", all.x = TRUE)
y_test   <- rename(y_test, activity_name = V2)

test_data <- cbind(subject_test, y_test,  x_test)
train_data <- cbind(subject_train, y_train, x_train)

data_set <- rbind(test_data, train_data)

#####  Extract only measurements on mean and standard deviation  #####

names_variables <- colnames(data_set)

filtered_names <- grep("Subject|activity_name|[Mm]ean|std", names_variables, value = FALSE)

filtered_dataset <- data_set[, filtered_names]


################### Appropriately Label the Dataset with Descriptive Variable Names ##########

change_names <- names_variables[filtered_names]    
change_names <- gsub("mean", "Mean", change_names)
change_names <- gsub("std", "Std", change_names)
change_names<- gsub("gravity", "Gravity", change_names)
change_names <- gsub("[[:punct:]]", "", change_names)
change_names <- gsub("^t", "time", change_names)
change_names <- gsub("^f", "frequency", change_names)
change_names<- gsub("^anglet", "angleTime", change_names)
names(filtered_dataset) <- change_names   

###########3 Create tidy data set with average of each variable, by activity, by subject #########

tidy_data <- data_set %>%
        group_by(Subject, Activity, activity_name) %>%
        summarise_all(.funs = mean)



write.table("mean_resume.txt", row.name=FALSE)
