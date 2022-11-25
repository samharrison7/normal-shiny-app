library(shiny)
library(shinyWidgets)
library(ggplot2)

# Define the UI
ui <- pageWithSidebar(

    # App title
    headerPanel("Plot a normal distribution"),

    # Side panel for inputs
    sidebarPanel(
        # Input the range of which to plot the distribution
        numericRangeInput(
            inputId = "x_range",
            label = "x range",
            value = c(0.0,10.0),
        ),
        numericInput(
            inputId = "loc",
            label = "Mean value of the distribution",
            value = 5.0
        ),
        numericInput(
            inputId = "scale",
            label = "Scale of the distribution",
            value = 1.0
        )
    ),

    # Main panel for the plot
    mainPanel(
        plotOutput("plot")
    )
)

# Function that internally calls our Fortran function to
# generate the normal PDF, based on the specified parameters
generate_pdf <- function(x_min, x_max, loc, scale) {
    # Load our Fortran library
    dyn.load("normal.so")
    # Parameters to generate the normal PDF
    n <- as.integer(1000)
    x <- as.numeric(seq(from = x_min, to = x_max, length.out = n))
    pdf <- as.numeric(seq(from = x_min, to = x_max, length.out = n))
    # Run the Fortran code to calculate the distribution
    result = .Fortran(
        "normal_pdf",
        x = x,
        n = n,
        loc = as.numeric(loc),
        scale = as.numeric(scale),
        pdf = pdf
    )
    return(result)
}

# Define the server logic
server <- function(input, output) {
    # Use the inputs to generate the PDF
    result <- reactive({
        generate_pdf(
            input$x_range[1],
            input$x_range[2],
            input$loc,
            input$scale
        )
    })
    # Plot the PDF
    output$plot <- renderPlot({
        ggplot(
            data.frame(
                x = result()$x,
                y = result()$pdf
            ),
            aes(x = x, y = y)
        ) + geom_line()
    })
}

# Build the Shiny app
shinyApp(ui, server)