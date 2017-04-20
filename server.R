library(shiny)
library(DT)
library(alspac)
data(current)
data(useful)

current <- subset(current, select=c(name, lab, counts, type, cat2, cat3, cat4))
useful <- subset(useful, select=c(name, lab, counts, type, cat2, cat3, cat4))

print_rows <- function(s, dat)
{
	cat(
		paste0(dat$name[s], ": ", dat$lab[s]), sep='\n'
	)
}

shinyServer(function(input, output, session) {
	output$x3 = DT::renderDataTable(current)
	output$x4 = renderPrint({
	s = input$x3_rows_selected
	if (length(s)) {
	  cat('These rows are currently selected:\n\n')
	  print_rows(s, current)
	}
	})

	output$y3 = DT::renderDataTable(useful)
	output$y4 = renderPrint({
	s = input$y3_rows_selected
	if (length(s)) {
	  cat('These rows are currently selected:\n\n')
	  print_rows(s, useful)
	}
	})

})
