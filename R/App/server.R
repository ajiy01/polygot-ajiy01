#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(tidyverse)
library(shiny)


shinyServer(function(input, output,session) {
    
    bb = read.csv("data/bb_data.csv")
    
    #User Input on Team Selected
    data <- reactive({
      req(input$team)
      df <- bb %>% filter(Tm %in% input$team) %>% group_by(Age) %>% summarise(FG = sum(FG))
    })
    
    #Team select
    observe({
      updateSelectInput(session, "team", choices = bb$Tm)
    })
    
    #Plot FG vs Age
    output$Age_FG <- renderPlot({
      ggplot(data(), aes(y = FG, x=Age)) + geom_bar(stat="sum", color="black", fill="blue") + ggtitle("Average Field Goals by Age")
    })
    
    #Download Button
    output$down <- downloadHandler(
      filename=function(){
        paste("bbgraph", input$dload, sep=".")
      }, 
      content=function(file){
        if(input$dload == "png")
          png(file)
        else if(input$dload == "pdf")
          pdf(file)
        else
          jpeg(file)
        print(ggplot(data(), aes(y = FG, x=Age)) +geom_bar(stat="sum", color="black", fill="blue") + ggtitle("Average Field Goals by Age"))
        dev.off()
      }
    )
})
