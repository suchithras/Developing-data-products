
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$distPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    x <- trees$Height
    y<-trees$Girth
    
    # draw the histogram with the specified number of bins
   plot(lm(x~y))
    
  })
  
})
