instructorURL = "https://api.github.com/users/jtleek/repos"
library(httr)
Sys.setenv(GITHUB_CONSUMER_SECRET='1a74b9ce0467d429ec38e6b0e085339605cb08a9')
myapp = oauth_app("github", "5d96c0f3e326b3d96519")
endpts <- oauth_endpoints('github')
#endpts <- oauth_endpoint(authorize = "authorize", access = "access_token", base_url = "https://github.com/login/oauth")
github_token <- oauth2.0_token(endpts, myapp)
gtoken = config(token=github_token)
#req = GET("https://api.github.com/rate_limit", gtoken)
req = GET(instructorURL, gtoken)
stop_for_status(req)
library(jsonlite)
cont = content(req, as='text')
a = fromJSON(cont)
a[match('datasharing', a$name),'created_at']

csvFILE = 'ss06pid.csv'
url = 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv'
if (!file.exists(csvFILE)){
	download.file(url, csvFILE)
}

library(sqldf)
acs = read.csv(csvFILE)
sql1 = sqldf("select * from acs where AGEP < 50")
sql2 = sqldf("select * from acs where AGEP < 50 and pwgtp1")
sql3 = sqldf("select pwgtp1 from acs where AGEP < 50")
sql4 = sqldf("select * from acs")

right = acs$pwgtp1[acs$AGEP < 50]
identical(right, sql3$pwgtp1)

html = url('http://biostat.jhsph.edu/~jleek/contact.html')
dat = readLines(html)
sapply(dat[c(10, 20, 30, 100)], nchar)


fwfFILE = 'wksst8110.for'
url = 'https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for'
if (!file.exists(fwfFILE)){
	download.file(url, fwfFILE, 'curl')
}
#2-10 16-19 20-23 29-32 33-36 42-45 46-49 55-58 59-62
d = read.fwf(fwfFILE, widths=c(-28, 4), skip=4)
qapply(d, sum)
