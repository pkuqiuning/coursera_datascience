# Code Book
# TODO

run_analysis.R is a R script that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Strategy to solve problem

## Problem
Given UCI HAR Dataset, we are going to extract and clean the data, prepare the code book.

## Objectives
  - Produce the resulting data sets
  - Produce the code book

## Strategy
Read in data, follow instructions step by step, write results back.

## Steps to produce the data sets
  1. Read data sets
  2. Merge training set and test set
  3. Extract and clean resulting data set
  4. Write results to disk

