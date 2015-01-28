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
library(testthat)
ERROR = 0.001

source('pollutantmean.R')
test_that('part1 is correct', {
    expect_less_than(pollutantmean("data/specdata", "sulfate", 1:10) - 4.064, ERROR)
    expect_less_than(pollutantmean("data/specdata", "nitrate", 70:72) - 1.706, ERROR)
    expect_less_than(pollutantmean("data/specdata", "nitrate", 23) - 1.281, ERROR)
    
})

source('complete.R')
test_that('part2 is correct', {
    expect_equal(
        complete("data/specdata", 1),
        data.frame(id=1, nobs=117)
        )

    expect_equal(
        complete("data/specdata", c(2, 4, 8, 10, 12)),
        data.frame(id=c(2, 4, 8, 10, 12), nobs=c(1041, 474, 192, 148, 96))
        )

    expect_equal(
        complete("data/specdata", 30:25),  
        data.frame(id=c(30, 29, 28, 27, 26, 25), nobs=c(932, 711, 475, 338, 586, 463))
    )

    expect_equal(
        complete("data/specdata", 3),
        data.frame(id=3, nobs=243)
    )
})

