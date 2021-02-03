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
Y obteniendo este resultado:
```r
> str(co)
 Named num [1:63] 1.047 0.98 1.082 0.686 1.279 ...
 - attr(*, "names")= chr [1:63] "0" "" "" "" ...
 
 > coci
          co
1  1.0473586
2  0.9803585
3  1.0818151
4  0.6862991
5  1.2785088
...
```
Mediante un procedimiento de boostrap, obtenemos más cocientes similares a los obtenidos previamiente. Esto nos dará una idea de las distribuciones de la cual vienen los cocientes en la tabla anterior. 

```r
library(rsample)

install.packages("rsample")
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
Continuando con las siguientes sentencias:
```r
boostrap<-coci2$splits[[1]]
boostrap
```
Obteniendo la siguiente salida:
```r
> boostrap
<Analysis/Assess/Total>
<1/0/1>
```
Lo convertimos en un dataframe:
```r
cociboostrap<-as.data.frame(boostrap)
str(cociboostrap)
```
Y comprobamos:
```r
> str(cociboostrap)
'data.frame':	63 obs. of  1 variable:
 $ co: num  1.279 0.289 Inf Inf Inf ...
```
Ordenamos:
```r
cociboostrap<-sort(cociboostrap$co)
cociboostrap
```
Y comprobamos:
```r
> cociboostrap
 [1] 0.2122807 0.2122807 0.2894737 0.2894737 0.3403509 0.4000000 0.4000000
 [8] 0.5114035 0.5114035 0.6368421 0.7035088 0.7035088 0.7738596 0.8793860
[15] 0.8800000 0.8828345 0.9219048 0.9669782 0.9690907 0.9690907 0.9704261
[22] 0.9939726 0.9939726 1.0142982 1.0151372 1.0614035 1.0614035 1.0614035
[29] 1.0693333 1.0797368 1.0818151 1.1774301 1.1774301 1.2717949 1.2717949
[36] 1.2785088 1.2785088 1.2785088 1.4666667 1.8526316       Inf       Inf
[43]       Inf       Inf       Inf       Inf       Inf       Inf       Inf
[50]       Inf       Inf       Inf       Inf       Inf       Inf       Inf
[57]       Inf       Inf       Inf       Inf       Inf       Inf       Inf
```
Ordenamos por co, unimos ambos dataframes, cambiamos los nombres:
```r
coci<-sort(coci$co)
(df2 <- cbind(coci,cociboostrap))
(names(df2) <- c("valores", "cocientes", "bootstraps"))
```
Damos formato a nuestro dataframe y lo visualizamos:
```r
suppressMessages(suppressWarnings(library(reshape2)))
(df2 <- melt(df2)) # funci?n del paquete reshape2
df2
```
Así:
```r
> (df2 <- melt(df2)) # funci?n del paquete reshape2
    Var1         Var2     value
1      1         coci 0.2122807
2      2         coci 0.2894737
3      3         coci 0.3263158
4      4         coci 0.3368421
...
64     1 cociboostrap 0.2122807
65     2 cociboostrap 0.2122807
66     3 cociboostrap 0.2894737
67     4 cociboostrap 0.2894737
...
```
Percibimos que las frecuencias relativas son parecidas a las probabilidades
```r
library(ggplot2)
ggplot(df2, aes(x = Var1 , y = value, fill = Var2)) + 
  geom_bar (stat="identity", position = "dodge") # Funciones del paquete ggplot2
```
Y la gráfica generada es la siguiente:

![alt text](https://github.com/CrisTafRos/Postworks_Equipo6/raw/main/postwork_4/cociVScocibootstrap.jpeg)

[Postwork Anterior](https://github.com/CrisTafRos/Postworks_Equipo6/tree/main/postwork_3) | [Postwork Siguiente](https://github.com/CrisTafRos/Postworks_Equipo6/tree/main/postwork_5) 

