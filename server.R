library(shiny)
library(datasets)
library(gridExtra)


# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {
  
  # Return the requested dataset
  datasetInput1 <- reactive({
    switch(input$dataset1,
           "OIL" =df_oil,
           "RICE"=df_rice,
           "FLOUR" =df_flour,
           "BEEF" =df_beef,
           "CHEESE" = df_cheese,
           "BUTTER" = df_butter)
  })
  
  datasetInput2 <- reactive({
    switch(input$dataset2,
           "Carbohydrate" = 'Carbohydrt_.g.',
           "Protein" = 'Protein_.g.',
           "Energy" = 'Energy_Kcal')
  })
  
  datasetInput3 <- reactive({
    switch(input$dataset3,
           "Cholesterol" = 'Cholesterol_.mg.',
           "Sugar" = 'Sugar_Tot_.g.',
           "Fat" = 'FAT_Sat_.g.')
  })
  
  datasetInput4 <- reactive({
    switch(input$dataset4,
           "Vertical" = 2,
           "Horizontal" = 1)
  })
  
  # Generate a summary of the dataset
  output$summary <- renderPrint({
    dataset <- datasetInput1()
    summary(dataset)
  })
  

  
  # Show the first "n" observations
  output$table <- renderTable({
   # head(datasetInput1(), n = input$obs)
     head(datasetInput1(),100)
  })
  

  output$view <- renderPlot({
    
    dataset1 <- datasetInput1()
    dataset2 <- datasetInput2()
    dataset3 <- datasetInput3()
    dataset4 <- datasetInput4()
    
    E1=dataset2
    E2=dataset3
    col1=dataset4
    
    # Variable name for Title
    V = strsplit(E1,"_")
    E1_t=sapply(V,function(x) x[1])
    
    if (E1_t == "Energy"){
      E1_t=paste(E1_t," Ratings(Kcal)")
    }
    else{
      E1_t=paste(E1_t," Ratings(g)")
    }

    
    V = strsplit(E2,"_")
    E2_t=sapply(V,function(x) x[1])
    if (E2_t == "Cholesterol"){
      E2_t=paste(E2_t," Ratings(mg)")
    }
    else{
      E2_t=paste(E2_t," Ratings(g)")
    }

    
    p1 <- ggplot(dataset1, aes(x=dataset1$Shrt_Desc,y=dataset1[,E1], group=1)) +
      geom_bar(stat = "identity", color="black",fill = "#33FF6E")+
      #geom_line(size=1.2, colour="green") +
      geom_point(size=2) +
      ggtitle(E1_t) +
      theme(axis.text=element_text(size=10),
            plot.title = element_text(size=15,face="bold"),
            axis.title=element_text(size=10,face="bold")) + 
      theme(legend.text=element_text(size=5)) + 
      labs(x = "Food", y = "Value") 
    
  

 
   p2 <- ggplot(dataset1, aes(x=dataset1$Shrt_Desc,y=dataset1[,E2],group=1)) +
      geom_bar(stat = "identity", color="black",fill = "#FF7733")+
      #geom_line(size=1.2,colour = 'blue') +
     geom_point(size=2) +
     ggtitle(E2_t) +
     theme(axis.text=element_text(size=10),
           plot.title = element_text(size=15,face="bold"),
           axis.title=element_text(size=10,face="bold")) + 
     theme(legend.text=element_text(size=5)) + 
     expand_limits(x = 0, y = 0) +
     labs(x = "Food", y = "Value") 
 
    
    grid.arrange(p1,p2, ncol=col1)

  })
  
})