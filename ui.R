#install.packages("shinythemes", "C:/R/R-3.4.2")
library(shiny)
#library(shinythemes)

windowsFonts(BL = windowsFont("微軟正黑體"))

renderInputs <- function(prefix) {
  
  wellPanel(
    
    fluidRow(
      
      column(6,
             
             # sliderInput(paste0(prefix, "_", "n_obs"), "Number of observations (in Years):", min = 0, max = 40, value = 20),
             
             # sliderInput(paste0(prefix, "_", "start_capital"), "總投資預算 :", min = 100000, max = 10000000, value = 2000000, step = 100000, pre = "$", sep = ","),
             
             numericInput(paste0(prefix, "_", "start_capital"), "總投資預算(萬) :", min = 10, max = 100, value = 10, step = 10),
             
             selectizeInput(paste0(prefix, "_", "annual_mean_return"), "風險態度 :", choices =  list("保守" = 0.3, "穩健" = 0.4, "穩健偏積極" = 0.6, "積極" = 0.8),selected=NULL),
             
             selectInput("input_type", "基金選擇 :", choices = c("智能挑選","達人自選"))
             
             # sliderInput(paste0(prefix, "_", "annual_mean_return"), "Annual investment return (in %):", min = 0.0, max = 30.0, value = 5.0, step = 0.5),
             
             # sliderInput(paste0(prefix, "_", "annual_ret_std_dev"), "Annual investment volatility (in %):", min = 0.0, max = 25.0, value = 7.0, step = 0.1)
             
      )
      ,column(6, wellPanel(
        # This outputs the dynamic UI component
        uiOutput("ui")
      ))
      # ,column(6,
      #        
      #        sliderInput(paste0(prefix, "_", "annual_inflation"), "Annual inflation (in %):", min = 0, max = 20, value = 2.5, step = 0.1),
      #        
      #        sliderInput(paste0(prefix, "_", "annual_inf_std_dev"), "Annual inflation volatility. (in %):", min = 0.0, max = 5.0, value = 1.5, step = 0.05),
      #        
      #        sliderInput(paste0(prefix, "_", "monthly_withdrawals"), "Monthly capital withdrawals:", min = 1000, max = 100000, value = 10000, step = 1000, pre = "$", sep = ","),
      #        
      #        sliderInput(paste0(prefix, "_", "n_sim"), "Number of simulations:", min = 0, max = 2000, value = 50)
      #        
      # )
      
    ),
    
    p(actionButton(paste0(prefix, "_", "recalc"),
                   
                   "Re-run simulation", icon("random")
                   
    ))
    
  )
  
}



# Define UI for application that plots random distributions

fluidPage(theme="simplex.min.css",
#fluidPage(theme="superhero",
          tags$style(type="text/css",
                     
                     "label {font-size: 12px;}",
                     
                     ".recalculating {opacity: 1.0;}"
                     
          ),
          
          
          
        
          
          
          
          fluidRow(
            
            #column(6, tags$h3("Scenario A")),
            
            column(12, tags$h3("野村理財機器人"))
            
          ),
          
          fluidRow(
            
            #column(6, renderInputs("a")),
            
            column(12, renderInputs("b"))
            
          ),
          
          fluidRow(
            
           # column(6,
                   
            #       plotOutput("a_distPlot", height = "600px")
                   
           # ),
            
            column(12,
                   
                   plotOutput("b_distPlot", height = "600px")
                   
            )
            
          )
          
)