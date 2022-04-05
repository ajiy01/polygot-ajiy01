#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library (tidyverse)
library(shiny)


# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("My First App - 2020-21 NBA Player Stats: Per Game"),

    # Sidebar with a slider input for number of bins
   selectInput(inputId = 'team', label = 'Choose a Team:', 
               "Team"),
   radioButtons(inputId = 'dload', label="Save Graph as", choices=list("png", "pdf", "jpeg")),
   mainPanel(plotOutput('Age_FG'), 
             downloadButton(outputId = "down", label="Download Graph"))
))
