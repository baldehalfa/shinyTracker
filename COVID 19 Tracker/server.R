source_files <- function(path) {
  
  files <- list.files(path = path, pattern = ".*\\.R", all.files = F, full.names = TRUE, recursive = TRUE)
  for (fileToSource in files) {
    source(fileToSource, local = parent.frame())
    cat(fileToSource, "sourced.\n")
  }
}



server <- function(input, output) {
  source_files("sections")

  
  observe({
    data <- data_atDate(input$timeSlider)
  })
}