library(tm)
library(readxl)
library(dplyr)
library(tidytext)
library(graph)
library(Rgraphviz)
library(tidyr)
library(broom)
library(fst)
library(lubridate)
library(ggplot2)
library(scales)

data<-read.csv(file="TA.csv",stringsAsFactors = FALSE, sep=";")



doc.vec <- VectorSource(data$Review)
doc.corpus <- Corpus(doc.vec)
doc.corpus <- tm_map(doc.corpus, content_transformer(tolower))
doc.corpus <- tm_map(doc.corpus, removePunctuation)
doc.corpus <- tm_map(doc.corpus, removeNumbers)

doc.corpus <- tm_map(doc.corpus, removeWords,stopwords(kind = "en"))

doc.corpus <- tm_map(doc.corpus, stripWhitespace)

inspect(doc.corpus[120])

tdm <- TermDocumentMatrix(doc.corpus, control = list(wordLengths = c(3, Inf)))

freq.terms <- findFreqTerms(tdm, lowfreq=100)




