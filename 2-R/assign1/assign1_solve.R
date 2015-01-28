DATAFILE = "data/specdata.zip"
DATA_ROOT_DIR = "data"
DATADIR = paste(DATA_ROOT_DIR, 'specdata', sep='/')

# download data
if (!file.exists(DATAFILE)){
    dataset_url <- "http://d396qusza40orc.cloudfront.net/rprog%2Fdata%2Fspecdata.zip"
    download.file(dataset_url, DATAFILE)
    unzip(DATAFILE, exdir = DATA_ROOT_DIR)
}

# 332 csv files
stopifnot(length(list.files(DATADIR))==332)

# unit tests
source('pollutantmean.R')
library(testthat)
ERROR = 0.001
test_that('part1 is correct', {
    expect_less_than(pollutantmean("data/specdata", "sulfate", 1:10) - 4.064, ERROR)
    expect_less_than(pollutantmean("data/specdata", "nitrate", 70:72) - 1.706, ERROR)
    expect_less_than(pollutantmean("data/specdata", "nitrate", 23) - 1.281, ERROR)
    
})