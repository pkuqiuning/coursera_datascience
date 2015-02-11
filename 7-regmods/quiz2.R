#!/usr/bin/env Rscript
#=============================================================================
#
#          FILE: quiz2.R
#
#   DESCRIPTION: 
#
#        AUTHOR: fantasy <pkuqiuning@gmail.com>
#       CREATED: 2015-02-10 06:55:17 -0500
#       VERSION: 0.0
#
#=============================================================================

x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)
y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)
summary(lm(y~x))

data(mtcars)
fit = lm(mpg~wt, data=mtcars)
summary(fit)
predict(fit, data.frame(wt=mean(mtcars$wt)), interval='confidence')
help(mtcars)
predict(fit, data.frame(wt=3), interval='predict')
confint(fit) * 2
