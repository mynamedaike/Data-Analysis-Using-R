library(shiny)
library(ggplot2)
library(dplyr)
library(DT)
library(stringr)
bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)
# bcl %>%
#   filter(Price >= 0,
#          Price <= 100,
#          Type == "WINE",
#          Sweetness >= 0,
#          Sweetness <= 10) %>%
#   mutate(Subtype = as.factor(Subtype)) %>%
#   nrow()

# levels(bcl1$Subtype)

subtype <- function(type) {
  bcl1 <- bcl %>% 
    filter(Type %in% type) %>% 
    mutate(Subtype = as.factor(Subtype))
  
  levels(bcl1$Subtype)
}

server <- function(input, output) {
  output$subtypeOutput <- renderUI({
    if(!is.null(input$typeInput)) {
      conditionalPanel("input.typeInput != 'BEER'",
                       checkboxGroupInput("subtypeInput", "Subtype",
                                          choices = subtype(input$typeInput))
      )
    }
  })
  
  output$countryOutput <- renderUI({
    conditionalPanel("input.filterByCountry == true",
                     selectInput("countryInput", "Country",
                                 sort(unique(bcl$Country)),
                                 selected = "CANADA")
    )
  })
  
  #observe({print(input$subtypeInput)})
  observe({print(input$sweetnessInput)})
  observe({print(length(input$typeInput))})
  
  filtered <- reactive({
    #if (is.null(input$countryInput)) {
    #  return(NULL)
    #}
    
    if (is.null(input$typeInput)) {
      return(NULL)
    }
    
    if (input$filterByCountry == TRUE) {
      tmp <- bcl %>%
        filter(Price >= input$priceInput[1],
               Price <= input$priceInput[2],
               Type %in% input$typeInput,
               Country == input$countryInput
        )
    } else {
      tmp <- bcl %>%
        filter(Price >= input$priceInput[1],
               Price <= input$priceInput[2],
               Type %in% input$typeInput
        )
    }
    
    if(length(input$typeInput) == 1 && input$typeInput == "WINE") {
      tmp <- tmp %>%
        filter(Sweetness >= input$sweetnessInput[1],
               Sweetness <= input$sweetnessInput[2])
    }
    
    if(!is.null(input$subtypeInput)){
      tmp <- tmp %>% 
        filter(Subtype %in% input$subtypeInput)
    }
    
    if(nrow(tmp) == 0) {
      return(NULL)
    } else if(input$sortByPrice == TRUE) {
      tmp %>% 
        arrange(Price)
    } else {
      tmp
    }
  })
  
  #observe({print(filtered())})
  
  output$resultsNum <- renderText({
    if(is.null(filtered())) {
      num <- 0
    } else {
      num <- nrow(filtered())
    }
    str_c("We found ", as.character(num), " options for you")
  })
  
  output$coolplot <- renderPlot({
    if (is.null(filtered())) {
      return()
    }
    ggplot(filtered(), aes(Alcohol_Content)) +
      geom_histogram(fill = input$barColor)
  })
  
  output$results <- renderDataTable({
    filtered()
  })
  
  output$download <- downloadHandler(
    filename = "results.csv",
    content = function(file) {
      write.csv(filtered(), file)
    }
  )
}