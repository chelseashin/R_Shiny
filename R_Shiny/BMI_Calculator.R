# 서버에 올려서 https://chelseashin.shinyapps.io/bmi_shiny_app/ 에서 확인 가능

library(shiny)
ui <- fluidPage(
  titlePanel("Body Mass Index "),
  sidebarPanel(
    # 숫자 입력 칸 생성
    numericInput('wt', 'Weight in Kg', 70, min = 30, max = 200),
    numericInput('ht', 'Height in cm', 165, min = 50, max = 250),
    submitButton('SUBMIT')
  ),
  mainPanel(
    h3('Results'),
    h4('Fill your Weight'),
    verbatimTextOutput("inputValue1"),
    h4('Fill your Height'),
    verbatimTextOutput("inputValue2"),
    h4('Your BMI is '),
    verbatimTextOutput('results')
  )
)
server <- function(input, output) {
  bmi_calc <- function(weight, height) (weight/(height/100)^2)
  output$inputValue1 <- renderPrint({input$wt})
  output$inputValue2 <- renderPrint({input$ht})
  output$results <- renderPrint({bmi_calc(input$wt, input$ht)})
}
# 실행
shinyApp(ui = ui, server = server)