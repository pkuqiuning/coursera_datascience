#!/usr/bin/env Rscript
#=============================================================================
#
#          FILE: quiz.R
#
#   DESCRIPTION: 
#
#        AUTHOR: fantasy <pkuqiuning@gmail.com>
#       CREATED: 2015-02-05 17:48:26 -0500
#       VERSION: 0.0
#
#=============================================================================

args = commandArgs(trailingOnly=TRUE)

x <- 1:4
p <- x/sum(x)
temp <- rbind(x, p)
rownames(temp) <- c("X", "Prob")
temp
sum(x*p)


#######################################
#week2
1100 + 75*qnorm(0.95)
1100 + 75/sqrt(100) * qnorm(0.95)
1 - pbinom(3, 5, 0.5)
sum(dbinom(4:5, 5, 0.5))

ppois(10, 15)
###################################
#week3
1100 + c(-1,1) * 30/sqrt(9) * qt(0.975, df=9-1)
2 / qt(0.975, df=9-1) * sqrt(9)
sp = sqrt((0.60 + 0.68)/2)
3 - 5 + c(-1,1) * sp / sqrt(10/2) * qt(0.975, df=20-2)
sp = sqrt(0.5^2 / 100 + 2^2/100)
4-6 + c(-1,1)*sp*qnorm(0.975)

sp = sqrt((1.5^2+1.8^2)/2)
-3-1 + c(-1,1)*sp*sqrt(2/9)*qt(0.95, df=18-2)
#####################################3
#week4
power.t.test
tab = '
Subject 	Baseline 	Week2
1 	140 	132
2 	138 	135
3 	150 	151
4 	148 	146
5 	135 	130
'
con = textConnection(tab)
data = read.table(con, header = TRUE)
t.test(data$Baseline-data$Week2)
1100 + c(-1,1) * 30/sqrt(9) * qt(0.975, 9-1)

1-pbinom(2, 4, 0.5)
pbinom(10, 1787, 0.01)
sp = sqrt((1.5^2 + 1.8^2)/2)
tvalue = (-3-1)/(sp/sqrt(9/2))
2*pt(tvalue, df=18-2)

power.t.test(100, 0.01, 0.04, type='one.sample', alternative = 'one.sided')
power.t.test(delta=0.01, sd=0.04, power=.9, type = 'one.sample', alternative = 'one.sided')
