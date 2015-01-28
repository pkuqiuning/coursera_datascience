library(datasets)
data(iris)

mean(iris$Sepal.Length[iris$Species == 'virginica'])
apply(iris[, 1:4], 2, mean)

library(datasets)
data(mtcars)
with(mtcars, tapply(mpg, cyl, mean))
hp = with(mtcars, tapply(hp, cyl, mean))
abs(hp[['4']]-hp[['8']])
