######################## server.R

shinyServer(function(input, output) {
  
  
  
  ########## Create plotly graphs for report tab summarizing All Pages
  output$step1 <- renderPlotly({
    
    stepData1 <- organic_summ_gather[(organic_summ_gather$Metric %in% c("total_arrivals","step_1","step_2","step_3","buys")),]
    
    stepData1$Metric <- factor(stepData1$Metric,
                               levels = c("total_arrivals","step_1","step_2","step_3","buys"))
    
    
    f1 <- list(
      family="Arial, sans-serif",
      size=18,
      color="black")
    
    fx1 <- list(
      family="Arial, sans-serif",
      titlefont = f1,
      rangemode="tozero",
      title = "Month"
    )
    
    fy1 <- list(
      family="Arial, sans-serif",
      titlefont = f1,
      rangemode="tozero",
      title = "Volume"
    )
    
    plot_ly(stepData1, x=~stepData1$month, y=~Value,
            type="scatter",
            mode="lines",
            color=~Metric,
            showlegend=TRUE,
            line = list(
              width=4
            )) %>%
      layout(legend=list(x=1, y=1, size=20),
             xaxis=fx1,
             yaxis=fy1)
    
  })
  
  
  
  # Create trended plot showing conversion rates of each step in the website process, starting with 'arrivals' and ending with 'buys'
  output$stepConversions1 <- renderPlotly({
    
    #organic_summ_gathIn <- organic_summ_gath()
    
    stepConversionsData1 <- organic_summ_gath[(organic_summ_gath$Metric %in% c("arrivals_conversion","step1_conv","step2_conv","step3_conv")),]
    
    stepConversionsData1$Metric <- factor(stepConversionsData1$Metric,
                                          levels = c("arrivals_conversion","step1_conv","step2_conv","step3_conv"))
    
    
    f1 <- list(
      family="Arial, sans-serif",
      size=18,
      color="black")
    
    fx1 <- list(
      family="Arial, sans-serif",
      titlefont = f1,
      rangemode="tozero",
      title = "Month"
    )
    
    fy1 <- list(
      family="Arial, sans-serif",
      titlefont = f1,
      rangemode="tozero",
      title = "Conversion %"
    )
    
    plot_ly(stepConversionsData1, x=~stepConversionsData1$month, y=~Value,
            type="scatter",
            mode="lines",
            color=~Metric,
            showlegend=TRUE,
            line = list(
              width=4
            )) %>%
      layout(legend=list(x=1, y=1, size=20),
             xaxis=fx1,
             yaxis=fy1)
    
  })
  
  
  
  
  output$sales1   <- DT::renderDataTable(filter='top',
                                         rownames= FALSE,
                                         options = list(scrollX=TRUE, rownames= FALSE,pageLength = 50,lengthMenu = c(10, 50, 100, 200)),{
                                           isolate(    
                                             organic_summ_sales
                                           )
                                         })
  
  
  
  
  ################# Create reactive tables for Page Specific summaries #########################################################################################
  leadsSumm2 <- reactive({
    
    organic_page_gather[(organic_page_gather$Metric == eval(paste0(input$pageFilterSteps))),]
    
  })
  
  
  
  # Gathered summary for the Page Specific sales
  organic_summ_sales2 <- reactive({
    
    organic_summ_page_specific[(organic_summ_page_specific$site_page == input$pageFilterSales),
                               c('month','site_page','buys','total_revenue','gross_spread','gross_spread_perc','spread_per_unit','cost_per_unit','salePrice_per_unit')]
    
    
  })
  
  
  
  
  
  
  ########## Create plotly graphs for report tab summarizing Page Specific values
  output$step2 <- renderPlotly({
    
    organic_page_input1 <- organic_page_gather[(organic_page_gather$Metric %in% c("total_arrivals","step_1","step_2","step_3","buys")),]
    
    organic_page_input1$Metric <- factor(organic_page_input1$Metric,
                                         levels = c("total_arrivals","step_1","step_2","step_3","buys"))
    
    #step2Data$Monthly <- as.Date(step2Data$Monthly, '%Y-%m-%d')
    
    f1 <- list(
      family="Arial, sans-serif",
      size=18,
      color="black")
    
    fx1 <- list(
      family="Arial, sans-serif",
      titlefont = f1,
      rangemode="tozero",
      title = "Month")
    
    fy1 <- list(
      family="Arial, sans-serif",
      titlefont = f1,
      rangemode="tozero",
      title = "Volume")
    
    plot_ly(organic_page_input1, x=~organic_page_input1$month, y=~Value,
            type="scatter",
            mode="lines",
            color=~Metric,
            showlegend=TRUE,
            line = list(
              width=4
            )) %>%
      layout(legend=list(x=1, y=1, size=20),
             xaxis=fx1,
             yaxis=fy1)
    
  })
  
  
  
  
  
  # Create trended plot showing conversion rates of each step in the website process, starting with 'arrivals' and ending with 'buys'
  # Make plot dynamic based on user's inputs of which page in the website to report on
  output$stepConversions2 <- renderPlotly({
    
    organic_page_input2 <- organic_page_gather[(organic_page_gather$Metric %in% c("arrivals_conversion","step1_conv","step2_conv","step3_conv")),]
    
    organic_page_input2$Metric <- factor(organic_page_input2$Metric,
                                         levels = c("arrivals_conversion","step1_conv","step2_conv","step3_conv"))
    
    f1 <- list(
      family="Arial, sans-serif",
      size=18,
      color="black")
    
    fx1 <- list(
      family="Arial, sans-serif",
      titlefont = f1,
      rangemode="tozero",
      title = "Month"
    )
    
    fy1 <- list(
      family="Arial, sans-serif",
      titlefont = f1,
      rangemode="tozero",
      title = "Conversion %"
    )
    
    plot_ly(organic_page_input2, x=~organic_page_input2$month, y=~Value,
            type="scatter",
            mode="lines",
            color=~Metric,
            showlegend=TRUE,
            line = list(
              width=4
            )) %>%
      layout(legend=list(x=1, y=1, size=20),
             xaxis=fx1,
             yaxis=fy1)
    
  })
  
  
  output$sales2 <- DT::renderDataTable(filter='top',
                                       rownames= FALSE,
                                       options = list(scrollX=TRUE, rownames= FALSE,pageLength = 50,lengthMenu = c(10, 50, 100, 200)),
                                       {
                                         organic_summ_sales2()
                                       })
  
  
  
})