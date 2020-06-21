body_about <- dashboardBody(
  fluidRow(
    fluidRow(
      column(
        box(
          title = div("App Description", style = "padding-left: 20px", class = "h2"),
          column(
            h3("The COVID-19 Tracker App"),
            "This dashboard demonstrates some recent news about the Coronavirus pandemic. 
            This App is a simulator, that reads from the John Hopkins dataset, and shows some data related to mortality,  
            recovery, infected, and etc..",
            tags$br(),
           
            
            h3("Creator"),
            "Ahmad Bazzi",
            tags$br(),
            tags$a(href = "https://www.youtube.com/c/AhmadBazzi", "YouTube"), " | ",
            tags$a(href = "https://www.linkedin.com/in/drahmadbazzi/", "LinkedIn"), " | ",
            tags$a(href = "https://scholar.google.fr/citations?user=9HWunwcAAAAJ&hl=en&oi=ao", "Google Scholar"), " | ",
            tags$a(href = "https://www.researchgate.net/profile/Ahmad_Bazzi", "ResearchGate"), 
            width = 12
          ),
          width = 6,
        ),
        width = 12,
        style = "padding: 15px"
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