#Ahora investigar?s la dependencia o independencia del n?mero de goles anotados 
#por el equipo de casa y el n?mero de goles anotados por el equipo visitante mediante 
#un procedimiento denominado bootstrap, revisa bibliograf?a en internet para que 
#tengas nociones de este desarrollo.

suppressMessages(suppressWarnings(library(dplyr)))

##### 
# FAVOR DE EJECUTAR EN CASO DE NO HABER GENERADO EL DF EN EL CASO ANTERIOR.

setwd("C:/Users/HP/Desktop/CURSO BEDU FASE 2/archivos") # Depende del usuario
getwd()

# Descarga los datos de la temporada 2019/2020

url1 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv"
url2 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
url3 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"

download.file(url = url1, destfile = "Temporada2017-2018.csv", mode = "wb")
download.file(url = url2, destfile = "Temporada2018-2019.csv", mode = "wb")
download.file(url = url3, destfile = "Temporada2019-2020.csv", mode = "wb")

datos2017 <- read.csv("Temporada2017-2018.csv")
datos2018 <- read.csv("Temporada2018-2019.csv")
datos2019 <- read.csv("Temporada2019-2020.csv")

# Guardarlos en las variables, así como seleccionar 

datos2017 <- select(datos2017, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)
datos2017 <- mutate(datos2017, Date = as.Date(Date, "%d/%m/%y"))

datos2018 <- select(datos2018, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)
datos2018 <- mutate(datos2018, Date = as.Date(Date, "%d/%m/%y"))

datos2019 <- select(datos2019, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)
datos2019 <- mutate(datos2019, Date = as.Date(Date, "%d/%m/%y"))

LIGAESP <- rbind(datos2017, datos2018, datos2019)

#####

#1.-Ya hemos estimado las probabilidades conjuntas de que el equipo de casa anote X=x 
#goles (x=0,1,... ,8), y el equipo visitante anote Y=y goles (y=0,1,... ,6), 
#en un partido. Obt?n una tabla de cocientes al dividir estas probabilidades 
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

#2.-Mediante un procedimiento de boostrap, obt?n m?s cocientes similares a los 
#obtenidos en la tabla del punto anterior. Esto para tener una idea de las distribuciones
#de la cual vienen los cocientes en la tabla anterior. Menciona en cu?les casos le parece
#razonable suponer que los cocientes de la tabla en el punto 1, son iguales a 1 (en tal caso tendr?amos independencia de las variables aleatorias X y Y).
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

(df2 <- melt(df2)) # funci?n del paquete reshape2
df2

# Las frecuencias relativas son muy parecidas a las probabilidades.
library(ggplot2)
ggplot(df2, aes(x = Var1 , y = value, fill = Var2)) + 
  geom_bar (stat="identity", position = "dodge") # Funciones del paquete ggplot2

