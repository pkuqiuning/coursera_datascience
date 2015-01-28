dataset_url = 'http://d396qusza40orc.cloudfront.net/rprog%2Fdata%2FProgAssignment3-data.zip'
DATAFILE = 'FProgAssignment3-data.zip'
DATA_ROOT_DIR = "."

# download data
if (!file.exists(DATAFILE)){
    download.file(dataset_url, DATAFILE)
    unzip(DATAFILE, exdir = DATA_ROOT_DIR)
}

# plot histogram of outcome
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[, 11])

