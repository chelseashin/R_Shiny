library(shiny)

server <- function(input, output) {
  bmi_calc <- function(weight, height) (weight/(height/100)^2)
  output$inputValue1 <- renderPrint({input$wt})
  output$inputValue2 <- renderPrint({input$ht})
  output$results <- renderPrint({bmi_calc(input$wt, input$ht)})
}