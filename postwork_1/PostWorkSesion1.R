# POSTWORK SESIÓN 1

# Llamar los packages que se usarán
suppressPackageStartupMessages(library(dplyr))

# Crear una PostWork y lo establece como directorio de trabajo
dir.create("PostWork", showWarnings = F)
setwd(paste(getwd(), "/PostWork", sep = ""))

# Descarga los datos de la temporada 2019/2020
url1 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"
download.file(url = url1, destfile = "Temporada2019-2020.csv", mode = "wb")

# Guardarlos en la variable datos
datos <- read.csv("Temporada2019-2020.csv")

#Revisar la estructura general
head(datos); tail(datos); str(datos)


# Seleccionar las columas de goles como local y como visitante
datos <- select(datos, FTHG, FTAG)

#Se obtienen las frecuencias de los goles de local y visitante por separado
frecuenciaLocal <- table(datos$FTHG)
frecuenciaVisitante <- table(datos$FTAG)

#Hacemos una previsualización
head(frecuenciaLocal)
head(frecuenciaVisitante)

# Consultar cómo funciona la función table en R al ejecutar en la consola:
?table

# Se obtiene las probabilidades marginales
# La probabilidad (marginal) de que el equipo que juega en casa anote x goles
probabilidad.Local <- round(prop.table(frecuenciaLocal, margin = NULL), digits = 3)
probabilidad.Local

# La probabilidad (marginal) de que el equipo que juega como visitante anote y goles
probabilidad.Visitante <- round(prop.table(frecuenciaVisitante, margin = NULL), digits = 3)
probabilidad.Visitante

# Se calcula probabilidad conjunta
prob.Conjunta <-datos %>%
  select(FTHG, FTAG) %>%
  table() %>%
  prop.table()
prob.Conjunta

