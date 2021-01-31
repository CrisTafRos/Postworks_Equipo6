#Ahora investigarás la dependencia o independencia del número de goles anotados 
#por el equipo de casa y el número de goles anotados por el equipo visitante mediante 
#un procedimiento denominado bootstrap, revisa bibliografía en internet para que 
#tengas nociones de este desarrollo.

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
ligaespañola<-rbind(df2020,df2019,df2018)
LIGAESP <- mutate(ligaespañola, Date = as.Date(Date, "%d/%m/%y"))
LIGAESP
#1.-Ya hemos estimado las probabilidades conjuntas de que el equipo de casa anote X=x 
#goles (x=0,1,... ,8), y el equipo visitante anote Y=y goles (y=0,1,... ,6), 
#en un partido. Obtén una tabla de cocientes al dividir estas probabilidades 
#conjuntas por el producto de las probabilidades marginales correspondientes.
casaanote<-table(LIGAESP$FTHG)
x<-prop.table(casaanote)
x
visitaanote<-table(LIGAESP$FTAG)
y<-prop.table(visitaanote)
y
conjunta<-table(LIGAESP$FTHG,LIGAESP$FTAG)
xy<-prop.table(conjunta)
xy
k<-1
co<-(x[1]*y[1])/xy[1,1]
for(i in 1:9) {
  for(j in 1:7){
    co[k]<-(x[i]*y[j])/xy[i,j]
    k=k+1
  }
}
str(co)

coci<-data.frame(co)
coci

#2.-Mediante un procedimiento de boostrap, obtén más cocientes similares a los 
#obtenidos en la tabla del punto anterior. Esto para tener una idea de las distribuciones
#de la cual vienen los cocientes en la tabla anterior. Menciona en cuáles casos le parece
#razonable suponer que los cocientes de la tabla en el punto 1, son iguales a 1 (en tal caso tendríamos independencia de las variables aleatorias X y Y).
library(rsample)
#install.packages("rsample")
coci2<-bootstraps(coci, times = 63)
coci2
boostrap<-coci2$splits[[1]]
boostrap
cociboostrap<-as.data.frame(boostrap)
str(cociboostrap)
cociboostrap<-sort(cociboostrap$co)
cociboostrap
coci<-sort(coci$co)
(df2 <- cbind(coci,cociboostrap))
(names(df2) <- c("valores", "cocientes", "bootstraps"))

(df2 <- melt(df2)) # función del paquete reshape2
df2

# Las frecuencias relativas son muy parecidas a las probabilidades.
library(ggplot2)
ggplot(df2, aes(x = Var1 , y = value, fill = Var2)) + 
  geom_bar (stat="identity", position = "dodge") # Funciones del paquete ggplot2

