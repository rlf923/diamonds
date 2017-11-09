##Gui=graphic user interface, can search shiny widgets to get more guis

library(shiny)
library(ggplot2)
##need to do things for server and ui, skeleton of any shiny app

#user interface

ui <- fluidPage(
  titlePanel("Diamonds Data", windowTitle = "Diamonds"),
  sidebarLayout(
    sidebarPanel(
      helpText("This app is to visualize diamonds dataset"),
      textInput(inputId = "title", 
                label = "Chart Title", 
                value = ""),#need to put id for object so it knows what its connected to, input so takes input from the user
    selectInput(inputId = "pos",
                label = "Position",
                choices = list("stack", "dodge"),
                selected = "stack")##creates drop down on side panel
     
     ),
    mainPanel(
      plotOutput(outputId = "plot")##this output is a plot
    )
  )
  
)#fluidpage adapts to different sized windows, each argument controls widget on user interface

#server

server <- function(input, output){
  
  output$plot = renderPlot(  ##assigning it to area based on id
 ggplot(diamonds, aes(x = cut, fill = clarity)) +
    geom_bar(position = input$pos) +#server created plot but didnt return plot back to us(without render function), called rendering to get plot
  ggtitle(input$title) ##connects the input to the graph to make it interactive
   
   )
}

#need code to run app
shinyApp(ui, server)