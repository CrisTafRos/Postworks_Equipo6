# Postwork de la sesion 8. Dashboards con Shiny - Entorno GUI.

**Contexto:** Utilizamos las imágenes generadas desde momios.R y el documento match.data.csv para generar nuestro dashboard.

Primero, una previsualización del resultado final :smile::

![alt text](https://github.com/CrisTafRos/Postworks_Equipo6/raw/main/postwork_8/preview_1.JPG)

1. Para mostrar los gráficos de barras:

```r
    titlePanel("Post Work Sesión 8"),
    sidebarPanel(
        p("Goles anotados"), 
        selectInput("x", "Selección del Local/Visitante", 
                    c("Local", "Visitante"))
    ),
```
2. Para las gráficas de goles:
```r
    tabsetPanel(
                tabPanel("Plots",
                         h3(textOutput("output_text")), 
                         plotOutput("output_plot"),
                ),
```
3. Data Table:
```r
tabPanel("Data Table", dataTableOutput("data_table")),
```
4. Factores de ganancia:
```r
                tabPanel("Factores de ganancias", 
                         img( src = "grafico1.png", height = 386, width = 550),
                         img( src = "grafico2.png", height = 386, width = 550)
                         
                )
```


[Postwork Anterior](https://github.com/CrisTafRos/Postworks_Equipo6/tree/main/postwork_7) | [Listado de postworks](https://github.com/CrisTafRos/Postworks_Equipo6) 
