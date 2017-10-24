
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Clinical Trial Power Simulation"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("n",
                  "Sample Size",
                  min = 50, max = 500, value = 30, step = 10),
    sliderInput("delta",
                "Differential",
                min = 0, max = 3, value = 1.31, step = 0.01),
    # sliderInput("sigma",
    #             "Standard Deviation",
    #             min = .5 , max = 5, value = 1, step = 0.1),
    sliderInput("n_sims",
                "Number of Simulations",
                min = 10, max = 110, value = 50, step = 10)
    ),
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("powerPlot")
    )
  )
))
