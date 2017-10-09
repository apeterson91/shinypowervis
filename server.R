
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
source("simstudy.R")

shinyServer(function(input, output) {

  output$powerPlot <- renderPlot({
    
  ## simulate data
  ns <- seq(from = 10, to = input$n,by = 10)
  results <- sapply(ns, FUN = function(x)
    run.sims(reps = input$n_sims,
             args = list(n1 = x/2, n2 = x/2,
                         differential = input$delta,
                         base_sd = input$sigma)),simplify = F)
  
  results <- Reduce(rbind,results)
  p <- results %>% as_data_frame()%>% 
    ggplot(aes(x = n, y = effect)) + geom_point(alpha=0) + geom_smooth() + xlab("Sample Size") + ylab("Power") + 
    ggtitle("Power for Clinical Trial") + theme_bw() + geom_hline(yintercept = .8,linetype='dotted') + 
    geom_hline(yintercept = 1, linetype='solid')
  return(p)
  # Plot results
  })

})
# results <- sapply(ns, FUN = function(x)
#   run.sims(reps = 100 ,args = list(n1 = x/2, n2 = x/2,
#                                            differential = 1.2,
#                                            base_sd = 3.2)), simplify = FALSE)
#   