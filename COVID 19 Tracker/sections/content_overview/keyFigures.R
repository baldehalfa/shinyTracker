sumData <- function(date) {
  if (date >= min(data_evolution$date)) {
    data <- data_atDate(date) %>% summarise(
      confirmed = sum(confirmed, na.rm = T),
      recovered = sum(recovered, na.rm = T),
      deceased  = sum(deceased, na.rm = T),
      countries = n_distinct(`Country/Region`),
      active = sum(active, na.rm = T),
    )
    return(data)
  }
  return(NULL)
}

key_figures <- reactive({
  data           <- sumData(input$timeSlider)
  data_yesterday <- sumData(input$timeSlider - 1)

  data_new <- list(
    new_confirmed = (data$confirmed - data_yesterday$confirmed) / data_yesterday$confirmed * 100,
    new_recovered = (data$recovered - data_yesterday$recovered) / data_yesterday$recovered * 100,
    new_deceased  = (data$deceased - data_yesterday$deceased) / data_yesterday$deceased * 100,
    new_countries = data$countries - data_yesterday$countries,
    new_active = (data$active - data_yesterday$active) / data_yesterday$active * 100
  )

  keyFigures <- list(
    "confirmed" = HTML(paste(format(data$confirmed, big.mark = " "), sprintf("<h4>(%+.1f %%)</h4>", data_new$new_confirmed))),
    "recovered" = HTML(paste(format(data$recovered, big.mark = " "), sprintf("<h4>(%+.1f %%)</h4>", data_new$new_recovered))),
    "deceased"  = HTML(paste(format(data$deceased, big.mark = " "), sprintf("<h4>(%+.1f %%)</h4>", data_new$new_deceased))),
    "countries" = HTML(paste(format(data$countries, big.mark = " "), "/ 195", sprintf("<h4>(%+d)</h4>", data_new$new_countries))),
    "active" = HTML(paste(format(data$active, big.mark = " "), sprintf("<h4>(%+.1f %%)</h4>", data_new$new_active)))
    
  )
  return(keyFigures)
})

output$valueBox_confirmed <- renderValueBox({
  valueBox(
    key_figures()$confirmed,
    subtitle = "Confirmed",
    color    = "orange",
    width    = NULL
  )
})


output$valueBox_recovered <- renderValueBox({
  valueBox(
    key_figures()$recovered,
    subtitle = "Estimated Recoveries",
    color    = "green",
  )
})

output$valueBox_deceased <- renderValueBox({
  valueBox(
    key_figures()$deceased,
    subtitle = "Deaths",
    color    = "black",
  )
})

output$valueBox_countries <- renderValueBox({
  valueBox(
    key_figures()$countries,
    subtitle = "Affected Countries",
    color    = "blue",
  )
})

output$valueBox_Active <- renderValueBox({
  valueBox(
    key_figures()$active,
    subtitle = "Active",
    color    = "red",
  )
})

output$box_keyFigures <- renderUI(box(
  title = paste0("Summary (", strftime(input$timeSlider, format = "%d-%B-%Y"), ")"),
  fluidRow(valueBoxOutput("valueBox_confirmed", width = 12)),
  fluidRow(valueBoxOutput("valueBox_recovered", width = 12)),
  fluidRow(valueBoxOutput("valueBox_Active", width = 12)),
  fluidRow(valueBoxOutput("valueBox_deceased", width = 12)),
  fluidRow(valueBoxOutput("valueBox_countries", width = 12)),
  width = 12
))