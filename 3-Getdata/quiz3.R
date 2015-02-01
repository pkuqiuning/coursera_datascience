#!/usr/bin/env Rscript
#=============================================================================
#
#          FILE: quiz3.R
#
#   DESCRIPTION: 
#
#        AUTHOR: fantasy <pkuqiuning@gmail.com>
#       CREATED: 2015-01-31 15:56:14 -0500
#       VERSION: 0.0
#
#=============================================================================

args = commandArgs(trailingOnly=TRUE)

url = 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
csvFILE = 'ss06hid.csv'
dat = read.csv(csvFILE)
agricultureLogical = with(dat, ACR==3 & AGS==6)
print(which(agricultureLogical))

library(jpeg)
url2 = 'http://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg'
download.file(url2, 'jeff.jpg')
jpg = readJPEG('jeff.jpg', native=TRUE)
object.size(jpg)
quantile(jpg, prob=c(0.3, 0.8))



download.file('http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv', 'fedstats_country.csv')
download.file('http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv', 'fgdp.csv')

fed = read.csv('fedstats_country.csv')
head(fed)

gdp = read.csv('fgdp.csv', skip=3, header=T, colClasses='character')
gdp$gdp = as.numeric(gsub(',', '', gdp$US.dollars.))
gdp$Ranking = as.numeric(gdp$Ranking)
gdp = gdp[!is.na(gdp$Ranking), ]
head(gdp)

length(intersect(gdp$X, fed$CountryCode))
bigdata = merge(gdp, fed, by.x='X', by.y='CountryCode')
bigdata = bigdata[order(bigdata$gdp), ]
tail(bigdata)
bigdata[13,]

with(bigdata, tapply(Ranking, Income.Group, mean))

income5 = with(bigdata, cut(Ranking, quantile(Ranking, seq(0, 1, 1/5))))
table(bigdata$Income.Group, income5)
