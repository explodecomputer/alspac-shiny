library(shiny)

shinyUI(fluidPage(
  title = 'ALSPAC variables lookup',
  h1('Browse variables available in ALSPAC'),
  tabsetPanel(
    tabPanel("Current", 
      fluidRow(
        column(8, DT::dataTableOutput('x3')),
        column(4, verbatimTextOutput('x4'))
      )
    ),
    tabPanel("Useful data",
      fluidRow(
        column(8, DT::dataTableOutput('y3')),
        column(4, verbatimTextOutput('y4'))
      )
    )
  )
))
