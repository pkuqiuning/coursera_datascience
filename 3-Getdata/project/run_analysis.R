#!/usr/bin/env Rscript
#=============================================================================
#
#          FILE: run_analysis.R
#
#   DESCRIPTION: Extract and clean training and test data from UCI HAR Dataset
#
#        AUTHOR: fantasy <pkuqiuning@gmail.com>
#       CREATED: 2015-02-01 20:17:15 -0500
#       VERSION: 0.0
#
#=============================================================================


# 1. Read data sets

## Verify data set is available 
dataDIR = 'UCI HAR Dataset'
if (!file.exists(dataDIR)){
	stop('run get_data.R first to get raw data')
}
setwd(dataDIR)


## READ training set and test set
read_dataset = function(surffix) {
	# change to subdir test
	setwd(surffix)
	# read 'test/X_test.txt' 'test/y_test.txt' 'test/subject_test.txt'
	X = read.table(paste0('X_', surffix, '.txt'))
	y = read.table(paste0('y_', surffix, '.txt'), col.names = 'activity')
	subject = read.table(
			paste0('subject_', surffix, '.txt'), 
			col.names = 'subject', 
			)
	# combine all tables
	setwd('..')
	cbind(X, y, subject)
}
training_set = read_dataset('train')
test_set = read_dataset('test')


# 2. Merge training set and test set
# table1 <- UNIT training set and test set
table1 = rbind(training_set, test_set)


# 3. Extract and clean resulting data set
# table1 <- SELECT measurements FROM table1 WHERE measurement field name CONTAINS mean or std
features = read.table('features.txt')[[2]]
needed_feature_numbers = grep('(mean|std)\\(\\)', features)
table1 = table1[c(needed_feature_numbers, c(562, 563))]

# * Uses descriptive activity names to name the activities in the data set
# table1 <- SELECT TRANSLATE activity FROM table1, USING translate table 
label_activities = read.table('activity_labels.txt')[[2]]
table1$activity  = as.factor(label_activities[table1$activity])

# * Appropriately labels the data set with descriptive variable names. 
# ALTER table1 RENAME columns
column_names = as.character(features[needed_feature_numbers])
patterns = c('Acc', 'Gyro', 'Mag', '-mean\\(\\)', '-std\\(\\)', '\\-')
replacements = c('Accelerometer', 'Gyroscope', 'Magnitude', 'Mean', 'STD', '_')
for (i in 1:length(patterns)){
	column_names = gsub(patterns[i], replacements[i], column_names)
}
colnames(table1)[1:(ncol(table1)-2)] <- column_names

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# table2 <- SELECT average(measurements) FROM table1 GROUP BY activity, subject
table2 <- aggregate(. ~ activity + subject, data=table1, FUN=mean)


# 4. Write results to disk
# Write table1 and table2 to disk
setwd('..')
write.table(table1, 'table1.csv')
write.table(table2, 'table2.csv')