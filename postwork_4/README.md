# Postwork de la sesion 4. Algunas distribuciones, teorema central del límite y contraste de hipótesis.

**Contexto:** Nuevamente se toman los datos referentes a equipos de la liga española de futbol.

**Nota:** Nos ahorraremos algunos de los detalles que estuvimos visualizando en el postwork anterior. Sigamos :smile:

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
- Probabilidades marginales de que el equipo de casa anote X=x goles (x=0,1,... ,8).
```r
casaanote<-table(LIGAESP$FTHG)
x<-prop.table(casaanote)
x
```
Teniendo la siguiente salida:
```r
> x
          0           1           2           3           4           5           6           7           8 
0.232456140 0.327192982 0.266666667 0.112280702 0.035087719 0.019298246 0.005263158 0.000877193 0.000877193 
```
- Probabilidades marginales y el equipo visitante anote Y=y goles (y=0,1,... ,6), en un partido.
```r
visitaanote<-table(LIGAESP$FTAG)
y<-prop.table(visitaanote)
y
```
Teniendo la siguiente salida:
```r
> y
          0           1           2           3           4           5           6 
0.351754386 0.340350877 0.212280702 0.054385965 0.028947368 0.009649123 0.002631579 
```
- Probabilidades conjuntas de que el equipo de casa anote X=x goles y el equipo visitante anote Y=y goles en un partido.
```r
conjunta<-table(LIGAESP$FTHG,LIGAESP$FTAG)
xy<-prop.table(conjunta)
xy
```
- Tabla de cocientes al dividir estas probabilidades conjuntas por el producto de las probabilidades marginales correspondientes.
```r
k<-1
co<-(x[1]*y[1])/xy[1,1]
for(i in 1:9) {
  for(j in 1:7){
    co[k]<-(x[i]*y[j])/xy[i,j]
    k=k+1
  }
}
```
- Convirtiendo el cociente a data frame
```r
str(co)
coci<-data.frame(co)
coci
```

Mediante un procedimiento de boostrap, obt?n m?s cocientes similares a los 
#obtenidos en la tabla del punto anterior. Esto para tener una idea de las distribuciones
#de la cual vienen los cocientes en la tabla anterior. Menciona en cu?les casos le parece
#razonable suponer que los cocientes de la tabla en el punto 1, son iguales a 1 (en tal caso tendr?amos independencia de las variables aleatorias X y Y).

```r
library(rsample)
#install.packages("rsample")
coci2<-bootstraps(coci, times = 63)
coci2
```
Obteniendo la siguiente salida:
```r
> coci2
# Bootstrap sampling 
# A tibble: 63 x 2
   splits        id         
   <list>        <chr>      
 1 <split [1/0]> Bootstrap01
 2 <split [1/0]> Bootstrap02
 3 <split [1/0]> Bootstrap03
 4 <split [1/0]> Bootstrap04
 5 <split [1/0]> Bootstrap05
 6 <split [1/0]> Bootstrap06
 7 <split [1/0]> Bootstrap07
 8 <split [1/0]> Bootstrap08
 9 <split [1/0]> Bootstrap09
10 <split [1/0]> Bootstrap10
# ... with 53 more rows
```
boostrap<-coci2$splits[[1]]
boostrap
```
Obteniendo la siguiente salida:
```r
> boostrap
<Analysis/Assess/Total>
<1/0/1>
```

[Postwork Anterior](https://github.com/CrisTafRos/Postworks_Equipo6/tree/main/postwork_3) | [Postwork Siguiente](https://github.com/CrisTafRos/Postworks_Equipo6/tree/main/postwork_5) 

