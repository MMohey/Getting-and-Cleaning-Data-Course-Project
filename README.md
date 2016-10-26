# Getting-and-Cleaning-Data-Course-Project
The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set.

# The "run_analysis.R" script works as follows:
•	First, unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and make sure the folder name stays “UCI HAR Dataset”.
•	Make sure the folder "UCI HAR Dataset" and the run_analysis.R script are both in the current working directory.
•	Second, use source("run_analysis.R") command in RStudio.
•	Third, you will find two output files are generated in the current working directory:
o	"cleaned_data.txt" (8.3 Mb): it contains a data frame called output_data with 10299*68 dimension.
o	"cleaned_data_means.txt" (225 Kb): it contains a data frame called tidy_data with 180*68 dimension.
•	Finally, use data <- read.table("cleaned_data_means.txt") command in RStudio to read the file. Since we are required to get the average of each variable for each activity and each subject, and there are 6 activities in total and 30 subjects in total, we have 180 rows with all combinations for each of the 66 features.

