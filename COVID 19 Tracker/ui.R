# Help View


# About View


body_about <- dashboardBody(
  fluidRow(
    fluidRow(
      column(
        box(
          title = div("User Guide", style = "padding-left: 40px", class = "h2"),
          column(
            h3("The COVID-19 Tracker App"),
            "This dashboard demonstrates some recent news about the Coronavirus pandemic. 
            This App is a simulator, that reads from the John Hopkins dataset, and shows some data related to mortality,  
            recovery, infected, and etc..",
            tags$br(),
            "This dashboard shows recent developments of the COVID-19 pandemic. The latest
            open data on the COVID-19 spread are regularly downloaded and displayed in
            a map, summary tables, key figures and plots.",
            tags$br(),
            h3("Overview page"),
            
            tags$li(tags$b("Summary"), "Global summary cases for Confirmed cases, Estimated Recoveries, Deceased, "),
            
            tags$li(tags$b("Map"), "Map Includes a filters as shown in the picture below"),
            tags$img(src = "im1.png", width = "640px", height = "320px"),
            tags$li(tags$b("Filter"), " Time machine to display the statistic cases based on different date"),
            
            
            h3("Data Page"),
            tags$ul(
              tags$li(tags$b("COVID-19 data:"), tags$a(href = "https://github.com/CSSEGISandData/COVID-19",
                                                       "Johns Hopkins CSSE")),
              tags$li(tags$b("Population data:"), tags$a(href = "https://data.worldbank.org/indicator/SP.POP.TOTL",
                                                         "The World Bank"), "& Wikipedia for countries which are not in World Bank data set.")
            ),
            HTML("<b>Note</b>: Johns Hopkins is not updating their data on recovered cases anymore for various
            countries. Therefore, this data is estimated as <i>(Confirmed at current date - 14 days) - deceased at
            current date)</i>, wherever no real data is available."),
            
           
            h3("Analysis"),
            HTML("<b>Chart description</b>: this page shows 4 dirreferent charts for Evolution of Cases since Outbreak <i> (Global Word Cases) </i>,
            New cases<i> (Select Country) </i>,
            Cases per Country and Evolution of Cases since 10th/100th case<i> (Selected Coutry) <i>,
            "),
            tags$br(),
            tags$img(src = "im2.png", width = "440px", height = "220px"),
            
            h3("Developers"),
            "Omar Messaoud | MAMADOU ALPHA HAWA BALDE | ALI ALRABEEI| LIM YONG MENG | Pricipal of Data Science: Group project @",
            tags$br(),
            tags$a(href = "https://github.com/baldehalfa/shinyTracker", "Github"), 
            width = 12
          ),
          width = 10,
        ),
        width = 12,
        style = "padding: 30px"
      )
    )
  )
)


page_about <- dashboardPage(
  title = "About",
  header = dashboardHeader(disable = TRUE),
  sidebar = dashboardSidebar(disable = TRUE),
  body = body_about
)

# Overview
body_overview <- dashboardBody(
  tags$head(
    tags$style(type = "text/css", "#overview_map {height: 75h !important;}"),
    tags$style(type = "text/css", "#summary {height: 60h !important;}"),
    tags$style(type = 'text/css', ".slider-animate-button { font-size: 20pt !important; }"),
    tags$style(type = 'text/css', ".slider-animate-container { text-align: left !important; }"),
    # tags$style(type = "text/css", "@media (max-width: 991px) { .details { display: flex; flex-direction: column; } }"),
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
        width = 9,
        style = 'padding:0px;'
      ),
      column(
        uiOutput("box_keyFigures"),
        class = "summary",
        width = 3,
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
      h3(paste0("Complete Data (", strftime(current_date, format = "%d.%m.%Y"), ")"),
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
  tags$head(
    tags$link(rel = "shortcut icon", type = "image/png", href = "logo.png")
  ),
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
    tabPanel("User Guide", page_about, value = "page-about")
    )
  )