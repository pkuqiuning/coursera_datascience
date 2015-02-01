dataDIR = 'UCI HAR Dataset'
if (!file.exists(dataDIR)){
    stop('run get_data.R first to get raw data')
}
