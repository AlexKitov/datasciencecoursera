library(ggplot2)
library(rCharts)
library(shiny)
library(dplyr)

data(movies)


choices <- function(df = data.frame()){
        sel <- sapply(names(df), function(x){is.numeric(df[,x])})
        names(df[, sel])
}


shinyUI(
        navbarPage(
                "Movies", footer = column(12, "® Aleksandar Kittov 2015", style = "text-align: center;"),
                collapsible = T, windowTitle = "Movies analysis", theme = "bootstrap.css",
                tabPanel(
                        "Exploratory", icon = icon("bar-chart-o"),
                        sidebarLayout(sidebarPanel(
                                width = 3,
                                radioButtons("explore", "Choose exploratoray type: ",choices = c( "summary", "histogram", "scatter plot")),
                                
                                conditionalPanel(condition = "input.explore == 'histogram'",
                                                 selectInput("hist_var", "Variable", choices=choices(movies)),
                                                 sliderInput(
                                                         "hist_max",
                                                         "Maximum value:",
                                                         min = min(movies$year, na.rm = T),
                                                         max = max(movies$year, na.rm = T),
                                                         value = c(   min(movies$year, na.rm = T),
                                                                      max(movies$year, na.rm = T))
                                                 ),
                                                 sliderInput(
                                                         "bin.nums",
                                                         "Number of bins:",
                                                         min = 5,
                                                         max = 100,
                                                         value = 10
                                                 ),
                                                 actionButton("view_hist", "View", value = 0, icon("search"))),
                                
                                conditionalPanel(condition = "input.explore == 'scatter plot'",
                                                 selectInput("x_axis", "X axis variable", choices=names(movies)),
                                                 selectInput("y_axis", "Y axis variable", choices=names(movies)),
                                                 selectInput("color_by", "Colour by:", choices=names(movies)),
                                                 sliderInput(
                                                         "scat_range",
                                                         "Title range:",
                                                         min = min(movies$year, na.rm = T),
                                                         max = max(movies$year, na.rm = T),
                                                         value = c(   min(movies$year, na.rm = T),
                                                                      max(movies$year, na.rm = T))
                                                 ),
                                                 actionButton("view_scat", "View", value = 0, icon("search")))
                        ),
                        
                        # Show a plot of the generated distribution
                        mainPanel(
                                uiOutput("explorer.main.Panel")
                        )
                        )
                ),
                tabPanel("Prediction")
        )
)

