library(shiny)
ui <- fluidPage(
  titlePanel("BMI "),
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