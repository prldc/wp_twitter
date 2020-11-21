library(readbulk)
library(tidyverse)
require(quanteda)
require(tidyverse)
require(readtext)
require(data.table)
require(openxlsx)
library(tidyverse)

BolsonaroSPFriends <- read_bulk(directory = "BolsonaroSP Friends",
                                extension = ".csv")

BolsonaroSPFriends <- BolsonaroSPFriends %>% 
  group_by(username) %>% 
  mutate(text = str_to_lower(text, locale = "pt")) %>% 
  mutate(date = as.Date(date))
write.csv(BolsonaroSPFriends, 'EduardoFriends.csv', row.names = F)

JBFriends <- read_bulk(directory = "jairbolsonaro Friends",
                       extension = ".csv")

JBFriends <- JBFriends %>% 
  group_by(username) %>% 
  mutate(text = str_to_lower(text, locale = "pt")) %>% 
  mutate(date = as.Date(date))
write.csv(JBFriends, 'JBFriends.csv', row.names = F)

LulaFriends <- read_bulk(directory = "LulaOficial Friends",
                         extension = ".csv")

LulaFriends <- LulaFriends %>% 
  group_by(username) %>% 
  mutate(text = str_to_lower(text, locale = "pt")) %>% 
  mutate(date = as.Date(date))
write.csv(LulaFriends, 'LulaFriends.csv', row.names = F)

BoulosFriends <- read_bulk(directory = "GuilhermeBoulos Friends",
                    extension = ".csv")

BoulosFriends <- BoulosFriends %>% 
  group_by(username) %>% 
  mutate(text = str_to_lower(text, locale = "pt")) %>% 
  mutate(date = as.Date(date))
write.csv(BoulosFriends, 'BoulosFriends.csv', row.names = F)

CiroFriends <- read_bulk(directory = "cirogomes Friends",
                  extension = ".csv")

CiroFriends <- CiroFriends %>% 
  group_by(username) %>% 
  mutate(text = str_to_lower(text, locale = "pt")) %>% 
  mutate(date = as.Date(date))
write.csv(CiroFriends, 'CiroFriends.csv', row.names = F)

HaddadFriends <- read_bulk(directory = "Haddad_Fernando Friends",
                    extension = ".csv")

HaddadFriends <- HaddadFriends %>% 
  group_by(username) %>% 
  mutate(text = str_to_lower(text, locale = "pt")) %>% 
  mutate(date = as.Date(date))
write.csv(HaddadFriends, 'HaddadFriends.csv', row.names = F)

CarlosFriends <- read_bulk(directory = "CarlosBolsonaro Friends",
                     extension = ".csv")

CarlosFriends <- CarlosFriends %>% 
  group_by(username) %>% 
  mutate(text = str_to_lower(text, locale = "pt")) %>% 
  mutate(date = as.Date(date))
write.csv(CarlosFriends, 'CarlosFriends.csv', row.names = F)

DoriaFriends <- read_bulk(directory = "jdoriajr Friends",
                                extension = ".csv")

DoriaFriends <- DoriaFriends %>% 
  group_by(username) %>% 
  mutate(text = str_to_lower(text, locale = "pt")) %>% 
  mutate(date = as.Date(date))
write.csv(DoriaFriends, 'DoriaFriendsFriends.csv', row.names = F)
  
