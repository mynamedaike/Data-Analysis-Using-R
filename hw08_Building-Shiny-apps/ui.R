library(shiny)
library(shinyjs)
library(shinythemes)
library(DT)
ui <- fluidPage(
   theme = "style.css",
  # theme = shinytheme("superhero"),
  titlePanel("BC Liquor Store prices"),
  img(src = "Home-Page-Liquor-store-min.png", style = "width: 100%"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("priceInput", "Price", 0, 100, c(25, 40), pre = "$"),
      checkboxGroupInput("typeInput", "Product type",
                         choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                         selected = "WINE"),
      tags$div(class="clear"),
      conditionalPanel("input.typeInput == 'WINE'",
                       sliderInput("sweetnessInput", "Sweetness", 0, 10, c(0,10))
      ),
      uiOutput("subtypeOutput"),
      tags$div(class="clear"),
      colourInput("barColor", "Change the color of bars in the plot", "red"),
      checkboxInput("filterByCountry", "Filter by country"),
      uiOutput("countryOutput"),
      checkboxInput("sortByPrice", "Sort the results table by price", FALSE)
    ),
    mainPanel(
      # tags$h3(textOutput("resultsNum")),
      # downloadButton("download", "Download results"),
      tags$div(class="results",
               tags$div(class="textContainer", textOutput("resultsNum")),
               downloadButton("download", "Download results")),
      tabsetPanel(
        tabPanel("Plot", plotOutput("coolplot")),
        tabPanel("Table", dataTableOutput("results"))
      )
    )
  )
)