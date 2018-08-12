

library(shiny)
library(ggplot2)


function(input, output) {
  # For storing which rows have been excluded
  vals <- reactiveValues(
    keeprows = rep(TRUE, nrow(trees))
  )
  
  output$plot1 <- renderPlot({
    # Plot the kept and excluded points as two separate data sets
    keep    <- trees[ vals$keeprows, , drop = FALSE]
    exclude <- trees[!vals$keeprows, , drop = FALSE]
    
    ggplot(keep, aes(Girth, Volume)) + geom_point() +
      geom_smooth(method = lm, fullrange = TRUE, color = "blue") +
      geom_point(data = exclude, shape = 1, fill = NA, color = "red", alpha = 0.75) +
      coord_cartesian(xlim = c(8, 20), ylim = c(10,80))
  })
  
  output$rsquare <- renderText({
    keep    <- trees[ vals$keeprows, , drop = FALSE]
    fit <- with(keep, lm(Volume ~ Girth))
    summary(fit)$r.square
  })
  
  # Toggle points that are clicked
  observeEvent(input$plot1_click, {
    res <- nearPoints(trees, input$plot1_click, allRows = TRUE)
    
    vals$keeprows <- xor(vals$keeprows, res$selected_)
  })
  
  # Toggle points that are brushed
  observeEvent(input$exclude_toggle, {
    res <- brushedPoints(trees, input$plot1_brush, allRows = TRUE)
    
    vals$keeprows <- xor(vals$keeprows, res$selected_)
  })
  
  # Reset all
  observeEvent(input$exclude_reset, {
    vals$keeprows <- rep(TRUE, nrow(trees))
  })
  
}
