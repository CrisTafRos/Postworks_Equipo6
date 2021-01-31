#1.-Con el ?ltimo data frame obtenido en el postwork de la sesi?n 2, elabora 
#tablas de frecuencias relativas para estimar las siguientes probabilidades:


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

head(LIGAESP)

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

#Un gráfico de barras para las probabilidades marginales estimadas del número 
#de goles que anota el equipo de casa
hist(LIGAESP$FTHG,freq = FALSE,breaks = (seq(0,8, 0.5)),
     main = "Probabilidades marginales estimadas del número de goles que anota el equipo de casa",
     xlab = "goles",
     ylab = "probabilidad")

#Un gr?fico de barras para las probabilidades marginales estimadas del 
#n?mero de goles que anota el equipo visitante.
hist(LIGAESP$FTAG,freq = FALSE,breaks = (seq(0,8, 0.5)),
     main = "Probabilidades marginales estimadas del número de goles que anota el equipo visitante",
     xlab = "goles",
     ylab = "probabilidades")

#Un HeatMap para las probabilidades conjuntas estimadas de los n?meros de goles 
#que anotan el equipo de casa y el equipo visitante en un partido.
library(ggplot2)
library(reshape2)

# Recordando la probabilidad conjunta:
conjunta
pro.conjunta<-prop.table(conjunta)
pro.conjunta

# Adaptando a una tabla
conjunta.m=melt(pro.conjunta)
conjunta.m

# Mostrando el heatmap
ggplot(conjunta.m, aes(x = Var1, y = Var2, fill = value)) + 
        geom_tile() +
        xlab(label = "FTHG") +
        ylab(label = "FTAG") +
        scale_fill_gradient(name = "Probabilidad Conjunta")

head(conjunta.m)
