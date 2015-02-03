# README
 - README.md - this file
 - get_UCI_HAR_dataset.R - run this script to get UCI HAR Dataset
 - run_analysis.R - run this script to process original data set
 - CodeBook.md - description of the variables of the resulting data set

## USAGE
- Run source('get_UCI_HAR_dataset.R') in R. It will download and unzip the [UCI HAR Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) ([download here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)) to a folder named "UCI HAR Dataset".
- Run the analysis with source('run_analysis.R').
- The processed data will be write to file "result_dataset.txt"
- It can be loaded into R with command read.table('result_dataset.txt')
