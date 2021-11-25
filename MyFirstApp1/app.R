library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  titlePanel("Simple Age & Retirement Calculator Apps"),
  
  h3("Welcome to My First Shiny App"),
  
  tags$img(src='download.jpeg'),
  
  h6("In this project, I like to display a simple application to calculate our age and our remaining years before retirement."),
  
  textInput(inputId = "name", label = "What's you name?"),
  textOutput(outputId = "greeting"),
  
  h3("Feel Free to Play!!!"),
  
  sidebarLayout(
    sidebarPanel(
      dateInput (inputId = "dob", label="DATE OF BIRTH: ",
                 min = "1960-01-01",
                 max = Sys.Date(), format = "yyyy-mm-dd", 
                 startview = "year",
                 weekstart = 0, language = "en"),
      dateInput(inputId = "dot", label="DATE OF TODAY: ",
                min = "1960-01-01",
                max = Sys.Date(), format = "yyyy-mm-dd", 
                startview = "year",
                weekstart = 0, language = "en"),
      numericInput( "retAge", "Retirement Age:", 65, min=55, max = 70)
    ),
    
    mainPanel(
      
      tags$img(src='bright_side.jpeg'),
      
      h3 ("Your Age is :"),
      textOutput ("Age"),
      
      h3 ("Your Monthly Age is :"),
      textOutput ("MonthlyAge"),
      
      h3 ("Your Daily Age is :"),
      textOutput ("DailyAge"),
      
      h3 ("Years left for Retirement"),
      textOutput("Ret")
    )
    
  )
)


# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$greeting <- renderText(
    paste0(input$name, " Enjoy!."))
  
  Age <- reactive({
    Age <- as.integer((as.Date(input$dot)- as.Date(input$dob))/365)
    print(Age)
  })
  
  MonthlyAge <- reactive({
    MonthlyAge <- as.integer(((as.Date(input$dot)- as.Date(input$dob))/30))
    print(MonthlyAge)
  })
  
  DailyAge <- reactive({
    DailyAge <- as.integer((as.Date(input$dot)- as.Date(input$dob)))
    print(DailyAge)
  })
  
  Ret <- reactive({
    ToRet <- input$retAge - as.integer((as.Date(Sys.Date())- as.Date(input$dob))/365)
    print(ToRet)  
  })
  
  output$Age <- renderText(Age()) 
  output$MonthlyAge <- renderText(MonthlyAge())
  output$DailyAge <- renderText(DailyAge())  
  output$Ret <- renderText(Ret()) 
  
}


# Run the application 
shinyApp(ui = ui, server = server)

