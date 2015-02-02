#!/usr/bin/env Rscript
#=============================================================================
#
#          FILE: quiz4.R
#
#   DESCRIPTION: 
#
#        AUTHOR: fantasy <pkuqiuning@gmail.com>
#       CREATED: 2015-01-31 22:07:53 -0500
#       VERSION: 0.0
#
#=============================================================================

args = commandArgs(trailingOnly=TRUE)

dat = read.csv('ss06hid.csv')
strsplit(names(dat), 'wgtp')[123]

library(data.table)
gdp = fread('fgdp.csv', skip=3)
setnames(gdp, 5, 'dollars')
setnames(gdp, 'V1', 'CountryCode')
gdp = gdp[!is.na(as.numeric(Ranking))]
gdp[,dollars:= as.numeric(gsub(',', '', dollars))] 
gdp[,mean(dollars)]

gdp[grep('^United', Economy)]

fed = fread('fedstats_country.csv')
bigdata = merge(gdp, fed, by='CountryCode')


bigdata[grepl('[Ff]iscal year.*June', bigdata$"Special Notes"), "Special Notes", with=F]


library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 

a = as.Date(sampleTimes)
table(year(a))
a2012 = a[year(a) == 2012]
table(weekdays(a2012))
