# library(shiny)
# library(shinyBS)
# library(shinyLP)
library(shiny)
library(shinyBS)
library(shinyLP)
library(shinyTypeahead)
library(alspac)
library(shinythemes)

data(current)
data(useful)
current <- subset(current, ! name %in% c("aln", "qlet"), select=c(name, lab, counts, type, cat1, cat2, cat3, cat4))
useful <- subset(useful, ! name %in% c("aln", "qlet"), select=c(name, lab, counts, type, cat1, cat2, cat3, cat4))

dat <- rbind(current, useful)
print(head(dat))



# shinyUI(
#   fluidPage(
#     div(style="padding: 1px 0px; width: '100%'",
#         titlePanel(
#           title="", windowTitle="ALSPAC data dictionary"
#         )
#     ),


#     navbarPage(title=div(img(src="alspac.png"), "ALSPAC data dictionary"),
#       inverse=FALSE,
#       theme = shinytheme("united"),


#   typeaheadInput("typeahead_search", "Search", "", choices=dat$lab, items=20, minLength=2),
#   h1('Browse variables available in ALSPAC'),
#   tabsetPanel(
#     tabPanel("Variables", 
#       fluidRow(
#         column(8, DT::dataTableOutput('x3')),
#         column(4, verbatimTextOutput('x4'),
#         	uiOutput("makebutton")
#         )
#       )
#     ),
#   	tabPanel("About",
#       fluidRow(
#       	column(4,
#       	  p("This website can be used to browse the available variables for the ALSPAC data resource."),
#       	  p("To request the variables of interest, select them by clicking on the relevant rows in the table, and then click 'Export'. This will create an Excel file that you can send to the data team.")
#       	)
#       )
#     )
#   )
# )))


# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Define UI for application

# Include a fliudPage above the navbar to incorporate a icon in the header
# Source: http://stackoverflow.com/a/24764483
# fluidPage(
# div(style="padding: 1px 0px; width: '100%'",
# 	titlePanel(
# 		title="", windowTitle="ALSPAC data dictionary"
# 	)
# ),




aboutpage <- function()
{
	tabPanel(title="About", value="aboutpage", icon = icon("cog"),

		# Jumbotron
		div(
			class="jumbotron", 
			position="bottom",
			h1("Search for variables in the ALSPAC data dictionary")
			# typeaheadInput("typeahead_search", "Search", "", choices=dat$lab, items=20, minLength=2)
		),

		# Main body
		fluidRow(
			column(6,
				fluidRow(column(12, panel_div(
					class_type="primary", 
					panel_title="About ALSPAC",
					content=
						div(
							tags$p("The Avon Longitudinal Study of Parents and Children (ALSPAC), also known as Children of the 90s, is a world-leading birth cohort study, charting the health of 14,500 families in the Bristol area. You can find full information about the cohort ", tags$a("here", href="https://www.bristol.ac.uk/alspac/"))
						)
				))),
				fluidRow(column(12, panel_div(
					class_type="primary", 
					panel_title="The variable search tool",
					content=
						div(
							tags$p("For more than two decades clinic and questionnaire data has been collected from the participants."),
							tags$p("There are currently ", tags$strong(nrow(dat)), " variables that are currently available to researchers."),
							tags$p("Use this resource to search through the variables, obtain their identifiers and number of available samples."),
							tags$p("You can use download lists of selected variables. For direct users, this can be used to extract variables directly. Alternatively, add this list to your data request form to specify the data that you require.")
						)
				)))
			),
			column(6,
				panel_div(
					class_type="secondary",
					panel_title="News",
					content=
						div(
							panel_div(class_type="warning", panel_title="01/01/2017",
								content="Something happened"
							),
							panel_div(class_type="warning", panel_title="01/01/2017",
								content="Something happened"
							),
							panel_div(class_type="warning", panel_title="01/01/2017",
								content="Something happened"
							),
							panel_div(class_type="warning", panel_title="01/01/2017",
								content="Something happened"
							)
						)
				)
			)
		)
	)
}

library(dplyr)


variablespage <- function()
{
	tabPanel(title="Variables", value="variablespage", icon = icon("search"),
		fluidRow(
			column(8,
				tags$div(class="labeltags text-center",
					uiOutput("laba")
				)
			),
			column(4,
      	verbatimTextOutput('x4'),
      	uiOutput("makebutton")
			)
		),
		# fluidRow(
		# 	column(12,
		# 		typeaheadInput("typeahead_search2", "Search", "", choices=dat$lab, items=20, minLength=2)
		# 	)
		# ),
		fluidRow(
			column(12, DT::dataTableOutput('x3'))
		)
	)
}


shinyUI(

navbarPage(
	id="mainnav",
	title=div("ALSPAC data dictionary"),
	inverse = FALSE, # for diff color view
	theme = shinytheme("united"),


	aboutpage(),
	variablespage()







	)
)
	