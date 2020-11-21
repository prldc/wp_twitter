require(quanteda)
require(tidyverse)
require(readtext)
require(data.table)
require(openxlsx)
library(tidyverse)

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

stop <- unlist(stop, use.names=FALSE)

twitter_text <- readtext("all_tweets.csv", text_field = "text")  # Indicates the column with the tweet.
twitter_text <- twitter_text %>% filter(text != "")
corpus <- corpus(twitter_text)
docnames(corpus) <- twitter_text$date
tokens <- tokens(corpus, remove_punct = T, remove_symbols = T, remove_url = T, remove_numbers = T, verbose = T)
tokens <- tokens_remove(tokens, stopwords("portuguese"))
tokens <- tokens_remove(tokens, stop)
dfm <- dfm(tokens, case_insensitive = T) %>% dfm_trim(min_docfreq = 50, 
                                                      verbose=TRUE)
top <- textstat_frequency(dfm, n = 100)
top_words <- as_tibble(textstat_frequency(dfm, n = 2000))
top$feature <- with(top, reorder(feature, -frequency))
ggplot(top, aes(x = feature, y = frequency)) +
  geom_point() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

write.xlsx(top, 'top_words.xlsx', row.names = F)