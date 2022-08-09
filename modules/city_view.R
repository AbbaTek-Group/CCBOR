import("shiny")
import("DT")
import("plotly")
import("modules")
import("shinydashboard")
import("ggplot2")
import("dplyr")
import("utils")
import("echarts4r")
import("htmlwidgets")

export("ui")
export("init_server")

CONSTS <- use("constants/constants.R")

ui <- function(id) {
  ns <- NS(id)

  box(
    title = "Top Destination Cities",
    status = "primary",
    collapsible = FALSE,
    solidHeader = FALSE,
    width = 12,
    echarts4rOutput(ns("cityplot"), height = '370px')
  )
}

init_server <- function(id) {
  callModule(server, id)
}

server <- function(input, output, session) {
  ns <- session$ns
  state_selected_data <- session$userData$state_view$state_selected
  city_data <- CONSTS$APP_DATA$city_data

  output$cityplot <- renderEcharts4r({
    
    if(isTRUE(nrow(state_selected_data()) > 0))
      city_data <- city_data %>% subset(state == state_selected_data()$state)
    city_data <- head(city_data, 5L)
    names(city_data) <- c("city", "statename", "y", "weightvalue", "shipmentsday")
    
    # Echarts4r bar plot
    city_data %>% 
      e_charts(city) %>% 
      e_axis_labels(y = "Total shipments") %>% 
      e_legend(show = FALSE) %>%
      e_bar(
        y,
        name = "",
        itemStyle = list(
          color = CONSTS$COLORS$primary,
          borderRadius = 6
        )
      ) %>% 
      e_add("custom", c(statename, y, shipmentsday, weightvalue)) %>%
      e_tooltip(
        trigger = "item",
        formatter = JS("
          function(params) {
            const { statename, y, weightvalue, shipmentsday } = params.data.custom;
            return `
              <strong>State: </strong>${params.data.custom.statename} <br>
              <strong>Shipments: </strong>${shipmentsday} <br>
              <strong>Weight: </strong>${weightvalue} <br>
              <strong>Per Day: </strong>${shipmentsday} <br>
            `
          }
        "),
        borderWidth = 0,
        extraCssText = "box-shadow: 0 3px 12px rgba(0,0,0,0.2);"
      )
  })
}
