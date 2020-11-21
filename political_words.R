require(tidyr)
require(tidyverse)
library(readr)
library(readxl)
library(readtext)
political_words <- read_excel("political_words.xlsx")

political_words <- as.character(political_words)
political_words <- gsub('\"', "", political_words, fixed = TRUE)
political_words <- str_sub(political_words, 3,-2)
political_words <- gsub('\n', "", political_words, fixed = TRUE)
political_words <- political_words %>% str_replace_all(", ", "|")


twitter_text <- readtext("unique_tweets.csv", text_field = "text")  # Indicates the column with the tweet.
twitter_text <- twitter_text %>% filter(text != "")

political_tweets <- twitter_text %>% 
  filter(str_detect(text, pattern = political_words))
write.csv(political_tweets, "political_tweets.csv", row.names = F)
