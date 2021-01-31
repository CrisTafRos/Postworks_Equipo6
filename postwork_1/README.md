# Postwork de la sesion 1. Introducción a R y Software

**Contexto:** Se toman los datos referentes a equipos de la liga española de futbol.

1. Importamos los datos de soccer de la temporada 2019/2020 de la primera división de la liga española a R. Disponibles en: https://www.football-data.co.uk/spainm.php

```r
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
```

Se obtiene un resultado como el siguiente:
```r
> head(datos); tail(datos); str(datos)
  Div       Date  Time   HomeTeam    AwayTeam FTHG FTAG FTR HTHG HTAG HTR
1 SP1 16/08/2019 20:00 Ath Bilbao   Barcelona    1    0   H    0    0   D
2 SP1 17/08/2019 16:00      Celta Real Madrid    1    3   A    0    1   A
3 SP1 17/08/2019 18:00   Valencia    Sociedad    1    1   D    0    0   D
4 SP1 17/08/2019 19:00   Mallorca       Eibar    2    1   H    1    0   H
5 SP1 17/08/2019 20:00    Leganes     Osasuna    0    1   A    0    0   D
6 SP1 17/08/2019 20:00 Villarreal     Granada    4    4   D    1    1   D
...
    Div       Date  Time HomeTeam    AwayTeam FTHG FTAG FTR HTHG HTAG HTR
375 SP1 19/07/2020 20:00  Espanol       Celta    0    0   D    0    0   D
376 SP1 19/07/2020 20:00  Granada  Ath Bilbao    4    0   H    1    0   H
377 SP1 19/07/2020 20:00  Leganes Real Madrid    2    2   D    1    1   D
378 SP1 19/07/2020 20:00  Levante      Getafe    1    0   H    0    0   D
379 SP1 19/07/2020 20:00  Osasuna    Mallorca    2    2   D    1    1   D
380 SP1 19/07/2020 20:00  Sevilla    Valencia    1    0   H    0    0   D
...
'data.frame':	380 obs. of  105 variables:
 $ Div        : chr  "SP1" "SP1" "SP1" "SP1" ...
 $ Date       : chr  "16/08/2019" "17/08/2019" "17/08/2019" "17/08/2019" ...
 $ Time       : chr  "20:00" "16:00" "18:00" "19:00" ...
 $ HomeTeam   : chr  "Ath Bilbao" "Celta" "Valencia" "Mallorca" ...
 $ AwayTeam   : chr  "Barcelona" "Real Madrid" "Sociedad" "Eibar" ...
 $ FTHG       : int  1 1 1 2 0 4 1 0 1 1 ...
 $ FTAG       : int  0 3 1 1 1 4 0 2 2 0 ...
 ...
```

2. Extrae las columnas que contienen los anotados por los equipos que jugaron en casa (FTHG) y los goles anotados por los equipos que jugaron como visitante (FTAG)

```r
# Seleccionar las columas de goles como local y como visitante
datos <- select(datos, FTHG, FTAG)

#Se obtienen las frecuencias de los goles de local y visitante por separado
frecuenciaLocal <- table(datos$FTHG)
frecuenciaVisitante <- table(datos$FTAG)

#Hacemos una prvisualización
head(frecuenciaLocal)
head(frecuenciaVisitante)
```

Para obtener:
```r
> head(frecuenciaLocal)

  0   1   2   3   4   5 
 88 132  99  38  14   8 
> head(frecuenciaVisitante)

  0   1   2   3   4   5 
136 134  81  18   9   2 
```

3. Consultar cómo funciona la función table en R al ejecutar en la consola:
```r
?table
```
Posteriormente se obtuvieron:
- La probabilidad (marginal) de que el equipo que juega en casa anote x goles
```r
probabilidad.Local <- round(prop.table(frecuenciaLocal, margin = NULL), digits = 3)
probabilidad.Local
```
Resultado:
```r
> probabilidad.Local

    0     1     2     3     4     5     6 
0.232 0.347 0.261 0.100 0.037 0.021 0.003 
```
- La probabilidad (marginal) de que el equipo que juega como visitante anote y goles
```r
probabilidad.Visitante <- round(prop.table(frecuenciaVisitante, margin = NULL), digits = 3)
probabilidad.Visitante
```
Resultado:
```r
> probabilidad.Visitante

    0     1     2     3     4     5 
0.358 0.353 0.213 0.047 0.024 0.005 
```
- La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega como visitante anote y goles
```r
prob.Conjunta <-datos %>%
  select(FTHG, FTAG) %>%
  table() %>%
  prop.table()
prob.Conjunta
```
Resultado:
```r
FTAG
FTHG           0           1           2           3           4           5
   0 0.086842105 0.073684211 0.039473684 0.021052632 0.005263158 0.005263158
   1 0.113157895 0.128947368 0.084210526 0.013157895 0.007894737 0.000000000
   2 0.102631579 0.092105263 0.052631579 0.007894737 0.005263158 0.000000000
   3 0.036842105 0.036842105 0.018421053 0.005263158 0.002631579 0.000000000
   4 0.010526316 0.013157895 0.010526316 0.000000000 0.002631579 0.000000000
   5 0.005263158 0.007894737 0.007894737 0.000000000 0.000000000 0.000000000
   6 0.002631579 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
```

[Descripción de preworks](https://github.com/CrisTafRos/Postworks_Equipo6) | [Postwork Siguiente](#) 
