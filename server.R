# correlation simulation server.R

library(shiny)
library(ecodist)
library(ggplot2)
library(dplyr)

# scale to -.5 to .5
bound <- function(x) return(((x - min(x))/(max(x)-min(x))) - .5)

shinyServer(function(input, output) {

		#output$corrPlot <- renderPlot({
		#		xy.corr <- corgen(len=input$n, r=input$r)
		#		plot(xy.corr)
		#})

		output$corrPlot <- renderPlot({
				xy.corr <- as.data.frame(corgen(len=input$n, r=input$r))
				
				# scale the data
				xy.corr <- xy.corr %>%
				  mutate(x = bound(x), y=bound(y))
				
				print(ggplot(xy.corr, aes(x=x, y=y)) + geom_point() +
					  theme(axis.text.x=element_blank(),
							axis.text.y=element_blank()) + theme_minimal() +
					    ylim(c(-.5,.5)) + xlim(c(-.5,.5))
					  )
		})

		output$rvalue <- reactive({paste("r =", input$r)})
					
		output$pvalue <- reactive({
				s <- (input$r * sqrt(input$n-2))/sqrt(1-input$r^2)
				p <- round(pt(abs(s), input$n-2, lower.tail=FALSE), 3)
				return(ifelse(p > 0, paste("p =", p), "p < .001"))

			})
		})


