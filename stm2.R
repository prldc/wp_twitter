require(quanteda)
require(tidyverse)
require(readtext)
require(data.table)
require(openxlsx)
require(tidyverse)
require(stm)
require(tm)

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
$
utm_medium
utm_campaign
=
contra
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
igshid

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
ir
l
amp
c
d
mesma
ha
vcs
alguns
r
ñ
nenhum
si
saiba
mil
ser
vamos
nova
bo
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
stop <- c(stop, stopwords('portuguese'))

tweets <- readtext("political_tweets.csv")
tweets <- tweets %>% rename(documents = text.1)
processed <- textProcessor(tweets$documents, stem= F, lowercase = F, 
                           metadata = tweets, removestopwords = T, 
                           customstopwords = stop, striphtml = T)
out <- prepDocuments(processed$documents, processed$vocab, processed$meta)
docs <- out$documents
vocab <- out$vocab
meta <-out$meta
save(docs, meta, out, processed, vocab, tweets, file = "docs.RData")
load("docs.RData")

First_STM <- stm(documents = out$documents, vocab = out$vocab,
                 K = 49, prevalence =~ ideologia + date,
                 max.em.its = 75, data = out$meta,
                 init.type = "Spectral", verbose = T,
                 seed = pi)
save(First_STM, file = "stm49.RData")
plot(First_STM)
plot(First_STM, type="labels", topics=c(19,38,95,55))
plot(First_STM, type="hist")


findThoughts(First_STM, texts = tweets$documents,
             n = 1, topics = 1:20)

th<-tweets[-out$docs.removed,]
length(th)

thoughts3 <- findThoughts(First_STM,texts=th,topics=3)


findingk <- searchK(out$documents, out$vocab, K = 49,
                    prevalence =~ ideologia + date, data = meta, verbose=FALSE)

plot(findingk)
save(findingk, file = "findingk.RData")

predict_topics<-estimateEffect(formula = 1:49 ~ ideologia + date, stmobj = First_STM, 
                               metadata = out$meta, uncertainty = "Global")

save(out, meta, First_STM, file = "try_predict.RData")

save(predict_topics, file = "predict_topics.RData")

plot(predict_topics, covariate = "ideologia", topics = c(1, 2, 3),
     model = First_STM, method = "difference",
     cov.value1 = "esquerda", cov.value2 = "direita",
     xlab = "More right-wing ... More left-wing",
     main = "Effect of right-wing vs. left-wing",
     xlim = c(-.1, .1), labeltype = "custom",
     custom.labels = c('Topic 1', 'Topic 2','Topic 3'))

plot(predict_topics, "date", method = "continuous", topics = 3,
     model = z, printlegend = FALSE, xaxt = "n", xlab = "Time (2018)")
monthseq <- seq(from = as.Date("2018-01-01"),
                to = as.Date("2018-12-01"), by = "month")
monthnames <- months(monthseq)
axis(1,at = as.numeric(monthseq) - min(as.numeric(monthseq)),
     labels = monthnames)

(top <- labelTopics(First_STM))
top_tib <- as_tibble(top)
labelTopics(stm)
