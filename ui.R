library(ggplot2)

fluidPage(
  navbarPage("World Population",
    #tabsetPanel(type = "tabs",
                
                tabPanel("General Map",
                        # sidebarPanel(#"lol",
                       # selectInput("region", "Region:", 
                        #           choices=list)),
                       #  mainPanel(
                        #   leafletOutput("map",height = 900, width = 900))
                  mainPanel(
                  print("Population over different countries:"),
                 leafletOutput("map",height = 1000, width = 1200))
                ),
                         #plotOutput(outputId = "hist")
                
                tabPanel("Show Data",
                         sidebarPanel(
                           selectInput("data_table_output", "Choose the data to explore:",
                                       choices = list_norms),
                           selectInput("pays1_table_output", "Country 1:",
                                       choices = pop_data$Country.Name),
                           selectInput("pays2_table_output", "Country 2:",
                                       choices = pop_data$Country.Name),
                           sliderInput("nombre_de_colones", "Select an interval of time:",
                                       min = 1960, max = 2017,
                                       value = c(2015,2017))
                         ),
                         mainPanel(
                           DT::dataTableOutput("table")
                         )),
    
                
                tabPanel("Comparison",  
                         sidebarPanel(
                           selectInput("comp_norm", "Comparison norm:",
                                       choices = list_norms),
                           checkboxInput(inputId = "par_annee",
                                         label = strong("Select a year"),
                                         value = FALSE),
                           #radioButtons("radio_button_choice", "Comparison type:", choices = list_radioButtonsChoices),
        
                           conditionalPanel(condition = "input.par_annee == true",
                                            conditionalPanel(condition = "input.comp_norm == 'Migration nette'",
                                                             selectInput("annee_mig", "Year:",
                                                                         choices = list_years_for_migration)
                                            ),
                                            conditionalPanel(condition = "input.comp_norm != 'Migration nette'",
                                                             selectInput("annee_notmig", "Year:",
                                                                         choices = list_years))
                           ),
                           selectInput("pays1", "Country 1:",
                                       choices = pop_data$Country.Name),
                           selectInput("pays2", "Country 2:",
                                       choices = pop_data$Country.Name)#,
                           #submitButton("See results")
                          ),
                           mainPanel(
                             plotOutput("plot_comparison", height = "600", width="700")
                           )
                         ),
                
    
                tabPanel("Summary", 
                         sidebarPanel(
                           selectInput("data_summary", "Choose the data:",
                                       choices = list_norms),
                           conditionalPanel(condition = "input.data_summary == 'Migration nette'",
                                            selectInput("year_summary_mig", "Choose a year:",
                                                        choices = list_years_for_migration)
                           ),
                           conditionalPanel(condition = "input.data_summary != 'Migration nette'",
                                            selectInput("year_summary_notmig", "Choose a year:",
                                                        choices = list_years))
                         
                         ),
                         mainPanel(verbatimTextOutput("summary"))
                        ),
                
                
                
                tabPanel("Predictions", tableOutput("predictions"),
                         sidebarPanel(
                           selectInput("pays_pred", "Pays :",
                                       choices = pop_data$Country.Name),
                           numericInput("annee_pred", "Année:", min = 2018, value = 2018)#,
                           #submitButton("See results")
                         ),
                         mainPanel(
                           textOutput("prediction")
                         )
                     #    )
    
   )    
  )
)
         
