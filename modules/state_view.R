import("shiny")
import("plotly")
import("modules")
import("shinydashboard")
import("ggplot2")
import("DT")
import("utils")
import("dplyr")

export("ui")
export("init_server")

CONSTS <- use("constants/constants.R")

ui <- function(id) {
  ns <- NS(id)

  box(
    title = "Top Destination States",
    status = "primary",
    collapsible = FALSE,
    solidHeader = FALSE,
    width = 12,
    DTOutput(ns("statetable"))
  )
}

init_server <- function(id) {
  callModule(server, id)
}

server <- function(input, output, session) {
  ns <- session$ns

  state_data <- CONSTS$APP_DATA$state_data

  # This allows to add footer with totals
  sketch <- htmltools::withTags(table(
    tableHeader(c("State", "Name", "Total shipments", "Total weight", "# of Locations", "Shipments/Day")),
    tableFooter(
      c("Grand Total", "",
        format(
          c(
            sum(state_data$total.shipments),
            sum(state_data$total.weight), sum(state_data$number.of.locations),
            round(sum(state_data$total.shipments)/30, 1)
          ),
          big.mark = ","
        )
      )
    )
  ))

  # DataTable object
  output$statetable <- DT::renderDT({
    DT::datatable(
      state_data,
      container = sketch,
      rownames = FALSE,
      style = "bootstrap",
      selection = 'single',
      caption = "Select a state to examine it in more detail",
      options = list(
        dom = 'ftp',
        search = list(regex = TRUE, caseInsensitive = TRUE),
        pageLength = 5,
        ordering = TRUE,
        stateSave = TRUE,
        columnDefs = list(list(visible = FALSE, targets = c(1)))
      )
    )
  })

  # DataTable proxy object
  DTproxy <- DT::dataTableProxy("statetable")

  return(list(state_selected = reactive({state_data[input$statetable_rows_selected,]})))
}
