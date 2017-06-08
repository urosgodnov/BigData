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
  
#Demo census
data<-read.csv(file="./Sampledata/Census.csv", sep=",", stringsAsFactors = FALSE)

df<-dplyr::filter(data,native.country==" United-States")%>%
    select(marital.status, education,relationship,sex,income)

ggplot(df, aes(x=sex, fill=income))+
  geom_bar()+facet_grid(~education)+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+ 
  theme(strip.text.x = element_text(size = 8, colour = "blue", angle = 90))


df1<-dplyr::filter(data,native.country==" United-States")%>%select(sex,education,income)%>%
  group_by(sex,education,income)%>%summarise(freq=n())%>%
  ungroup()%>%group_by(sex)%>%mutate(proportion=round(freq/sum(freq)*100,2))%>%
  arrange(desc(proportion))


ggplot(df1, aes(x=sex, y=proportion,fill=income))+
  geom_bar(stat="identity")+facet_grid(~education)+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+ 
  theme(strip.text.x = element_text(size = 8, colour = "blue", angle = 90))



#proportions
df1<-dplyr::filter(data,native.country==" United-States")%>%select(sex,income)%>%
  group_by(sex,income)%>%summarise(freq=n())%>%
  ungroup()%>%group_by(sex)%>%mutate(proportion=freq/sum(freq)*100)%>%
  filter(income==" >50K")

df1
