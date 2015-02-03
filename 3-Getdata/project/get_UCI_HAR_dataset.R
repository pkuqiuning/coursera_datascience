#!/usr/bin/env Rscript
#=============================================================================
#
#          FILE: get_UCI_HAR_dataset.R
#
#   DESCRIPTION: Extract and clean training and test data from UCI HAR Dataset
#
#        AUTHOR: fantasy <pkuqiuning@gmail.com>
#       CREATED: 2015-02-01 20:17:15 -0500
#       VERSION: 0.0
#
#=============================================================================


dataURL = 'http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
dataFILE = 'UCI HAR Dataset.zip'
dataDIR = 'UCI HAR Dataset'
if (!file.exists(dataDIR)){
    if (!file.exists(dataFILE)){
	print(paste('downloading zip file', dataFILE))
        download.file(dataURL, dataFILE)
    }
    print(paste('unzip data to', dataDIR))
    unzip(dataFILE, exdir='.')
} else{
    print(paste('data directory already exsist, do nothing', dataDIR))
}
