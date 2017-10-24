
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
source("simstudy.R")

shinyServer(function(input, output) {

  output$powerPlot <- renderPlot({
    
  ## Simulate data
  ns <- seq(from = 10, to = input$n,by = 10)
  results <- sapply(ns, FUN = function(x)
    run.sims(reps = input$n_sims,
             args = list(n1 = x/2, n2 = x/2,
                         differential = input$delta )),simplify = F)
  ## Combine results
  results <- Reduce(rbind,results)
  
  # Plot results
  p <- results %>% as_data_frame()%>% 
    ggplot(aes(x = n, y = effect)) + geom_point(alpha=0) + geom_smooth() + xlab("Sample Size") + ylab("Power") + 
    ggtitle("Power for Clinical Trial") + theme_bw() + geom_hline(yintercept = .8,linetype='dotted') + 
    geom_hline(yintercept = 1, linetype='solid') + coord_cartesian(ylim=c(0,1))
  return(p)
  
  })

})
