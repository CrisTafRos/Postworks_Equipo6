# Postwork de la sesion 2. Manipulación de datos en R

**Contexto:** Nuevamente se toman los datos referentes a equipos de la liga española de futbol.

**Nota:** Nos ahorraremos algunos de los detalles que estuvimos visualizando en el postwork anterior. Sigamos :smile:

1. Importamos los datos de soccer de las temporadas 2017/2018, 2018/2019, 2019/2020 de la primera división de la liga española a R. Disponibles en: https://www.football-data.co.uk/spainm.php
```r
url1 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv" #2017-2018
url2 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv" #2018-2019
url3 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv" #2019-2020

#Descargando todos los archivos
url1 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv"
url2 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
url3 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"
download.file(url = url1, destfile = "Temporada2017-2018.csv", mode = "wb")
download.file(url = url2, destfile = "Temporada2018-2019.csv", mode = "wb")
download.file(url = url3, destfile = "Temporada2019-2020.csv", mode = "wb")

#Almacenando en las variables
datos2017 <- read.csv("Temporada2017-2018.csv")
datos2018 <- read.csv("Temporada2018-2019.csv")
datos2019 <- read.csv("Temporada2019-2020.csv")
```
2. Obteniendo una mejor idea de las características de cada dataframe:
- Con str()
```r
str(datos2017)
str(datos2018)
str(datos2019)
```
Para obtener algo parecido a esto, obviamente más extenso y por cada dataframe:
```r
> str(datos2017)
'data.frame':	380 obs. of  64 variables:
 $ Div       : chr  "SP1" "SP1" "SP1" "SP1" ...
 $ Date      : chr  "18/08/17" "18/08/17" "19/08/17" "19/08/17" ...
 $ HomeTeam  : chr  "Leganes" "Valencia" "Celta" "Girona" ...
 $ AwayTeam  : chr  "Alaves" "Las Palmas" "Sociedad" "Ath Madrid" ...
 $ FTHG      : int  1 1 2 2 1 0 2 0 1 0 ...
 ...
```
- Con head() y tail()
```r
head(datos2017); tail(datos2017)
head(datos2018); tail(datos2018)
head(datos2019); tail(datos2019)
```
Para obtener algo parecido a esto, obviamente más extenso y por cada dataframe:
```r
> head(datos2017); tail(datos2017)
  Div     Date   HomeTeam   AwayTeam FTHG FTAG FTR HTHG HTAG HTR HS AS HST AST HF AF HC AC HY AY HR AR B365H B365D B365A
1 SP1 18/08/17    Leganes     Alaves    1    0   H    1    0   H 16  6   9   3 14 18  4  2  0  1  0  0  2.05  3.20  4.10
2 SP1 18/08/17   Valencia Las Palmas    1    0   H    1    0   H 22  5   6   4 25 13  5  2  3  3  0  1  1.75  3.80  4.50
3 SP1 19/08/17      Celta   Sociedad    2    3   A    1    1   D 16 13   5   6 12 11  5  4  3  1  0  0  2.38  3.25  3.20
4 SP1 19/08/17     Girona Ath Madrid    2    2   D    2    0   H 13  9   6   3 15 15  6  0  2  4  0  1  8.00  4.33  1.45
5 SP1 19/08/17    Sevilla    Espanol    1    1   D    1    1   D  9  9   4   6 14 12  7  3  2  4  1  0  1.62  4.00  5.50
6 SP1 20/08/17 Ath Bilbao     Getafe    0    0   D    0    0   D 12  8   2   2 16 15  7  6  1  3  0  1  1.50  4.00  7.50
...
 Div     Date   HomeTeam    AwayTeam FTHG FTAG FTR HTHG HTAG HTR HS AS HST AST HF AF HC AC HY AY HR AR B365H B365D
375 SP1 19/05/18    Sevilla      Alaves    1    0   H    1    0   H 20 10   8   4 15 12  8  3  2  2  0  0  1.40  4.75
376 SP1 19/05/18 Villarreal Real Madrid    2    2   D    0    2   A 14 15   5   7 13 10  4  5  4  3  0  0  3.10  4.10
377 SP1 20/05/18 Ath Bilbao     Espanol    0    1   A    0    1   A 12 11   3   4  4 11  7  7  0  1  0  0  2.04  3.50
378 SP1 20/05/18 Ath Madrid       Eibar    2    2   D    1    1   D  8 14   4   3 14 14  2  2  6  2  1  0  1.61  3.80
379 SP1 20/05/18  Barcelona    Sociedad    1    0   H    0    0   D 12 13   4   2 13 13  3  8  3  2  0  0  1.22  7.00
380 SP1 20/05/18   Valencia   La Coruna    2    1   H    1    0   H 22 12   5   7  8 11  8  4  0  0  0  0  1.40  4.75
...
```
- Con view()
```r
View(datos2017)
View(datos2018)
View(datos2019)
```
Para obtener algo parecido a esto, obviamente más extenso y por cada dataframe:
![alt text](https://github.com/CrisTafRos/Postworks_Equipo6/raw/main/postwork_2/view(datos2017).JPG)
- Con summary()
```r
summary(datos2017)
summary(datos2018)
summary(datos2019)
```
Para obtener algo parecido a esto, obviamente más extenso y por cada dataframe:
```r
> summary(datos2017)
     Div                Date             HomeTeam        
 Length:380         Length:380         Length:380        
 Class :character   Class :character   Class :character  
 Mode  :character   Mode  :character   Mode  :character  
 ...
```

3. Extrayendo Date, HomeTeam, AwayTeam, FTHG, FTAG y FTR, y 4. Asegurando que tenga los mismos tipos y cambiando formato de fechas
```r
suppressPackageStartupMessages(library(dplyr)) #select no sirve sin dplyr

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

```
Tomando el ejemplo de datos2017, tenemos un **Antes**:
```r
> str(datos2017)
'data.frame':	380 obs. of  6 variables:
 $ Date    : Date, format: "2017-08-18" "2017-08-18" ...
 $ HomeTeam: chr  "Leganes" "Valencia" "Celta" "Girona" ...
 $ AwayTeam: chr  "Alaves" "Las Palmas" "Sociedad" "Ath Madrid" ...
 $ FTHG    : int  1 1 2 2 1 0 2 0 1 0 ...
 $ FTAG    : int  0 0 3 2 1 0 0 3 0 1 ...
 $ FTR     : chr  "H" "H" "A" "D" ...
```
Y un **después**:
```r
> str(datos2017)
'data.frame':	380 obs. of  6 variables:
 $ Date    : Date, format: "2017-08-18" "2017-08-18" ...
 $ HomeTeam: chr  "Leganes" "Valencia" "Celta" "Girona" ...
 $ AwayTeam: chr  "Alaves" "Las Palmas" "Sociedad" "Ath Madrid" ...
 $ FTHG    : int  1 1 2 2 1 0 2 0 1 0 ...
 $ FTAG    : int  0 0 3 2 1 0 0 3 0 1 ...
 $ FTR     : chr  "H" "H" "A" "D" ...
```

Únicamente falta que apliquenos rbind para acumular todos los dataframes.
```r
datos <- rbind(datos2017, datos2018, datos2019)
```
Aplicaremos head y tail para confirmar dicho cambio
```r
> head(datos);tail(datos)
  FTHG FTAG
1    1    0
2    1    3
3    1    1
4    2    1
5    0    1
6    4    4
    FTHG FTAG
375    0    0
376    4    0
377    2    2
378    1    0
379    2    2
380    1    0
```

[Postwork Anterior](https://github.com/CrisTafRos/Postworks_Equipo6/tree/main/postwork_1) | [Postwork Siguiente](https://github.com/CrisTafRos/Postworks_Equipo6/tree/main/postwork_3) 
