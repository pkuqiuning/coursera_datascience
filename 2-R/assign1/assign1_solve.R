DATAFILE = "data/specdata.zip"
DATA_ROOT_DIR = "data"
DATADIR = paste(DATA_ROOT_DIR, 'specdata', sep='/')

# load data
if (!file.exists(DATAFILE)){
    dataset_url <- "http://d396qusza40orc.cloudfront.net/rprog%2Fdata%2Fspecdata.zip"
    download.file(dataset_url, DATAFILE)
    unzip(DATAFILE, exdir = DATA_ROOT_DIR)
}

# 332 csv files
stopifnot(length(list.files(DATADIR))==332)

