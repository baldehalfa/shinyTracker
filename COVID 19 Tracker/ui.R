
# Overview
body_overview <- dashboardBody(
  tags$head(
    tags$style(type = "text/css", "#overview_map {height: 77.5vh !important;}"),
    tags$style(type = "text/css", "#summary {height: 60h !important;}"),
    tags$style(type = 'text/css', ".slider-animate-button { font-size: 20pt !important; }"),
    tags$style(type = 'text/css', ".slider-animate-container { text-align: left !important; }"),
    tags$style(type = "text/css", "@media (max-width: 991px) { .details { display: flex; flex-direction: column; } }"),
    tags$style(type = "text/css", "@media (max-width: 991px) { .details .map { order: 1; width: 100%; } }"),
    tags$style(type = "text/css", "@media (max-width: 991px) { .details .summary { order: 3; width: 100%; } }"),
    tags$style(type = "text/css", "@media (max-width: 991px) { .details .slider { order: 2; width: 100%; } }")
  ),
  fluidRow(
    fluidRow(
      class = "details",
      column(
        box(
          width = 12,
          leafletOutput("overview_map")
        ),
        class = "map",
        width = 10,
        style = 'padding:0px;'
      ),
      column(
        uiOutput("box_keyFigures"),
        class = "summary",
        width = 2,
        style = 'padding:0px;'
      ),
      column(
        sliderInput(
          "timeSlider",
          label      = "Time Machine",
          min        = min(data_evolution$date),
          max        = max(data_evolution$date),
          value      = max(data_evolution$date),
          width      = "100%",
          timeFormat = "%d-%B-%Y",
          animate    = animationOptions(loop = TRUE)
        ),
        class = "slider",
        width = 12
      )
    )
  )
)



page_overview <- dashboardPage(
  title   = "Overview",
  header  = dashboardHeader(disable = TRUE),
  sidebar = dashboardSidebar(disable = TRUE),
  body    = body_overview
)





# Data View
body_data <- dashboardBody(
  tags$head(
    tags$style(type = "text/css", "@media (min-width: 768px) { .full-table { margin-top: -30px; } }")
  ),
  fluidPage(
    fluidRow(
      h3(paste0("Complete Data (", strftime(current_date, format = "%d-%B-%Y"), ")"),
         class = "box-title", style = "margin-top: 10px; font-size: 18px;"),
      div(
        dataTableOutput("fullTable"),
        class = "full-table"
      ),
      div(
        sliderInput(
          "timeSlider",
          label      = "Time Machine",
          min        = min(data_evolution$date),
          max        = max(data_evolution$date),
          value      = max(data_evolution$date),
          width      = "100%",
          timeFormat = "%d-%B-%Y",
          animate    = animationOptions(loop = TRUE)
        )
      ),
      width = 12
    )
  )
)

page_data <- dashboardPage(
  title   = "Data",
  header  = dashboardHeader(disable = TRUE),
  sidebar = dashboardSidebar(disable = TRUE),
  body    = body_data
)



# Analysis view

page_analysis <- dashboardPage(
  title = "Plots",
  header = dashboardHeader(disable = TRUE),
  sidebar = dashboardSidebar(disable = TRUE),
  body = dashboardBody(fluidRow(fluidRow(uiOutput("box_caseEvolution"))))
)




##
ui <- fluidPage(
  title = "COVID-19 Shiny Tracker",

  tags$style(type = "text/css", ".container-fluid {padding-left: 0px; padding-right: 0px !important;}"),
  tags$style(type = "text/css", ".navbar {margin-bottom: 0px;}"),
  tags$style(type = "text/css", ".content {padding: 0px;}"),
  tags$style(type = "text/css", ".row {margin-left: 0px; margin-right: 0px;}"),
  tags$style(HTML(".col-sm-12 { padding: 5px; margin-bottom: -15px; }")),
  tags$style(HTML(".col-sm-6 { padding: 5px; margin-bottom: -15px; }")),
  navbarPage(
    title       = div("COVID-19 Shiny Tracker", style = "padding-left: 10px"),
    inverse = TRUE,
    collapsible = TRUE,
    fluid       = TRUE,
    tabPanel("Overview", page_overview, value = "page-overview"),
    tabPanel("Data", page_data, value = "page-data"),
    tabPanel("Analysis", page_analysis, value = "page-analysis"),
    tabPanel("Help", page_help, value = "page-help"),
    tabPanel("About", page_about, value = "page-about")
    )
  )
