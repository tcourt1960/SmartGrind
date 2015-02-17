library(shiny)
# library("caret")
# library("e1071")
library("randomForest")
# library(UsingR)


shinyUI(fluidPage(
  
  titlePanel("Gear Grinding - Machine Learning App"),
  h5("Precise Gears, such as those used in a Mercedes transmission, are often Ground to precision.", align = "center"),
  h5("This app uses historical Engineering datasets to predict  specific Gear Grinding machine settings and speeds.", align = "center"),
  sidebarPanel(
    
    
    sliderInput('I_dFa', 
                'Select Gear Outside Diameter',
                value = 100, 
                min = 0, 
                max = 350, 
                step = 10),
    sliderInput('I_bw', 
                'Select Gear Face Width',
                value = 27, 
                min = 0, 
                max = 104, 
                step = 1.0),
    sliderInput('I_m', 
                'Select Gear Module',
                value = 2.3, 
                min = 0, 
                max = 7, 
                step = 0.1),
    sliderInput('I_kWheel', 
                'Select I_kWheel',
                value = 500, 
                min = 320, 
                max = 1600, 
                step = 20.0),
    sliderInput('I_z0', 
                'Select number of threads/starts',
                value = 4, 
                min = 1, 
                max = 7, 
                step = 1),
    sliderInput('I_x', 
                'Select Profile modification factor',
                value = 0.1, 
                min = -5, 
                max = 12, 
                step = .1),

    sliderInput('I_dFf', 
                'Select True Involute Form Diameter',
                value = 100, 
                min = 0, 
                max = 350, 
                step = 10),
    
    sliderInput('I_df', 
                'Select Gear Root Diameter',
                value = 100, 
                min = 0, 
                max = 325, 
                step = 10),
    sliderInput('I_Fr', 
                'Select assumed Runout error',
                value = .05, 
                min = 0, 
                max = 0.12, 
                step = 0.01),
    sliderInput('I_z', 
                'Select number of Teeth',
                value = 48, 
                min = 4, 
                max = 175, 
                step = 1),
    
    sliderInput('I_a', 
                'Select Pressure Angle',
                value = 15, 
                min = 0, 
                max = 27, 
                step = 1),
    
    sliderInput('I_b', 
                'Select Helix Angle',
                value = 17, 
                min = 0, 
                max = 35, 
                step = 1),



    sliderInput('I_Ds', 
                'Select Amount of Stock per Flank',
                value = .10, 
                min = 0, 
                max = .25, 
                step = 0.01),

    sliderInput('I_cb', 
                'Select Amount of Lead Crowing',
                value = 5, 
                min = 0, 
                max = 80, 
                step = 1.0),
    sliderInput('I_k', 
                'Select I_k',
                value = 3, 
                min = 1, 
                max = 12, 
                step = 1),

    sliderInput('I_Abricht.methode', 
                'Select Abricht dressing method',
                value =3 , 
                min = 0, 
                max = 3, 
                step = 1.0),
    
#     sliderInput('I_Zahnfuß', 
#                 'Grind the root? 2-Yes, 1:no',
#                 value = 2, 
#                 min = 1, 
#                 max = 2, 
#                 step = 1),
    sliderInput('I_d0', 
                'Select Outside Diameter of Wheel',
                value = 190, 
                min = 190, 
                max = 195, 
                step = 1),
    sliderInput('I_b0', 
                'Select Wheel Width',
                value = 180, 
                min = 125, 
                max = 180, 
                step = 5),

    sliderInput('I_vcI', 
                'Select Cutting Speed',
                value = 55, 
                min = 50, 
                max = 65, 
                step = 1)


  ),

  
  mainPanel(
    
    h3(""),
    h4("** When you first run this App, please wait for the calculations to complete and histogram to be displayed below. This may take up to 60 seconds**",align="center"),
    h6("<---- Click on sliders at the left to select different Gear Geometries."),
    h6("The website uses a RandomForest Machine Learning algorithm."),
    h3(""),
    h6("The predicted Gear Grinding settings and speeds will be shown as a red vertical line."),
    h6("The histograms shown represent the distribution of the data in the training set."),
    h6("You can click on the other tabs to reveal additional predictions"),
    
    tabsetPanel(type="tab",
                tabPanel("Grinding Time",plotOutput('tgrindHist')),
                tabPanel("Feedrate",plotOutput('fr')),
                tabPanel("Q prime",plotOutput('Q.wr'))
                )
   
  )

))