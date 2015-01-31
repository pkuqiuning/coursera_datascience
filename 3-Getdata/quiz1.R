QUIZFILE = 'ss06hid.csv'
QUIZFILE_URL = 'http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
if(!file.exists(QUIZFILE)){
    download.file(QUIZFILE_URL, 'ss06hid.csv')
    date_downloaded = date()
}
qdata = read.csv('ss06hid.csv')
sum(qdata$VAL == 24, na.rm=T)


NGAPFILE = 'DATA.gov_NGAP.xlsx'
NGAP_URL = 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx'
if(!file.exists(NGAPFILE)){
    download.file(NGAP_URL, NGAPFILE, method='curl')
    date_downloaded = date()
}
library(xlsx)
dat = read.xlsx(NGAPFILE, sheetIndex = 1, rowIndex = 18:23, colIndex = 7:15)
sum(dat$Zip*dat$Ext,na.rm=T) 

library(XML)
fileURL = 'http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml'
doc = xmlTreeParse(fileURL, useInternalNodes = T)
rootNode = xmlRoot(doc)
sum(xpathSApply(rootNode, '//zipcode', xmlValue) == '21231', na.rm=T)

DTFILE = 'ss06pid.csv'
fileURL = 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv'
if (!file.exists(DTFILE)){
	download.file(fileURL, DTFILE, method = 'curl')
	dateDownload = date()
}
library(data.table)
DT = fread(DTFILE)

system.time(for (i in 1:100){mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)})
system.time(for (i in 1:100){DT[,mean(pwgtp15),by=SEX]})
system.time(for (i in 1:100){rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]})
system.time(for (i in 1:100){tapply(DT$pwgtp15,DT$SEX,mean)})
system.time(for (i in 1:100){mean(DT$pwgtp15,by=DT$SEX)})
system.time(for (i in 1:100){sapply(split(DT$pwgtp15,DT$SEX),mean)})

