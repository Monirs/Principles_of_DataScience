library(shiny)


# Define UI for dataset viewer application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Food Value on your click"),
  
  # Sidebar with controls to select a dataset and specify the number
  # of observations to view
  sidebarPanel(
    width = 3,
    selectInput("dataset1", "Choose a Food Type:", 
                choices = c("RICE","BEEF","CHEESE", "BUTTER","FLOUR","OIL")),
    selectInput("dataset2", " Nutrient Type 1:", 
                choices = c("Energy","Protein","Carbohydrate")),
    selectInput("dataset3", " Nutrient Type 2:", 
                choices = c( "Sugar","Cholesterol","Fat")),
    selectInput("dataset4", " View Type:", 
                choices = c("Horizontal","Vertical"))
    
    #numericInput("obs", "Customize your observation Table:", 5)
  ),
  
  # Show a summary of the dataset and an HTML table with the requested
  # number of observations
  #mainPanel(
   # plotOutput("view"),
    #verbatimTextOutput("summary")
    #tableOutput("table")
    
 # )
  mainPanel(
  
      tags$style(HTML("
                      .tabs-above > .nav > li[class=active] > a {
                      background-color: #000;
                      color: #FFF;
                      }")),
    # Output: Tabset w/ plot, summary, and table ----
    tabsetPanel(type = "tabs",
                tabPanel("Plot", plotOutput("view")),
                tabPanel("Data", tableOutput("table")),
                tabPanel("Summary", verbatimTextOutput("summary"))
    )
  )
))
