#POSTWORK SESI?N 2

# Llamar los packages que se usar?n
suppressPackageStartupMessages(library(dplyr))

# Crear una PostWork y lo establece como directorio de trabajo
dir.create("PostWork", showWarnings = F)
setwd(paste(getwd(), "/PostWork", sep = ""))

# Descarga los datos de la temporada 2019/2020
url1 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv"
url2 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
url3 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"
download.file(url = url1, destfile = "Temporada2017-2018.csv", mode = "wb")
download.file(url = url2, destfile = "Temporada2018-2019.csv", mode = "wb")
download.file(url = url3, destfile = "Temporada2019-2020.csv", mode = "wb")

# Guardarlos en las variables
datos2017 <- read.csv("Temporada2017-2018.csv")
datos2018 <- read.csv("Temporada2018-2019.csv")
datos2019 <- read.csv("Temporada2019-2020.csv")

# Muestra algunas características de los datos
str(datos2017)
str(datos2018)
str(datos2019)

head(datos2017); tail(datos2017)
head(datos2018); tail(datos2018)
head(datos2019); tail(datos2019)

View(datos2017)
View(datos2018)
View(datos2019)

summary(datos2017)
summary(datos2018)
summary(datos2019)

# Selecciona las columnas con las que se trabajar? y se analiza el df (se hace lo mismo con los otros df)
datos2017 <- select(datos2017, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)
str(datos2017)
# Se le da formato de fecha a la columna de date y se analiza el df (se hace lo mismo con los otros df)
datos2017 <- mutate(datos2017, Date = as.Date(Date, "%d/%m/%y"))
str(datos2017)

datos2018 <- select(datos2018, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)
str(datos2018)
datos2018 <- mutate(datos2018, Date = as.Date(Date, "%d/%m/%y"))
str(datos2018)

datos2019 <- select(datos2019, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)
str(datos2019)
datos2019 <- mutate(datos2019, Date = as.Date(Date, "%d/%m/%y"))
str(datos2019)

# Se agrupan los df en uno solo
LIGAESP <- rbind(datos2017, datos2018, datos2019)
# Se ven los primeros y ?ltimos datos
head(LIGAESP);tail(LIGAESP)
