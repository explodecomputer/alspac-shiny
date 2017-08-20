library(shiny)
library(DT)
library(alspac)
data(current)
data(useful)

current <- subset(current, ! name %in% c("aln", "qlet"), select=c(name, lab, counts, type, cat1, cat2, cat3, cat4))
useful <- subset(useful, ! name %in% c("aln", "qlet"), select=c(name, lab, counts, type, cat1, cat2, cat3, cat4))

dat <- rbind(current, useful)
names(dat) <- c("Variable", "Details", "Counts", "Type", "Release", "Label 1", "Label 2", "Label 3")

print_rows <- function(s, dat)
{
	cat(
		paste0(dat$Variable[s], ": ", dat$Details[s]), sep='\n'
	)
}

shinyServer(function(input, output, session) {
	output$x3 = DT::renderDataTable(dat)
	output$x4 = renderPrint({
	s = input$x3_rows_selected
	if (length(s)) {
		cat('These rows are currently selected:\n\n')
		print_rows(s, dat)
		output$makebutton <- renderUI(
			downloadButton('downloadData', 'Download variable list')
		)
	}
	})

	output$downloadData <- downloadHandler(
		filename = function() {
			paste('data-', Sys.Date(), '.csv', sep='')
		},
		content = function(con) {
			index <- as.numeric(input$x3_rows_selected)
			write.csv(dat[index,], con, row.names=FALSE)
		})

})



