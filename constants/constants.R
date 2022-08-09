import("shiny")

APP_DATA <- readRDS("./data/DATA_FAKE.rds")
APP_TITLE <- "Destination Overview"
APP_TIME_RANGE <- "January 2019 to May 2019"
APP_VERSION <- "1.0.0"

appsilon_website <- "https://appsilon.com/"
marketplace_website <- "https://appsilon.com/"
marketplace_name <- "Appsilon's Shiny Marketplace"

COLORS <- list(
  white = "#FFF",
  black = "#0a1e2b",
  primary = "#0099F9",
  secondary = "#15354A",
  ash = "#B3B8BA",
  ash_light = "#e3e7e9"
)

metrics_list <- list(
  shipments = list(
    label = "Total shipments",
    value = paste(sum(APP_DATA$state_data$total.shipments), "trips")
  ),
  weight = list(
    label = "Total weight",
    value = paste(format(sum(APP_DATA$state_data$total.weight), big.mark = ","), "tons")
  ),
  locations = list(
    label = "Number of locations",
    value = paste(sum(APP_DATA$state_data$number.of.locations), "locations")
  ),
  shipments_day = list(
    label = "Shipments per day",
    value = paste(sum(APP_DATA$state_data$shipments.day), "trips")
  )
)

appsilon_logo <- tags$a(
  href = appsilon_website,
  target = "_blank",
  rel = "nofollow noreferrer",
  class = "logo-link",
  img(src = "images/logo-appsilon.svg", class = "logo-img", alt = "Appsilon Logo")
)

appsilon_footer <- tags$h3(
  class = "footer-heading",
  tags$span("This application is powered by a template from"),
  tags$a(
    class = "footer-link",
    href = marketplace_website,
    target = "_blank",
    rel = "nofollow noreferrer",
    marketplace_name
  )
)
