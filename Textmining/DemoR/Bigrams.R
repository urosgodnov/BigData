library(readxl)
library(dplyr)
library(tidyverse)
library(tidytext)


data<-read.csv(file="TA.csv",stringsAsFactors = FALSE, sep=";")

bigrams <- select(data,Review) %>%
  unnest_tokens(bigram, Review, token = "ngrams", n = 2)

words <- c("room", "food")

bigram_counts <- bigrams %>%
  count(bigram, sort = TRUE) %>%
  separate(bigram, c("word1", "word2"), sep = " ") %>%
  filter(word1 %in% words & nchar(word2)>3  ) %>%
  count(word1, word2, wt = n, sort = TRUE) %>%
  rename(total = nn)

word_ratios <- bigram_counts %>%
  group_by(word2) %>%
  filter(sum(total) > 2) %>%
  ungroup() %>%
  spread(word1, total, fill = 0) %>%
  mutate_if(is.numeric, funs((. + 1) / sum(. + 1))) %>%
  mutate(logratio = log2(room / food)) %>%
  arrange(desc(logratio))   

word_ratios %>% 
  arrange(abs(logratio))

word_ratios %>%
  mutate(abslogratio = abs(logratio)) %>%
  group_by(logratio < 0) %>%
  top_n(10, abslogratio) %>%
  ungroup() %>%
  mutate(word = reorder(word2, logratio)) %>%
  ggplot(aes(word, logratio, color = logratio < 0)) +
  geom_segment(aes(x = word, xend = word,
                   y = 0, yend = logratio), 
               size = 1.1, alpha = 0.6) +
  geom_point(size = 3.5) +
  coord_flip() +
  labs(x = NULL, 
       y=NULL) +
  scale_color_discrete(name = "", labels = c("more with 'room'", "more with 'food'")) +
  scale_y_continuous(breaks = seq(-3, 3),
                     labels = c("0.125x", "0.25x", "0.5x", 
                                "Equal", "2x", "4x", "8x"))


