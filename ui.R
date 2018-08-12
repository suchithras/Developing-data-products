
library(shiny)

# Drawing the scatter plot
fluidPage(
  titlePanel("Redoing the Linear model"),
  fluidRow(
    column(width = 10,
           plotOutput("plot1", height = 500,
                      click = "plot1_click",
                      brush = brushOpts(
                        id = "plot1_brush"
                      )
           ),
           actionButton("exclude_toggle", "Toggle in/out the values!"),
           actionButton("exclude_reset", "Reset")
    )
  ),
  mainPanel(
    h3("R square:"),
    textOutput("rsquare"),
    h4("This app works in a way that, just browsing your mouse over a set of points, 
       you can toggle those points out of the data set used to calculate the regression line. If you pick those exluded points (red empty circles) and click the toggle in/out the values! you will incorporate them again
       after you are done or whenever you wish you can click reset and star all over")
    )
)

