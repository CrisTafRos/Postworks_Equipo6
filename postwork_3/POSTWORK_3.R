
#1.-Con el �ltimo data frame obtenido en el postwork de la sesi�n 2, elabora 
#tablas de frecuencias relativas para estimar las siguientes probabilidades:
#lilibrary(dplyr)
suppressMessages(suppressWarnings(library(dplyr)))
setwd("C:/Users/HP/Desktop/CURSO BEDU FASE 2/archivos") # Depende del usuario
getwd()
tem2019_2020 <- read.csv("tem2019_2020.csv")
tem2018_2019 <- read.csv("tem2018_2019.csv")
tem2017_2018 <- read.csv("tem2017_2018.csv")
tem2020<-select(tem2019_2020, Date,HomeTeam,AwayTeam,FTHG,FTAG,FTR)
tem2019<-select(tem2018_2019, Date,HomeTeam,AwayTeam,FTHG,FTAG,FTR)
tem2018<-select(tem2017_2018, Date,HomeTeam,AwayTeam,FTHG,FTAG,FTR)
df2020<-data.frame(tem2020)
df2019<-data.frame(tem2019)
df2018<-data.frame(tem2018)
ligaespa�ola<-rbind(df2020,df2019,df2018)
LIGAESP <- mutate(ligaespa�ola, Date = as.Date(Date, "%d/%m/%y"))
LIGAESP
#La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x=0,1,2,)
casaanote<-table(LIGAESP$FTHG)
prop.table(casaanote)
#La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y=0,1,2,)
visitaanote<-table(LIGAESP$FTAG)
prop.table(visitaanote)
#La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y 
#el equipo que juega como visitante anote y goles (x=0,1,2,, y=0,1,2,)
conjunta<-table(LIGAESP$FTHG,LIGAESP$FTAG)
prop.table(conjunta)

#2.-Realiza lo siguiente:
#Un gr�fico de barras para las probabilidades marginales estimadas del n�mero 
#de goles que anota el equipo de casa
hist(LIGAESP$FTHG,freq = FALSE,breaks = (seq(0,8, 0.5)),
     main = "probabilidades marginales estimadas del n�mero de goles que anota el equipo de casa",
     xlab = "goles",
     ylab = "probabilidad")
#Un gr�fico de barras para las probabilidades marginales estimadas del 
#n�mero de goles que anota el equipo visitante.
hist(LIGAESP$FTAG,freq = FALSE,breaks = (seq(0,8, 0.5)),
     main = "probabilidades marginales estimadas del n�mero de goles que anota el equipo de casa",
     xlab = "goles",
     ylab = "probabilidades")
#Un HeatMap para las probabilidades conjuntas estimadas de los n�meros de goles 
#que anotan el equipo de casa y el equipo visitante en un partido.
library(ggplot2)
library(reshape2)
conjunta
pro.conjunta<-prop.table(conjunta)
pro.conjunta
conjunta.m=melt(pro.conjunta)
conjunta.m
ggplot(conjunta.m,aes(x=Var1,y=Var2,fill=value))+ geom_tile()