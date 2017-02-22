# correlation simulation ui.R

library(shiny)
library(ggplot2)

shinyUI(pageWithSidebar(
	
	headerPanel("Correlation Simulation"),

	sidebarPanel(
				 sliderInput("r",
							 "Correlation coefficient:",
							 min=-.99,
							 max=.99,
							 value=0.0),
				 sliderInput("n",
							 "Number of observations:",
							 min=5,
							 max=1000,
							 value=50),
				 h3(textOutput("rvalue")),
				 h3(textOutput("pvalue"))
				 ),

	mainPanel(
			  plotOutput("corrPlot", width='500px', height='500px')
			  )
	))






