# Postwork de la sesion 3. Análisis Exploratorio de Datos (AED o EDA) con R

**Contexto:** Nuevamente se toman los datos referentes a equipos de la liga española de futbol.

**Nota:** Nos ahorraremos algunos de los detalles que estuvimos visualizando en el postwork anterior. Sigamos :smile:

1. Con el último data frame obtenido en el postwork de la sesión 2, elabora tablas de frecuencias relativas para estimar las siguientes probabilidades:

Asegurémonos de que tenemos el dataframe adecuado:
```r
head(LIGAESP)
``
Teniendo la siguiente salida:
```r
        Date   HomeTeam   AwayTeam FTHG FTAG FTR
1 2017-08-18    Leganes     Alaves    1    0   H
2 2017-08-18   Valencia Las Palmas    1    0   H
3 2017-08-19      Celta   Sociedad    2    3   A
4 2017-08-19     Girona Ath Madrid    2    2   D
5 2017-08-19    Sevilla    Espanol    1    1   D
6 2017-08-20 Ath Bilbao     Getafe    0    0   D
```
- Calculando la probabilidad (marginal) de que el equipo que juega en casa anote x goles (x=0,1,2,):
```r
casaanote<-table(LIGAESP$FTHG)
prop.table(casaanote)
```
Teniendo la siguiente salida:
```r
> prop.table(casaanote)

          0           1           2           3           4           5           6           7           8 
0.232456140 0.327192982 0.266666667 0.112280702 0.035087719 0.019298246 0.005263158 0.000877193 0.000877193 
```
- Calculando la probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y=0,1,2,):
```r
visitaanote<-table(LIGAESP$FTAG)
prop.table(visitaanote)
```
Teniendo la siguiente salida:
```r
> prop.table(visitaanote)

          0           1           2           3           4           5           6 
0.351754386 0.340350877 0.212280702 0.054385965 0.028947368 0.009649123 0.002631579 
```
- La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega como visitante anote y goles (x=0,1,2,, y=0,1,2,)
```r
casaanote<-table(LIGAESP$FTHG)
prop.table(casaanote)
```
Teniendo la siguiente salida:
```r
> prop.table(conjunta)
   
              0           1           2           3           4           5           6
  0 0.078070175 0.080701754 0.045614035 0.018421053 0.005263158 0.004385965 0.000000000
  1 0.115789474 0.114912281 0.068421053 0.017543860 0.008771930 0.001754386 0.000000000
  2 0.087719298 0.093859649 0.061403509 0.011403509 0.008771930 0.001754386 0.001754386
  3 0.044736842 0.032456140 0.024561404 0.006140351 0.001754386 0.001754386 0.000877193
  4 0.014035088 0.010526316 0.007017544 0.000000000 0.003508772 0.000000000 0.000000000
  5 0.008771930 0.005263158 0.004385965 0.000000000 0.000877193 0.000000000 0.000000000
  6 0.002631579 0.001754386 0.000000000 0.000877193 0.000000000 0.000000000 0.000000000
  7 0.000000000 0.000877193 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
  8 0.000000000 0.000000000 0.000877193 0.000000000 0.000000000 0.000000000 0.000000000
```

2. Realizando los siguientes gráficos:

- Un gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo de casa.
```r
hist(LIGAESP$FTHG,freq = FALSE,breaks = (seq(0,8, 0.5)),
     main = "Probabilidades marginales estimadas del número de goles que anota el equipo de casa",
     xlab = "goles",
     ylab = "probabilidad")
```
![alt text](https://github.com/CrisTafRos/Postworks_Equipo6/raw/main/postwork_3/prob_marg_home.jpeg)
- Un gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo visitante.
```r
hist(LIGAESP$FTAG,freq = FALSE,breaks = (seq(0,8, 0.5)),
     main = "Probabilidades marginales estimadas del número de goles que anota el equipo visitante",
     xlab = "goles",
     ylab = "probabilidades")
```
![alt text](https://github.com/CrisTafRos/Postworks_Equipo6/raw/main/postwork_3/prob_marg_visita.jpeg)
- Un heatmap para las probabilidades conjuntas estimadas de los números de goles que anotan el equipo de casa y el equipo visitante en un partido.
```r
library(ggplot2)
library(reshape2)

# Recordando la probabilidad conjunta:
conjunta
pro.conjunta<-prop.table(conjunta)
pro.conjunta
```
Donde pro.conjunta se ve de la siguiente forma:
```r
> pro.conjunta
   
              0           1           2           3           4           5           6
  0 0.078070175 0.080701754 0.045614035 0.018421053 0.005263158 0.004385965 0.000000000
  1 0.115789474 0.114912281 0.068421053 0.017543860 0.008771930 0.001754386 0.000000000
  2 0.087719298 0.093859649 0.061403509 0.011403509 0.008771930 0.001754386 0.001754386
  3 0.044736842 0.032456140 0.024561404 0.006140351 0.001754386 0.001754386 0.000877193
  4 0.014035088 0.010526316 0.007017544 0.000000000 0.003508772 0.000000000 0.000000000
  5 0.008771930 0.005263158 0.004385965 0.000000000 0.000877193 0.000000000 0.000000000
  6 0.002631579 0.001754386 0.000000000 0.000877193 0.000000000 0.000000000 0.000000000
  7 0.000000000 0.000877193 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
  8 0.000000000 0.000000000 0.000877193 0.000000000 0.000000000 0.000000000 0.000000000
```
```r
# Adaptando a una tabla
conjunta.m=melt(pro.conjunta)
conjunta.m
```
Donde conjunta.m se ve de la siguiente forma:
```r
> head(conjunta.m)
  Var1 Var2      value
1    0    0 0.07807018
2    1    0 0.11578947
3    2    0 0.08771930
4    3    0 0.04473684
5    4    0 0.01403509
6    5    0 0.00877193
```
```r
# Mostrando el heatmap
ggplot(conjunta.m, aes(x = Var1, y = Var2, fill = value)) + 
        geom_tile() +
        xlab(label = "FTHG") +
        ylab(label = "FTAG") +
        scale_fill_gradient(name = "Probabilidad Conjunta")
```
![alt text](https://github.com/CrisTafRos/Postworks_Equipo6/raw/main/postwork_3/proba_conjunta.jpeg)

[Postwork Anterior](https://github.com/CrisTafRos/Postworks_Equipo6/tree/main/postwork_2) | [Postwork Siguiente](https://github.com/CrisTafRos/Postworks_Equipo6/tree/main/postwork_4) 
