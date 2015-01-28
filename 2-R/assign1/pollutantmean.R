pollutantmean <- function(directory, pollutant, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'pollutant' is a character vector of length 1 indicating
    ## the name of the pollutant for which we will calculate the
    ## mean; either "sulfate" or "nitrate".
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return the mean of the pollutant across all monitors list
    ## in the 'id' vector (ignoring NA values)
    
    # read in files
    files_list <- list.files(directory, full.names=TRUE)
    csvfiles = lapply(files_list[id], read.csv)
    
    # merge data
    data = do.call(rbind, csvfiles)
    mean(data[[pollutant]], na.rm=T)
}



library(testthat)
ERROR = 0.001
test_that('part1 is correct', {
    expect_less_than(pollutantmean("data/specdata", "sulfate", 1:10) - 4.064, ERROR)
    expect_less_than(pollutantmean("data/specdata", "nitrate", 70:72) - 1.706, ERROR)
    expect_less_than(pollutantmean("data/specdata", "nitrate", 23) - 1.281, ERROR)
    
})
