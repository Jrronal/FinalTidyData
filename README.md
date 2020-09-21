# FinalTidyData
Tidy Data from Human Activity Recognition Using Smartphones
Variables to read every file in the folder of the data:
features 
activity_labels
subject_test
x_test 
y_test 
subject_train 
x_train 
y_train 
filtered_dataset

Variables to joining the information of X and Y with the subject test and subject train, to get one file 
test_data = subject_test, y_test and x_test
train_data = subject_train, y_train and x_train
data_set = test_data and train_data

filtered_dataset = the data filtered by mean and standard deviation

Getting the final data with the average of the data, a resume, a separated table. 

tidy_data = it is the final table with the information needed, grouped and summarized

1. It has the code to upload the information into R with the files stored in the local link
2. It proceeds to merged the data together with the tables x_text, y_test, subject_test, x_train, y_train, subject_train.
3. It creates a new object or table with the mean and standard deviation of the data, it filters all the columns with the function grep
4. renames the columns with apropiated names for each variables
5. it creates a different table with the information summarized by the meaning of every variable, creating a new file called "resume_mean.txt"
