CONSTS <- use("constants/constants.R")

dashboardPage(
  dashboardHeader(
    # App title visible in browser tab
    title = CONSTS$APP_TITLE,
    # App title visible
    tags$li(class = "dropdown title", tags$h1(CONSTS$APP_TITLE)),
    # App current version
    tags$li(class = "dropdown version", tags$p(CONSTS$APP_VERSION)),
    # App time range
    tags$li(class = "dropdown time-range", tags$p(CONSTS$APP_TIME_RANGE)),
    # App logo
    tags$li(class = "dropdown logo", CONSTS$appsilon_logo)
  ),
  dashboardSidebar(
    sidebarMenu(
      # Simple dashboard tab
      menuItem("Simple Dashboard", tabName = "simpleDashboard", icon = icon("chart-line")),
      # Advanced dashboard tab
      menuItem("Advanced Dashboard", tabName = "advancedDashboard", icon = icon("chart-bar")),
      # Contact tab
      menuItem("Contact", tabName = "contact", icon = icon("id-card"))
    )
  ),
  dashboardBody(
    tags$head(
      # Reset favicon
      tags$link(rel = "shortcut icon", href = "#"),
      # Compiled css file
      tags$link(rel = "stylesheet", type = "text/css", href = "css/sass.min.css")
    ),
    tabItems(
      # Simple dashboard tab
      tabItem("simpleDashboard", simpleDashboardTab),
      # Advanced dashboard tab
      tabItem("advancedDashboard", advancedDashboardTab),
      # Contact tab
      tabItem("contact", contactTab)
    ),
    # You are not supposed to remove this footer
    tags$footer(class = "footer", CONSTS$appsilon_footer)
  )
)
