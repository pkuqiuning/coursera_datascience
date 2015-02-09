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
