# Step 1: Merges the training and the test sets to create one data set.

## Importing training and testing related datasets
train_data <-
  read.table("./UCI HAR Dataset/train/X_train.txt",
             quote = "\"",
             comment.char = "")
train_label <-
  read.table("./UCI HAR Dataset/train/y_train.txt",
             quote = "\"",
             comment.char = "")
train_subject <-
  read.table(
    "./UCI HAR Dataset/train/subject_train.txt",
    quote = "\"",
    comment.char = ""
  )

test_data  <-
  read.table("./UCI HAR Dataset/test/X_test.txt",
             quote = "\"",
             comment.char = "")
test_label <-
  read.table("./UCI HAR Dataset/test/y_test.txt",
             quote = "\"",
             comment.char = "")
test_subject <-
  read.table(
    "./UCI HAR Dataset/test/subject_test.txt",
    quote = "\"",
    comment.char = ""
  )

## merging the training and testsing: data, label, subject name
merged_data <- rbind(train_data, test_data)
merged_label <- rbind(train_label, test_label)
merged_subject <- rbind(train_subject, test_subject)

# Step 2: Extracts only the measurements on the mean and standard deviation for
# each measurement

features <-
  read.table("./UCI HAR Dataset/features.txt",
             quote = "\"",
             comment.char = "")


mean_Std_variables <-
  grep("mean\\(\\)|std\\(\\)", features[, 2]) # Locating "mean" and "std" indices
merged_data <-
  merged_data[, mean_Std_variables] # selecting only the mean and std measurements


names(merged_data) <-
  gsub("\\(\\)", "", features[mean_Std_variables, 2]) # remove "()"
names(merged_data) <-
  gsub("mean", "Mean", names(merged_data)) # capitalize M
names(merged_data) <-
  gsub("std", "Std", names(merged_data)) # capitalize S
names(merged_data) <-
  gsub("-", "", names(merged_data)) #remove "-"in col names

# Step 3: Uses descriptive activity names to name the activities in
# the data set

activity_labels <-
  read.table("./UCI HAR Dataset/activity_labels.txt",
             quote = "\"",
             comment.char = "")

activity_labels[, 2] <-
  tolower(gsub("_", "", activity_labels[, 2])) # Remove "-" and apply loweer case

substr(activity_labels[2, 2], 8, 8) <-
  toupper(substr(activity_labels[2, 2], 8, 8)) # Capitalising the "U" in [2,2]
substr(activity_labels[3, 2], 8, 8) <-
  toupper(substr(activity_labels[3, 2], 8, 8)) # Capitalising the "D" in [3,2]
descriptive_act_labels <- activity_labels[merged_label[, 1], 2]
merged_label[, 1] <-
  descriptive_act_labels # assigning activities names to their respective labels
names(merged_label) <- "Activity"


# Step 4: Appropriately labels the data set with descriptive activity
# names

names(merged_subject) <- "Subject"
output_data <-
  cbind(merged_subject, merged_label, merged_data) # Putting them all in one date set
write.table(output_data, "cleaned_data.txt") # write out the 1st dataset


#Step 5: Creates a second, independent tidy data set with the average of each
# variable for each activity and each subject

tidy_data <-
  aggregate(
    output_data,
    by = list(Activity = output_data$Activity, Subject = output_data$Subject),
    mean
  )# Aggregate the data according to their activity, subject and then finds the mean


tidy_data[, 4] = NULL # Removes a duplicate Subject col
tidy_data[, 3] = NULL # Removes a duplicate Activity col

write.table(tidy_data, "cleaned_data_means.txt") # write out the 2nd dataset
