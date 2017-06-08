#Package installed

print(rownames(installed.packages()))


#Demo 1

library(PerformanceAnalytics)
chart.Correlation(dataset1)


#ggplot2 example
packages=c("ggplot2","dplyr","reshape2")
package.check <- lapply(packages, FUN = function(x) {
  if (!require(x, character.only = TRUE)) {
    install.packages(x, dependencies = TRUE)
    library(x, character.only = TRUE)
  }
})

Tips<-within(tips, ratio<-tip/total_bill)
             
plot<-ggplot(tips, aes(x=total_bill, y=ratio))+geom_point(shape=1)+
      facet_grid(time~sex)
             
plot<-plot+geom_smooth(method=lm, se=FALSE)
             
print(plot)



#Demo 1/a
# fuel, bodytype, horsepower, price
dataset1 <- maml.mapInputPort(1) # class: data.frame

library("ggplot2")

plot<-ggplot(dataset1, aes(x=horsepower, y=price))+geom_point(shape=1)

plot<-plot+facet_grid(fuel~.)

plot
             