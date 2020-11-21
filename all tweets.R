library(readbulk)
library(tidyverse)
require(data.table)

tweets <- read_bulk(directory = "all tweets",
                    extension = ".csv")
tweets <- tweets %>% 
  mutate(text = str_to_lower(text, locale = "pt"))
write.csv(tweets, 'all_tweets.csv', row.names = F)
