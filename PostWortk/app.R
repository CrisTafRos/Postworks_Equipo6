
library(shiny)
library(dplyr)
library(ggplot2)

ui <- fluidPage(
    
    titlePanel("Post Work Sesión 8"),
    sidebarPanel(
        p("Goles anotados"), 
        selectInput("x", "Selección del Local/Visitante", 
                    c("Local", "Visitante"))
    ),

    mainPanel(
           
            tabsetPanel(
                tabPanel("Plots",
                         h3(textOutput("output_text")), 
                         plotOutput("output_plot"),
                ),
                
                tabPanel("Gráficas de goles",
                         img( src = "goles_casa.png", height = 386, width = 550),
                         img( src = "goles_visitante.png", height = 386, width = 550),
                         img( src = "heatmap.png", height = 386, width = 550)
                ),
                
                tabPanel("Data Table", dataTableOutput("data_table")),
                
                tabPanel("Factores de ganancias", 
                         img( src = "grafico1.png", height = 386, width = 550),
                         img( src = "grafico2.png", height = 386, width = 550)
                         
                )
            )
        )
)


server <- function(input, output) {
    
    match.data <- read.csv("match.data.csv")
    
    output$output_text <- renderText(paste("Goles del equipo ", input$x, " agrupado por visitante"))

    output$output_plot <- renderPlot({
        if (input$x == "Local") {
            ggplot(match.data, aes(home.score)) + geom_bar() + facet_wrap(~ away.team) +
                xlab(paste("Goles por partido del equipo ", input$x)) +
                ylab("Total de goles")
        }
        else{
            ggplot(match.data, aes(away.score)) + geom_bar() + facet_wrap(~ away.team) +
                xlab(paste("Goles por partido del equipo ", input$x)) +
                ylab("Total de goles")
        }
            
    })
    
    # output$output_plot <- renderPlot(plot(data = match.data, as.formula(input$x)) 
    #                                    )
     
    output$data_table <- renderDataTable({match.data}, 
                                         options = list(aLengthMenu = c(25,50,100),
                                                        iDisplayLength = 25))

}

shinyApp(ui = ui, server = server)
