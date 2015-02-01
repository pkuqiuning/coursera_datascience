dateURL = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
dataFILE = 'getdata_projectfiles_UCI HAR Dataset.zip'
dataDIR = 'UCI HAR Dataset'
if (!file.exists(dataDIR)){
    if (!file.exists(dataFILE)){
        download.file(dataURL, dataFILE, 'curl')
    }
    unzip(dataFILE, exdir='.')
}
