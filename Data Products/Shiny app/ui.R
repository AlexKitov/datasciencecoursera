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
                        "Exploration", icon = icon("bar-chart-o"),
                        sidebarLayout(sidebarPanel(
                                width = 3,
                                radioButtons("explore", "Choose exploration type: ",
                                             choices = c( "summary", "histogram", "scatter plot")),
                                
                                conditionalPanel(condition = "input.explore == 'histogram'",
                                                 selectInput("hist_var", "Variable", choices=choices(movies)),
                                                 sliderInput(
                                                         "hist_max",
                                                         "Value range:",
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
                
                tabPanel("Prediction", icon = icon("area-chart")
                
                ),
                
                tabPanel("Help", icon = icon("leaf"),
                    column(width = 6, offset = 3,
                        wellPanel(
                                h1("Movies Analysis"), 
                                br(),
                                h3("Summary"),
                                p('The aim of this app is to analyse movies data set provided in "ggplot2"'),
                                
                                h3("User guide"),
                                p('This app aims to give the maximum amount of freedom to the user in \
                                  order to allow for fast and comprehensive data analysis and taking \
                                  decisions in building prediction algorithms. The app cosist of 3 tabPanels\
                                  "Exploration", "Prediction" and "Help" respectively shown in the top \
                                  navigation bar of the app'),
                                br(),
                                h4('Explorration'),
                                p('In this section the user is givne the opportunity to produce multiple\
                                   charts and plots in orther to better understand the "movies" dataset.\
                                   There are tree possible options in the left sidebar panel.'),
                                br(),
                                h5('Summary'),
                                p('The "Summary" option simply calls standart R `summary()` function \
                                   and shows the result in a table. Since the table is wider than\
                                   the screen user have a vertical scrol to see all variables summaries.'),
                                br(),
                                h5('Histogram'),
                                p('In histogram option the user can choose a variable from the data set\
                                   for which a histogram will be drawn in hte main panel of the window.\
                                   Aditionally the user can choose the range of the variable\
                                   which allows for exploration of highly skiewed variables.\
                                   The number of bins is also adjustable trough the bottom slider.'),
                                p('The user is allowed to choose only among the numeric variables\
                                   in the dataset, since drawing histogram for character or factor\
                                   variables does not make sence.'),
                                br(),
                                h5('Scatter plot'),
                                p('In this exploratory option the user can look for trends and correlation\
                                   among the variables. Selectable values are the "X-axis" variable,\
                                   the "Y-axis" variavble and the variable which will be used to used to\
                                   collor the dots on the plot. Additionaly, the range on the x-axis is\
                                   adjustable trough the slider at the bottom of the side pannel.'),
                                p('All variables are available to be chosen in and in case a character \
                                  or factor variable is chosen for "X-axis" variable the range slider is inactive.'),
                                br(),
                                h4('Prediction'),
                                p('Due to limited time this section is still under development.')
                        )
                    )
                )
        )
)

