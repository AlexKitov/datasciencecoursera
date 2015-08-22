library(ggplot2)
library(rCharts)
library(shiny)
library(dplyr)

#data(movies)

shinyServer(function(session, input, output) {
        ################### Dealing with scatter plots
        
        output$summary <- renderTable({
                summary(movies)
        })
        
        # Dealing with histeresis ##################
        output$hist <- 
                renderChart({
                        if(input$view_hist > 0){
                                isolate({
                                        x <- input$hist_var
                                        min <- input$hist_max[1]
                                        max <- input$hist_max[2]
                                        bin.nums <- input$bin.nums
                                        bin_size <- (max - min) / bin.nums
                                        
                                        movies <- movies[ (movies[, x] < max),]
                                        movies <- movies[ (movies[, x] > min),]
                                        rp1 <- rPlot(x = paste("bin(", x,", ", bin_size,")", sep = ""), y = paste("count(", x,")", sep = ""), 
                                                     data = movies, type = "bar")
                                        rp1$guides(
                                                x = list(title = x),
                                                y = list(title = 'Count')
                                        )
                                        rp1$addParams(dom = 'hist')
                                })
                                rp1
                        }
                })
        observeEvent(input$hist_var, {updateSliderInput(session, "hist_max", label = "Maximum value:", 
                                                        min = min(movies[, input$hist_var], na.rm = T),
                                                        max = max(movies[, input$hist_var], na.rm = T),
                                                        value = c(   min(movies[, input$hist_var], na.rm = T),
                                                                     max(movies[, input$hist_var], na.rm = T))
        )})
        
        output$explorer.main.Panel <- renderUI({
                if((input$view_hist > 0 )&& (length(input$view_hist)) && (input$explore == 'histogram')){
                        print("Show hist")
                        return(showOutput("hist", "polycharts"))
                }
                if((input$view_scat > 0 )&& (length(input$view_scat)) && (input$explore == 'scatter plot')){
                        print("Show scat")
                        return(showOutput("scat", "polycharts"))
                }
                if((input$explore == 'summary')){
                        print("Show summary")
                        return(tableOutput("summary"))
                }
        })
        
        ################### Dealing with scatter plots
        
        output$scat <- renderChart({
                if (input$view_scat > 0){
                        isolate({
                                x <- input$x_axis
                                min <- input$scat_range[1]
                                max <- input$scat_range[2]
#                                 bin.nums <- input$bin.nums
#                                 bin_size <- (max - min) / bin.nums
                                
                                movies <- movies[ (movies[, x] < max),]
                                movies <- movies[ (movies[, x] > min),]
                                rp1 <- rPlot(x = input$x_axis, y = input$y_axis, 
                                             data = movies, type = "point", color = input$color_by)
                                rp1$guides(
                                        x = list(title = input$x_axis),
                                        y = list(title = input$y_axis)
                                )
                                #rp1$set(width = 1000, height = 550)
                                rp1$addParams(dom = 'scat')
                                rp1      
                        })    
                }
        })
        
        observeEvent(input$x_axis, {updateSliderInput(session, "scat_range", label = paste(input$x_axis, "range", sep = " "), 
                                                        min = min(movies[, input$x_axis], na.rm = T),
                                                        max = max(movies[, input$x_axis], na.rm = T),
                                                        value = c(   min(movies[, input$x_axis], na.rm = T),
                                                                     max(movies[, input$x_axis], na.rm = T))
        )})
        session$onSessionEnded(function() {
                #stopApp()
        })
        
})