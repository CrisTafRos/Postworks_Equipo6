# POSTWORK SESIÓN 1

# Llamar los packages que se usarán
suppressPackageStartupMessages(library(dplyr))

# Crear una PostWork y lo establece como directorio de trabajo
dir.create("PostWork", showWarnings = F)
setwd(paste(getwd(), "/PostWork", sep = ""))

# Descarga los datos de la temporada 2019/2020
url1 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"
download.file(url = url1, destfile = "Temporada2019-2020", mode = "wb")

# Guardarlos en la variable datos
datos <- read.csv("Temporada2019-2020")

#Revisar la estructura general
head(datos); tail(datos); str(datos)


# Seleccionar las columas de goles como local y como visitante
datos <- select(datos, FTHG, FTAG)

#Se obtienen las frecuencias de los goles de local y visitante por separado
frecuenciaLocal <- table(datos$FTHG)
frecuenciaVisitante <- table(datos$FTAG)

# Se obtiene las probabilidades conjuntas
frecuencia.Local <- round(prop.table(frecuenciaLocal, margin = NULL), digits = 3)
frecuencia.Visitante <- round(prop.table(frecuenciaVisitante, margin = NULL), digits = 3)

# Se calcula probabilidad conjunta
prob.Conjunta <-datos %>%
  select(FTHG, FTAG) %>%
  table() %>%
  prop.table()

# Mostramos los resultados
frecuencia.Local
frecuencia.Visitante
prob.Conjunta
