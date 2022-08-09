import("shiny")

export("ui")
export("init_server")

CONSTS <- use("constants/constants.R")

ui <- function(id) {
  ns <- NS(id)

  # Metrics with dynamic titles and values depending on selected state
  tagList(
    div (
      class = "box box-primary metric metric-local metric-local-1",
      div(
        class = "icon"
      ),
      div(
        class = "value",
        uiOutput(ns("metricsboxtitle1")),
        textOutput(ns("metricsbox1"))
      )
    ),
    div (
      class = "box box-primary metric metric-local metric-local-2",
      div(
        class = "icon"
      ),
      div(
        class = "value",
        uiOutput(ns("metricsboxtitle2")),
        textOutput(ns("metricsbox2"))
      )
    )
  )
}

init_server <- function(id) {
  callModule(server, id)
}

server <- function(input, output, session) {
  ns <- session$ns
  
  state_selected_data <- session$userData$state_view$state_selected
  
  output$metricsboxtitle1 <- renderUI({
    if(isTRUE(nrow(state_selected_data()) > 0))
      tags$label(paste(state_selected_data()$state_full, "shipments"))
    else
      tags$label("State shipments")
  })
  
  output$metricsboxtitle2 <- renderUI({
    if(isTRUE(nrow(state_selected_data()) > 0))
      tags$label(paste(state_selected_data()$state_full, "weight"))
    else
      tags$label("State weight")
  })
  
  output$metricsbox1 <- renderText({
    if(isTRUE(nrow(state_selected_data()) > 0))
      paste(state_selected_data()$total.shipments, "shipments")
    else
      paste(sum(CONSTS$APP_DATA$state_data$total.shipments), "trips")
  })
  
  output$metricsbox2 <- renderText({
    if(isTRUE(nrow(state_selected_data()) > 0))
      paste(state_selected_data()$total.weight, "tons")
    else
      paste(format(sum(CONSTS$APP_DATA$state_data$total.weight), big.mark = ","), "tons")
  })
}
