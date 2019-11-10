library(stringr)

server <- function(input,output, session){
  
  data <- reactive({
    x <- df
  })
  
  #output$mymap <- renderLeaflet({
   #   df <- data()
    #  m <- leaflet(data = df) %>%
     #   addTiles() %>%
      # addCircles(weight = 1, radius = sqrt(df$Population)*40)
  #  } else if (input$exploration_options == "Birthrate"){
   #   df <- data()
    #  m <- leaflet(data = df) %>%
     #   addTiles() %>%
      #addCircles(weight = 1, radius = sqrt(as.double(df$Birthrate))*20000)
    #} else if (input$exploration_options == "Deathrate"){
     # df <- data()
      #m <- leaflet(data = df) %>%
       # addTiles() %>%
      #addCircles(weight = 1, radius = sqrt(as.double(df$Deathrate))*20000)
    #}
    
   
   
   
   # addLabelOnlyMarkers(lng = ~longitude,
    #                    lat = ~latitude,
     #                   label = paste("Deathrate:", df$Deathrate, "<br>",
      #                                "Migration:", df$Net.migration),
       #                 labelOptions = labelOptions(noHide = T))
     
# })
  
  output$map <- renderLeaflet({
    df <- data()
    df_filtred <- df # filter(df ,str_detect(df[,4], input$region)) 
    m <- leaflet(data = df_filtred) %>%
    addTiles() %>%
      addCircles( weight = 1, radius = sqrt(df_filtred$Population)*40)
     addMarkers(map = m, lng = ~longitude,
                     lat = ~latitude,
                     popup = paste("Deathrate:", df$Deathrate, "<br>",
                                   "Birthrate:", df$Birthrate))
    
  })
  
  output$table <- DT::renderDataTable({
    if(input$data_table_output == "Population"){
      min_max_year <-  input$nombre_de_colones
      columns_for_output <- seq(min_max_year[1], min_max_year[2], 1)
      data_for_output <- subset(pop_data, select = c("Country.Name", "Indicator.Name", colnamyze(columns_for_output)))
      data_for_output <- data_for_output %>% filter(Country.Name == input$pays1_table_output | Country.Name == input$pays2_table_output)
      DT::datatable(data_for_output)
    } else if (input$data_table_output == "Birthrate"){
      min_max_year <-  input$nombre_de_colones
      columns_for_output <- seq(min_max_year[1], min_max_year[2], 1)
      data_for_output <- subset(birthrate_data, select = c("Country.Name", "Indicator.Name", colnamyze(columns_for_output)))
      data_for_output <- data_for_output %>% filter(Country.Name == input$pays1_table_output | Country.Name == input$pays2_table_output)
      DT::datatable(data_for_output)
    } else if (input$data_table_output == "Deathrate"){
      min_max_year <-  input$nombre_de_colones
      columns_for_output <- seq(min_max_year[1], min_max_year[2], 1)
      data_for_output <- subset(deathrate_data, select = c("Country.Name", "Indicator.Name", colnamyze(columns_for_output)))
      data_for_output <- data_for_output %>% filter(Country.Name == input$pays1_table_output | Country.Name == input$pays2_table_output)
      DT::datatable(data_for_output)
    } else if (input$data_table_output == "Migration nette"){
      min_max_year <-  input$nombre_de_colones
      columns_for_output <- seq(min_max_year[1], min_max_year[2], 1)
      data_for_output <- subset(net_migration_data, select = c("Country.Name", "Indicator.Name", colnamyze(columns_for_output)))
      data_for_output <- data_for_output %>% filter(Country.Name == input$pays1_table_output | Country.Name == input$pays2_table_output)
      DT::datatable(data_for_output)
    }
  })
  
  output$plot_comparison <- renderPlot({
    
    if(input$comp_norm == "Population"){
      vector_1 <- over_years(input$pays1, pop_data)
      vector_2 <- over_years(input$pays2, pop_data)
    } else if (input$comp_norm == "Birthrate"){
      vector_1 <- over_years(input$pays1, birthrate_data)
      vector_2 <- over_years(input$pays2, birthrate_data)
    } else if (input$comp_norm == "Deathrate"){
      vector_1 <- over_years(input$pays1, deathrate_data)
      vector_2 <- over_years(input$pays2, deathrate_data)
    } else if (input$comp_norm == "Migration nette"){
      vector_1 <- over_years(input$pays1, net_migration_data)
      vector_2 <- over_years(input$pays2, net_migration_data)
    }
   # observeEvent(input$radio_button_choice,
    #             {
     #              insertUI( selector = "#radio_button_choice",  where = "afterEnd", multiple = T,
      #                       ui = selectInput("annee", "Année:",
       #                                       choices = list_years))
        #           removeUI(
         #            selector = "#radio_button_choice", multiple = F, session = 
          #         )
           #      }) 
    
    if (input$par_annee){
      
      for (i in 1:58) {
        if ((str_detect(list_years[i], input$annee_mig) == T )||(str_detect(list_years[i], input$annee_notmig) == T )){
          pays_by_year_1 <- vector_1[i]
          pays_by_year_2 <- vector_2[i]
        } 
      }
      
      barplot(height = c(pays_by_year_1,pays_by_year_2), xlab = "Pays", names.arg = c(input$pays1, input$pays2), beside = T)  
    }else{
      plot(list_years_numeric, vector_1, type = "l", col = "Red", lwd = "10", xlab = "Années", ylab = input$comp_norm)
      lines(list_years_numeric, vector_2, col = "Blue", lwd = "10")
      legend("topleft", legend=c(input$pays1, input$pays2), col=c("red", "blue"), lty = 1:2, cex = 2.6)
    }
    
    
  })
  
  output$summary <- renderPrint({
    if(input$data_summary == "Population"){
      summary(pop_data[[colnamyze(input$year_summary_notmig)]])
    } else if (input$data_summary == "Birthrate"){
      summary(birthrate_data[[colnamyze(input$year_summary_notmig)]])
    } else if (input$data_summary == "Deathrate"){
      summary(deathrate_data[[colnamyze(input$year_summary_notmig)]])
    } else if (input$data_summary == "Migration nette"){
      summary(net_migration_data[[colnamyze(input$year_summary_mig)]])
    }
    
  })
  
  
  output$prediction <- renderText({
    pr <- predict_population(input$annee_pred, input$pays_pred)
    sprintf("La population estimée est supérieure à: %iK", floor(pr))
  })
}