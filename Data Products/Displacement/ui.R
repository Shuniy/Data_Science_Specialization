#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
shinyUI(fluidPage(
    titlePanel("Predict Displacement"),
    sidebarLayout(
        sidebarPanel(
            
            sliderInput("sliderHP", "What is the Horsepower of the car?",
                        min = min(mtcars$hp), max = max(mtcars$hp), value = 20),
            
            sliderInput("sliderCarb", "Number of Carborators in the car?",
                        min = min(mtcars$carb), max = max(mtcars$carb), value = 2),
            
            sliderInput("sliderWt", "What is the Weigth of the car?",
                        min = min(mtcars$wt), max = max(mtcars$wt), value = 2),
            
            checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
            checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE),
            checkboxInput("showModel3", "Show/Hide Model 3", value = TRUE),
        
            h4("Predicted Displacement from Model 1:"),
            textOutput("pred1"),
            h4("Predicted Displacement from Model 2:"),
            textOutput("pred2"),
            h4("Predicted Displacement from Model 3:"),
            textOutput("pred3")
        ),
        
        mainPanel(
            tabsetPanel(type = "tabs",
            
            tabPanel("Plots", br(), plotOutput("plot1"), plotOutput("plot2"),
            plotOutput("plot3")),
            
            tabPanel("Documentation", textOutput("Documentation"))
        )
    )
)))
