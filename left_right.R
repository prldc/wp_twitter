require(quanteda) 
require(quanteda.textmodels)
require(caret)
require(tidyverse)
require(readtext)
require(tidytext)
require(viridis)
require(textmineR)
library(openxlsx)
require(e1071)

stop <- str_split("é
la
pra
en
el
sobre
ser
y
vai
q
dia
the
pode
diz
los
tá
via
hoje
ter
ainda
gente
del
agora
todos
to
vc
aqui
con
un
fazer
tudo
todo
bem
anos
las
bom
vamos
quer
faz
porque
sempre
ver
vou
es
of
nunca
in
após
novo
nada
una
aí
vida
cara
acho
and
deve
pq
al
vez
onde
tão
menos
desde
cada
dar
dá
boa
coisa
maior
tempo
sabe
disse
parte
caso
falar
apenas
pro
assim
nova
fala
vem
segundo
ano
dias
fez
lá
toda
antes
dois
precisa
vão
sendo
todas
lo
su
nao
i
qualquer
alguém
sei
meio
primeiro
le
dizer
pois
conta
semana
fim
is
outros
nesta
ficar
então
muita
sim
ninguém
outro
falta
desse
nome
estar
saber
nesse
deu
dessa
parece
pouco
hora
vivo
momento
obrigado
más
primeira
neste
tô
on
lado
pessoa
além
quase
olha
tipo
tanto
querem
tem
né
x
d
ha
kkk
kkkk
kkkkk
si
ta
that
with
tb
final
duas
vi
quanto
né
demais
outra
coisa
coisas
d
mesma
ha
vcs
alguns
ñ
nenhum
si
saiba
outras
desta
with
et
tb
you
uns
uso
tal
ai
this
n
at
ta
ato
p", pattern = "\n")

# CREATING THE NAIVE BAYES CLASSIFIER:

tweets <- readtext("political_tweets.csv", text_field = "text")

tweets <- tweets %>%
  mutate(ideologia = case_when(ideologia == "esquerda" ~ "Left",
                               ideologia == "direita" ~ "Right"))

(tweets %>% count(ideologia))

corpus <- corpus(tweets)

# Create a dfm grouped by president
dfm <- dfm(corpus, 
           tolower = F, 
           remove_punct = T,
           groups = "ideologia",
           verbose = T, 
           remove = c(stop, stopwords('portuguese')), 
           case_insensitive = T)

dfm_w <- dfm %>% dfm_weight(scheme = "prop")

freq_weight <- textstat_frequency(dfm_w, n = 10, groups = "ideologia")

ggplot(data = freq_weight, aes(x = nrow(freq_weight):1, y = frequency)) +
  geom_point() +
  facet_wrap(~ group, scales = "free") +
  coord_flip() +
  scale_x_continuous(breaks = nrow(freq_weight):1,
                     labels = freq_weight$feature) +
  labs(x = NULL, y = "Relative frequency")

# Calculate keyness and determine Trump as target group
result_keyness <- textstat_keyness(dfm, target = "Right")

# Plot estimated word keyness
textplot_keyness(result_keyness) 