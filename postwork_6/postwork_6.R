# Postwork 6

install.packages("lubridate")
library(lubridate) # para función ymd()

url <- "https://github.com/beduExpert/Programacion-con-R-Santander/raw/master/Sesion-06/Postwork/match.data.csv"
download.file(url = url, destfile = "match.data.csv", mode = "wb")

# Almacenando data
match.data <- read.csv("match.data.csv")
head(match.data)
summary(match.data)

# Convirtiendo date a tipo fecha
match.data <- mutate(match.data, date = as.Date(ymd(date)))
head(match.data)
summary(match.data)

# Nueva columna que contenga la suma de goles por partido
match.data <- mutate(match.data, sumagoles = as.integer(home.score + away.score))
head(match.data); tail(match.data)

# Promedio de la suma de goles
round(mean(match.data$sumagoles),digits = 3)

# Promedio por mes de la suma de goles
match.data <- select(match.data, date, sumagoles)
match.data <- mutate(match.data, month = month(match.data$date), year = year(match.data$date))
match.data <- select(match.data, month, year, sumagoles)
str(match.data)

# Acumulando
prom.match <- aggregate(sumagoles ~ month+year, match.data, mean)
prom.match[1:96, ]

# Tomando año y mes de inicio
yr <- prom.match$year[1]
mo <- prom.match$month[1]

# para acomodar en tabla
timeserie <- ts(prom.match$sumagoles, start = c(yr,mo), freq = 12)
class(timeserie)

# Grafica la serie de tiempo
plot(timeserie, type = "o", ylab = "Goles", xlab = "Tiempo", main = "Promedio de goles desde 2010")

# Crea la serie de tiempo del promedio por mes de la suma de goles hasta diciembre de 2019.



