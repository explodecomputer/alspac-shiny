library(shiny)

shinyUI(fluidPage(
  title = 'ALSPAC variables lookup',
  h1('Browse variables available in ALSPAC'),
  tabsetPanel(
    tabPanel("Variables", 
      fluidRow(
        column(8, DT::dataTableOutput('x3')),
        column(4, verbatimTextOutput('x4'),
        	uiOutput("makebutton")
        )
      )
    ),
  	tabPanel("About",
      fluidRow(
      	column(4,
      	  p("This website can be used to browse the available variables for the ALSPAC data resource."),
      	  p("To request the variables of interest, select them by clicking on the relevant rows in the table, and then click 'Export'. This will create an Excel file that you can send to the data team.")
      	)
      )
    )
  )
))
