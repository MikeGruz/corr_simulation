# correlation simulation server.R

library(shiny)
library(ecodist)
library(ggplot2)
library(dplyr)

# scale data from -.5 to .5
bound <- function(x) return(((x - min(x))/(max(x)-min(x))) - .5)

shinyServer(function(input, output) {

		output$corrPlot <- renderPlot({
				xy.corr <- as.data.frame(corgen(len=input$n, r=input$r))
				
				# scale the data
				xy.corr <- xy.corr %>%
				  mutate(x = bound(x), y=bound(y))
				
				# scatterplot
				ggplot(xy.corr, aes(x=x, y=y)) + geom_point() +
					  theme(axis.text.x=element_blank(),
							axis.text.y=element_blank()) + theme_minimal() +
					    ylim(c(-.5,.5)) + xlim(c(-.5,.5))
					  
		})

		# display r value from input slider
		output$rvalue <- reactive({paste("r =", input$r)})
					
		# display p-value 
		output$pvalue <- reactive({
				s <- (input$r * sqrt(input$n-2))/sqrt(1-input$r^2)
				p <- round(pt(abs(s), input$n-2, lower.tail=FALSE), 3)
				
				# return exact p if > .001, else p < .001
				return(ifelse(p > 0, paste("p =", p), "p < .001"))

			})
		})


