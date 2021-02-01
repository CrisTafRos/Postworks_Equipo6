# Postwork de la sesion 5. Regresión lineal y clasificación.

**Contexto:** Nuevamente se toman los datos referentes a equipos de la liga española de futbol.

**Nota:** Nos ahorraremos algunos de los detalles que estuvimos visualizando en el postwork anterior. Sigamos :smile:
Seleccionamos las columnas con las que se trabajará y se analiza el df (se hace lo mismo con los otros df).
```r
datos2017 <- select(datos2017, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)
str(datos2017)

datos2018 <- select(datos2018, Date, HomeTeam, AwayTeam, FTHG, FTAG)
str(datos2018)
 
datos2019 <- select(datos2019, Date, HomeTeam, AwayTeam, FTHG, FTAG)
str(datos2019)
```
Agruparemos los dataframes:
```r
SmallData <- rbind(datos2017, datos2018, datos2019)
# Se ven los primeros y últimos datos
head(datos);tail(datos)
```
Renombramos las columnas:
```r
SmallData <- SmallData %>%
  rename(date = Date, home.team = HomeTeam, home.score = FTHG, away.team = AwayTeam, away.score = FTAG)
```
Se crea un csv con los datos de las temporadas y se guarda en el directorio de trabajo:
```r
write.csv(SmallData, file = "soccer.csv")
```
Con la función create.fbRanks.dataframes del paquete fbRanks importamos el archivo soccer.csv 
```r
listasoccer <- create.fbRanks.dataframes("soccer.csv")
head(listasoccer)
```
Podremos visualizar la siguiente información:
```r
> head(listasoccer)
$scores
      x       date   home.team   away.team home.score away.score
1     1 2017-08-18     Leganes      Alaves          1          0 
2     2 2017-08-18    Valencia  Las Palmas          1          0 
3     3 2017-08-19       Celta    Sociedad          2          3 
4     4 2017-08-19      Girona  Ath Madrid          2          2 
5     5 2017-08-19     Sevilla     Espanol          1          1 
6     6 2017-08-20  Ath Bilbao      Getafe          0          0 
...

$raw.scores
      x       date   home.team   away.team home.score away.score 
1     1 2017-08-18     Leganes      Alaves          1          0 
2     2 2017-08-18    Valencia  Las Palmas          1          0 
3     3 2017-08-19       Celta    Sociedad          2          3 
4     4 2017-08-19      Girona  Ath Madrid          2          2 
5     5 2017-08-19     Sevilla     Espanol          1          1 
6     6 2017-08-20  Ath Bilbao      Getafe          0          0 
...

$teams
          name
1       Alaves
2   Ath Bilbao
3   Ath Madrid
4    Barcelona
5        Betis
6        Celta
...

$team.resolver
          name    alt.name
1       Alaves      Alaves
2   Ath Bilbao  Ath Bilbao
3   Ath Madrid  Ath Madrid
4    Barcelona   Barcelona
5        Betis       Betis
6        Celta       Celta
...

$updated
[1] FALSE

$ok
[1] TRUE
```

Creamos una lista con los elementos scores y teams para la función rank.teams
```r
anotaciones <- listasoccer$scores
equipos <- listasoccer$teams

str(anotaciones)
str(equipos)
```
Creamos un vector de fechas, ordenamos de menor a mayor y buscamos la primera y última fehca
```r
fecha <- unique(anotaciones$date)

sort(fecha, decreasing = F)
min.fecha <- fecha[1]; max.fecha <- fecha[length(fecha)]
```
Establecemos el ranking con los datos obtenidos:
```r
ranking <- rank.teams(anotaciones, equipos, max.date = max.fecha, min.date = min.fecha)
```
Donde podremos ver lo siguiente:
```r
> ranking <- rank.teams(anotaciones, equipos, max.date = max.fecha, min.date = min.fecha)

Team Rankings based on matches 2017-08-18 to 2020-12-23
   team        total attack defense n.games.Var1 n.games.Freq
1  Barcelona    1.54 2.25   1.29    Barcelona    114         
2  Ath Madrid   1.24 1.33   1.78    Ath Madrid   114         
3  Real Madrid  1.13 1.86   1.18    Real Madrid  114         
4  Valencia     0.55 1.33   1.10    Valencia     114         
5  Getafe       0.53 1.09   1.33    Getafe       114         
6  Granada      0.48 1.33   1.05    Granada       38        
...
```
Predecimos los posibles resultados
```r
predict(ranking, date = as.Date(max.fecha))
```
Y obtenemos el siguiente resultado:
```r
> predict(ranking, date = as.Date(max.fecha))
Predicted Match Results for 1900-05-01 to 2100-06-01
Model based on data from 2017-08-18 to 2020-12-23
---------------------------------------------
2020-12-23 Leganes vs Sevilla, HW 22%, AW 50%, T 27%, pred score 0.8-1.4  actual: T (1-1)
2020-12-23 Valencia vs Huesca, HW 57%, AW 20%, T 23%, pred score 1.8-1  actual: HW (2-1)
2020-12-23 Vallecano vs Levante, HW 27%, AW 50%, T 22%, pred score 1.3-1.9  actual: HW (2-1)
```

[Postwork Anterior](https://github.com/CrisTafRos/Postworks_Equipo6/tree/main/postwork_4) | [Postwork Siguiente](https://github.com/CrisTafRos/Postworks_Equipo6/tree/main/postwork_6) 
