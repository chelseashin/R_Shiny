library(shiny)
# 위젯 ui

ui <- fluidPage(
  titlePanel("Make a Histogram"),
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Select your file"),
      checkboxInput(inputId = 'header', 
                    label = 'header', 
                    value = TRUE),
      radioButtons('sep', 'Separator', c(Comma=',', Semicolon=';', Tab='\t'), ','),
      selectInput("combobox", label = h3("column for histogram"), choices = NULL),
      sliderInput("bins", "Number of bins:", min=1, max=50, value=30),
      radioButtons('color', 'Select Color', choices=c("blue", "gray", "black"), "blue"),
      # 파일 다운로드 버튼 생성
      downloadButton(outputId = "download", label = "Download the histogram")
    ),
    
    mainPanel(
      uiOutput("tb")
    )
  )
)

server <- function(input, output, session) {
  data <- reactive({
    file1 <- input$file
    if(is.null(file1)){return()}
    dataSet <- read.csv(file=file1$datapath, sep=input$sep, header=input$header)
    
    updateSelectInput(session, "combobox", choices = colnames(dataSet))
    dataSet
  })
  output$table <- renderTable({
    if(is.null(data())) {return ()}
    data()
  })
  output$histogram <- renderPlot({
    x <- data()[, input$combobox]
    hist(x , col= 'blue', border= 'white')
  })
  
  output$tb <- renderUI({
    if(is.null(data()))
      h5("No Abvailable data yet.")
    else
      tabsetPanel(tabPanel("data", tableOutput("table")), tabPanel("Histogram", plotOutput("histogram")))
  })
  # 파일 다운로드 함수(pdf파일로 다운 받을 수 있도록 )
  output$download <- downloadHandler(
    filename = function(){paste("histogram_", input$combobox,".pdf", sep="")},
    content = function(file){
      pdf(file)
      x <- data()[, input$combobox]
      hist(x, breaks = input$bins, col = input$color, border = 'white')
      dev.off()
    }
  )
}
shinyApp(ui = ui, server = server)