library(shiny)

shinyUI(fluidPage(
  title = 'ALSPAC variables lookup',
  h1('Browse variables available in ALSPAC'),
  tabsetPanel(
  	tabPanel("About",
      fluidRow(
      	column(4,
      	  p("Info about this website")
      	)
      )
    ),
    tabPanel("Current", 
      fluidRow(
        column(8, DT::dataTableOutput('x3')),
        column(4, verbatimTextOutput('x4'),
        	uiOutput("makebutton")
        )
      )
    )
  )
))
