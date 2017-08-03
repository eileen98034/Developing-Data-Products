#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
head(trees)
girth_min = min(trees$Girth)
girth_max = max(trees$Girth)

# create the UI 
ui <- fluidPage(
   
   # Application title
   titlePanel("Tree Girth Frequency using Dataset \"trees\""),
   
   # creates histoslider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("girth",
                     "Select a girth value (in inches):",
                     girth_min,
                     girth_max,
                     value = median(girth_min:girth_max),
                     step = 1,
                     round = TRUE,
                     format = "##.0",
                     ticks = FALSE,
                     animate = FALSE
                     
                     )
      ),
      
      # generate a histogram of the distribution of trees based on girth values
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# create the server with logic that will make a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
     
      # the histogram's "bins" are taken from the number of trees in the dataset
      Number_of_Trees <- trees[, 1] 
      tree_girth <- seq(min(Number_of_Trees), max(Number_of_Trees), length.out = input$girth + 1)

      # draw the histogram with the specified number of bins
      #hist(Number_of_Trees, breaks = tree_girth, col = 'darkgreen', border = 'green', main = 'Tree Girth Frequency')
      plot(trees$Girth)

   })
}

# Run the application 
shinyApp(ui = ui, server = server)

