install.packages(c("shiny", "readxl", "ggplot2", "plotly"))

# Memuat paket yang diperlukan
library(shiny)
library(readxl)
library(ggplot2)
library(plotly)

# Membaca data dari file Excel
weather <- read_excel("D:/TUGAS KULIAH UT/Mata Kuliah Analisis dan Visualisasi Data/Analis Tuton Tugas 3/weather.xlsx")

# UI untuk aplikasi Shiny
ui <- fluidPage(
  # Title of the app
  titlePanel("Visualisasi Data Interaktif"),
  
  # Sidebar layout
  sidebarLayout(
    sidebarPanel(
      # Dropdown untuk memilih variabel yang akan divisualisasikan
      selectInput("var", 
                  label = "Pilih Variabel", 
                  choices = names(weather), 
                  selected = names(weather)[1]),
      
      # Dropdown untuk memilih jenis plot
      selectInput("plot_type", 
                  label = "Pilih Jenis Plot", 
                  choices = c("Scatter Plot Interaktif", "Line Plot Interaktif", "Bar Plot Interaktif", "Tabel Data"), 
                  selected = "Scatter Plot")
    ),
    
    mainPanel(
      # Output untuk grafik atau tabel
      uiOutput("plot_ui")
    )
  )
)

# Server untuk aplikasi Shiny
server <- function(input, output) {
  
  # Reactive expression untuk menghasilkan plot atau tabel berdasarkan input
  output$plot_ui <- renderUI({
    # Mengambil variabel yang dipilih
    var <- input$var
    plot_type <- input$plot_type
    
    # Menentukan output berdasarkan jenis plot
    if (plot_type == "Scatter Plot Interaktif") {
      plotlyOutput("scatter_plot")
    } else if (plot_type == "Line Plot Interaktif") {
      plotlyOutput("line_plot")
    } else if (plot_type == "Bar Plot Interaktif") {
      plotlyOutput("bar_plot")
    } else if (plot_type == "Tabel Data") {
      tableOutput("data_table")
    }
  })
  
  # Plot Scatter Plot
  output$scatter_plot <- renderPlotly({
    plot_ly(data = weather, x = ~get(input$var), y = ~get(input$var), type = "scatter", mode = "markers")
  })
  
  # Plot Line Plot
  output$line_plot <- renderPlotly({
    plot_ly(data = weather, x = ~get(input$var), y = ~get(input$var), type = "scatter", mode = "lines")
  })
  
  # Plot Bar Plot
  output$bar_plot <- renderPlotly({
    plot_ly(data = weather, x = ~get(input$var), type = "bar")
  })
  
  # Menampilkan Tabel Data
  output$data_table <- renderTable({
    head(weather)
  })
}

# Menjalankan aplikasi Shiny
shinyApp(ui = ui, server = server)
