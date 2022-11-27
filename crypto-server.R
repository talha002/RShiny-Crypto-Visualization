pacman::p_load(shiny, shinythemes, DT, plotly, ggplot2, scales, gridExtra,
               dplyr, hrbrthemes)


library(datasets)
df <- read.csv('crypto_markests_R1.csv')
df$date <- as.Date(df$date, "%Y-%m-%d")
df$months <- as.Date(df$months, "%Y-%m-%d")
df$years <- as.Date(df$years, "%Y-%m-%d")


#Front-end of the web-site
ui <- fluidPage(
  theme = shinytheme("yeti"),
  navbarPage("Cryptocurrencies Visualisation",
             
            #Tab for Data-Set Description
            tabPanel("Cryptocurrencies Dataset",
                      mainPanel(width = 12,
                                h2("The Cryptocurrency Data"),
                                br(),
                                #Description of the dataset
                                fluidRow(style="margin-left: 5px",
                                         h3("Description"),
                                         p("All historic open, high, low, close, 
                                           trading volume and market cap info for 
                                           all cryptocurrencies between 2013-2018."),
                                         br(),
                                         h3("Columns:"),
                                         p("Date: The day of the observation taken.
                                           It's between 28 Apr 2013 and 21 May 2018."),
                                         p("Open: Currency open value"),
                                         p("Close: Currency close value"),
                                         p("High: Currency highest value"),
                                         p("Market: Currency quantity*price"),
                                         p("Spread: Currency highest value - lowest value"),
                                         p("Volume: Movement of currency"),
                                         p("Close Ratio: Close-Low/High-Low"),
                                         br(),
                                         h3("Link of the  Data-set:"),
                                         a(href="https://www.kaggle.com/datasets/jessevent/all-crypto-currencies",
                                           "https://www.kaggle.com/datasets/jessevent/all-crypto-currencies")
                                ),
                                br(),
                                #Table of the dataset
                                h2("Table of the Data-set"),
                                DT::dataTableOutput("mytable"),
                                br(),
                                br()
                                
                                )),
            
             #tab of Scatter Plot
             tabPanel("Scatter Plot",
                      mainPanel(width = 12,
                        #Scatter Plot Output
                        fluidRow(plotlyOutput("scatter"), style="height:800px"),
                        
                        #Panel of Scatter Plot
                        fluidRow(h1("Panel"),
                                 
                                 #settings of X-axis.
                                 column(3,
                                        h3("X-axis Settings"),
                                        numericInput("scatterXlimUp", 
                                                     "X-axis Upper Limit:",
                                                     11000, min=0, max=326502485530),
                                        numericInput("scatterXlimLow", 
                                                     "X-axis Lower Limit:",
                                                     0, min=0, max=326502485530),
                                        numericInput("scatterXstep", 
                                                     "X-axis steps:",
                                                     500, min=1),
                                        selectInput("scatterXvariable", "X-Variable:",
                                                    c("open", "high", "low", "close",
                                                      "market", "close_ratio", "ranknow",
                                                      "spread", "volume"), 
                                                    selected="high")
                                        ),
                                 
                                 #settings of Y-axis
                                 column(3,
                                        h3("Y-axis Settings"),
                                        numericInput("scatterYlimUp", 
                                                    "Y-axis Upper Limit:",
                                                    2500, min=0, max=326502485530),
                                        numericInput("scatterYlimLow", 
                                                    "Y-axis Lower Limit:",
                                                    0, min=0, max=326502485530),
                                        numericInput("scatterYstep", 
                                                    "Y-axis steps:",
                                                    250, min=1),
                                        selectInput("scatterYvariable", "Y-Variable:",
                                                    c("open", "high", "low", "close",
                                                      "market", "close_raito", "ranknow",
                                                      "spread", "volume"), 
                                                    selected="spread")
                                        ),
                                 
                                 #currency options
                                 column(3,
                                        h3("Currencies"),
                                        selectInput("scatterFrstOpt", "First Option:",
                                                    c(unique(df$slug)),
                                                    selected="bitcoin"),
                                        selectInput("scatterScndOpt", "Second Option:",
                                                    c(unique(df$slug)),
                                                    selected="ethereum"),
                                        selectInput("scatterTrdOpt", "Third Option:",
                                                    c(unique(df$slug)),
                                                    selected="ripple"),
                                        selectInput("scatterFrthOpt", "fourth Option:",
                                                    c(unique(df$slug)),
                                                    selected="rabbitcoin")
                                        ),
                                 
                                 column(3,
                                        br(),
                                        checkboxInput("scatterReg", "Regression Line"),
                                        selectInput("scatterFifthOpt", "Fifth Option:",
                                                    c(unique(df$slug)),
                                                    selected="cardano"),
                                        selectInput("scatterSxthOpt", "Sixth Option:",
                                                    c(unique(df$slug)),
                                                    selected="litecoin"),
                                        selectInput("scatterSvnOpt", "Seventh Option:",
                                                    c(unique(df$slug)),
                                                    selected="eos"),
                                        selectInput("scatterEithOpt", "Eigth Option:",
                                                    c(unique(df$slug)),
                                                    selected="nem")
                                        ),
                                 br()
                                 ))),
             
             #tab of Line Plot
             tabPanel("Line Plot",
                      mainPanel(width = 12,
                                #Line Plot Output
                                fluidRow(plotlyOutput("line"), style="height:800px"),
                                
                                #Panel of Line Plot
                                fluidRow(h1("Panel"),
                                         
                                         #settings of Date axis. (X-axis)
                                         column(3,
                                                h3("Date Settings (Please do not write down the date,
                                                  only choose a date from calender)"),
                                                dateInput("lineStartDate", 
                                                          "Line Date:", 
                                                          value='2018-01-01', 
                                                          format="dd/mm/yy"), 
                                                dateInput("lineEndDate", 
                                                          "End Date:", value='2018-12-01', 
                                                          format="dd/mm/yy"), 
                                                textInput("lineDateSteps",
                                                          "Please Enter The Step Format 
                                                  Of Date Axis (e.g. 15 days, 
                                                  1 month, 1 year)",
                                                          value="15 days")
                                                ),
                                         
                                         #settings of Y-axis
                                         column(3,
                                                h3("Y-axis Settings"),
                                                numericInput("lineYlimUp", 
                                                             "Y-axis Upper Limit:",
                                                             11000, min=0, max=326502485530),
                                                numericInput("lineYlimLow", 
                                                             "Y-axis Lower Limit:",
                                                             0, min=0, max=326502485530),
                                                numericInput("lineYstep", 
                                                             "Y-axis steps:",
                                                             500, min=1),
                                                selectInput("lineVariable", "Variable:",
                                                            c("open", "high", "low", "close",
                                                              "market", "close_ratio", "ranknow",
                                                              "spread", "volume"), 
                                                            selected="open")
                                         ),
                                         
                                         #currency options
                                         column(3,
                                                h3("Currencies"),
                                                selectInput("lineFrstOpt", "First Option:",
                                                            c(unique(df$slug)),
                                                            selected="bitcoin"),
                                                selectInput("lineScndOpt", "Second Option:",
                                                            c(unique(df$slug)),
                                                            selected="ethereum"),
                                                selectInput("lineTrdOpt", "Third Option:",
                                                            c(unique(df$slug)),
                                                            selected="ripple"),
                                                selectInput("lineFrthOpt", "fourth Option:",
                                                            c(unique(df$slug)),
                                                            selected="rabbitcoin")
                                         ),
                                         
                                         column(3,
                                                br(),
                                                checkboxInput("lineReg", "Regression Line"),
                                                selectInput("lineFifthOpt", "Fifth Option:",
                                                            c(unique(df$slug)),
                                                            selected="cardano"),
                                                selectInput("lineSxthOpt", "Sixth Option:",
                                                            c(unique(df$slug)),
                                                            selected="litecoin"),
                                                selectInput("linevnOpt", "Seventh Option:",
                                                            c(unique(df$slug)),
                                                            selected="eos"),
                                                selectInput("lineEithOpt", "Eigth Option:",
                                                            c(unique(df$slug)),
                                                            selected="nem")
                                         ),
                                         br()
                                ))),
             
             #tab of Bar Plot
             tabPanel("Bar Plot",
                      mainPanel(width = 12,
                                #Bar Plot Output
                                fluidRow(plotlyOutput("bar"), style="height:800px"),
                                
                                #Panel of Bar Plot
                                fluidRow(h1("Panel"),
                                         
                                         #settings of Date axis. (X-axis)
                                         column(4,
                                                h3("Date Settings (Please do not write down the date,
                                                  only choose a date from calender)"),
                                                dateInput("barStartDate", 
                                                          "Line Date:", 
                                                          value='2018-01-01', 
                                                          format="dd/mm/yy"), 
                                                dateInput("barEndDate", 
                                                          "End Date:", value='2018-12-01', 
                                                          format="dd/mm/yy"), 
                                                textInput("barDateSteps",
                                                          "Please Enter The Step Format 
                                                  Of Date Axis (e.g. 15 days, 
                                                  1 month, 1 year)",
                                                          value="1 month")
                                         ),
                                         
                                         #settings of Y-axis
                                         column(4,
                                                h3("Y-axis Settings"),
                                                numericInput("barYlimUp", 
                                                             "Y-axis Upper Limit:",
                                                             10000, min=0, max=326502485530),
                                                numericInput("barYlimLow", 
                                                             "Y-axis Lower Limit:",
                                                             0, min=0, max=326502485530),
                                                numericInput("barYstep", 
                                                             "Y-axis steps:",
                                                             1000, min=1),
                                                selectInput("barVariable", "Y-Variable:",
                                                            c("open", "high", "low", "close",
                                                              "market", "close_raito", "ranknow",
                                                              "spread", "volume"), 
                                                            selected="open")
                                         ),
                                        
                                         #grouping settings
                                         column(4,
                                                h3("Bar Settings"),
                                                checkboxInput("barTranspose",
                                                              "Tranpose the plot:"),
                                                selectInput("barDate", "Group By:",
                                                            c("months", "years"),
                                                            selected="months"),
                                                selectInput("barGroup", 
                                                           "Group Function:",
                                                           c("mean", "sum"),
                                                           selected="mean"),
                                                selectInput("barOpt", "Currency Option:",
                                                            c(unique(df$slug)),
                                                            selected="bitcoin")
                                                
                                         ),
                                         
                                         
                                         br()
                                ))),
             
             #tab of Box Plot
             tabPanel("Box Plot",
                      mainPanel(width = 12,
                                #Box Plot Output
                                fluidRow(plotlyOutput("box"), style="height:800px"),
                                
                                #Panel of box Plot
                                fluidRow(h1("Panel"),
                                         
                                         #settings of Date axis. (X-axis)
                                         column(3,
                                                h3("Date Settings (Please do not write down the date,
                                                  only choose a date from calender)"),
                                                dateInput("boxStartDate", 
                                                          "Line Date:", 
                                                          value='2018-01-01', 
                                                          format="dd/mm/yy"), 
                                                dateInput("boxEndDate", 
                                                          "End Date:", value='2018-12-01', 
                                                          format="dd/mm/yy"), 
                                                textInput("boxDateSteps",
                                                          "Please Enter The Step Format 
                                                  Of Date Axis (e.g. 15 days, 
                                                  1 month, 1 year)",
                                                          value="1 month")
                                         ),
                                         
                                         #settings of Y-axis
                                         column(3,
                                                h3("Y-axis Settings"),
                                                numericInput("boxYlimUp", 
                                                             "Y-axis Upper Limit:",
                                                             5, min=0, max=326502485530),
                                                numericInput("boxYlimLow", 
                                                             "Y-axis Lower Limit:",
                                                             0, min=0, max=326502485530),
                                                numericInput("boxYstep", 
                                                             "Y-axis steps:",
                                                             0.50, min=1),
                                                selectInput("boxFrstVariable", "Y-Variable:",
                                                            c("open", "high", "low", "close",
                                                              "market", "close_raito", "ranknow",
                                                              "spread", "volume"), 
                                                            selected="low")
                                         ),
                                         
                                         #currency options
                                         column(3,
                                                h3("Currencies"),
                                                selectInput("boxFrstOpt", "First Option:",
                                                            c(unique(df$slug)),
                                                            selected="0x"),
                                                selectInput("boxScndOpt", "Second Option:",
                                                            c(unique(df$slug)),
                                                            selected="stellar"),
                                                selectInput("boxTrdOpt", "Third Option:",
                                                            c(unique(df$slug)),
                                                            selected="ripple"),
                                                selectInput("boxFrthOpt", "fourth Option:",
                                                            c(unique(df$slug)),
                                                            selected="bitshares"),
                                         ),
                                         
                                         #grouping settings
                                         column(3,
                                                h3("Plot Settings"),
                                                checkboxInput("boxTranspose",
                                                              "Tranpose the plot:",
                                                              TRUE),
                                                selectInput("boxDate", "Group By:",
                                                            c("months", "years"),
                                                            selected="months"),
                                                selectInput("boxScndVariable", "Size:",
                                                            c("open", "high", "low", "close",
                                                              "market", "close_raito", "ranknow",
                                                              "spread", "volume"), 
                                                            selected="spread"),
                                         ),
                                         
                                         
                                         br()
                                ))),
             
             tabPanel("Density Plots",
               mainPanel(width=12,
                 fluidRow(
                   column(2,
                          selectInput("dist1Type", 
                                      "Please Choose The Type Of Distrubition:", 
                                      c("Histogram", "Kernel Density Plot"), 
                                      selected="Histogram"),
                          selectInput("dist1Currency", "Currency:",
                                      c(unique(df$slug)),
                                      selected="bitshares"),
                          selectInput("dist1Variable", "Variable:",
                                      c("open", "high", "low", "close",
                                        "market", "close_raito", "ranknow",
                                        "spread", "volume"), 
                                      selected="low"),
                          ),
                   
                   column(10, plotlyOutput(outputId="dist1")
                          )),
                 
                 br(),
                 br(),
                 
                 fluidRow(column(5,
                                 style="margin-left: 50px",
                                 h2("First Plot"),
                                 selectInput("dist2Type", 
                                      "Please Choose The Type Of Distrubition:", 
                                      c("Histogram", "Kernel Density Plot"), 
                                      selected="Histogram"),
                                 selectInput("dist2Currency", "Currency:",
                                      c(unique(df$slug)),
                                      selected="bitshares"),
                                 selectInput("dist2Variable", "Variable:",
                                      c("open", "high", "low", "close",
                                        "market", "close_raito", "ranknow",
                                        "spread", "volume"), 
                                      selected="low")),
                          
                          column(5,
                                 style="margin-left: 150px",
                                 h2("Second Plot"),
                                 selectInput("dist3Type", 
                                      "Please Choose The Type Of Distrubition:", 
                                      c("Histogram", "Kernel Density Plot"), 
                                      selected="Histogram"),
                                 selectInput("dist3Currency", "Currency:",
                                      c(unique(df$slug)),
                                      selected="bitshares"),
                                 selectInput("dist3Variable", "Variable:",
                                      c("open", "high", "low", "close",
                                        "market", "close_raito", "ranknow",
                                        "spread", "volume"), 
                                      selected="low")),
                   ),
                   
                   fluidRow(
                     column(6, plotlyOutput(outputId="dist2")
                          ),
                     column(6, plotlyOutput(outputId="dist3")
                          )
                     
                   ))),
            
            #Tab for About Section
            tabPanel("About",
                     mainPanel(width = 12,
                               h2("About This Project"),
                               br(),
                               fluidRow(style="margin-left: 3px",
                                        p("Hello everybody my name is Talha Sahin, 
                                          after my graduation from the department
                                          of sociology I’ve started to develop 
                                          myself on analysis of social media and 
                                          social networking services. For social 
                                          networking services to be properly researched, 
                                          expertise is required both in the social research 
                                          methods and in Data Science. Thus, I’ve developed 
                                          myself on Data Science and started doing 
                                          a master at Big Data in Ibn Haldun University. 
                                          I've developed this Data Visualization 
                                          web-site on R software language 
                                          within the scope of my mid-term project 
                                          in master's degree."),
                                        br(),
                                        h3("You could chek my other projects and codes of this project 
                                          from my GitHub account:"),
                                        h4("My Github Profile:"),
                                        a(href="https://github.com/talha002", 
                                          "https://github.com/talha002"),
                                        h4("Codes of the Project:"),
                                        a(href="https://github.com/talha002/RShiny-Crypto-Visualization",
                                          "https://github.com/talha002/RShiny-Crypto-Visualization"),
                                        h4("My Linkedin Profile:"),
                                        a(href="https://www.linkedin.com/in/talha-sahinn/",
                                          "https://www.linkedin.com/in/talha-sahinn/"),
                                        br(),
                                        br(),
                                        br(),
                                        p("Thank you for your interest :)")
                               ),
                               
                     )),
             
  )
)

#Back-end of the website
server <- function(input, output, session) {
  
  cdata <- session$clientData
  
  output$scatter <- renderPlotly({
    
    p_scatter <- ggplot(df[df$slug == c(input$scatterFrstOpt, input$scatterScndOpt, 
                                input$scatterTrdOpt, input$scatterFrthOpt, 
                                input$scatterFifthOpt, input$scatterSxthOpt,
                                input$scatterSvnOpt, input$scatterEithOpt),], 
                aes_string(x=input$scatterXvariable, y=input$scatterYvariable, colour="slug"))+
      
      geom_point()+
      
      scale_y_continuous(breaks = seq(input$scatterYlimLow, 
                                      input$scatterYlimUp, input$scatterYstep), 
                         limits=c(input$scatterYlimLow, input$scatterYlimUp))+
      
      theme(axis.text.x=element_text(size=10, angle=45))+
      
      scale_x_continuous(breaks = seq(input$scatterXlimLow, 
                                      input$scatterXlimUp, input$scatterXstep), 
                         limits=c(input$scatterXlimLow, input$scatterXlimUp))+
      
      if(input$scatterReg){geom_smooth(method = lm, se=F)}
    
    ggplotly(p_scatter, width = cdata$output_pid_width, height = 800)
    
    })
  
  output$line <- renderPlotly({
    
    p_line <- ggplot(df[df$slug == c(input$lineFrstOpt, input$lineScndOpt, 
                                input$lineTrdOpt, input$lineFrthOpt, 
                                input$lineFifthOpt, input$lineSxthOpt,
                                input$lineSvnOpt, input$lineEithOpt),], 
                aes_string(x="date", y=input$lineVariable, colour="slug"))+
      
      geom_line()+
      
      scale_y_continuous(breaks = seq(input$lineYlimLow, 
                                      input$lineYlimUp, input$lineYstep),
                         limits=c(input$lineYlimLow, input$lineYlimUp))+
      
      theme(axis.text.x=element_text(size=10, angle=45))+
      
      scale_x_date(date_labels = "%d-%m-%y", breaks = input$lineDateSteps, 
                   limits = as.Date(c(input$lineStartDate,
                                      input$lineEndDate)))+
      if(input$lineReg){geom_smooth(method = lm, se=F)}
    
    ggplotly(p_line, width = cdata$output_pid_width, height = 800)
    
  })
  
  output$bar <- renderPlotly({
    
    p_bar <- ggplot(df[df$slug == input$barOpt,], 
                    aes_string(x=input$barDate, y=input$barVariable)) + 
      geom_bar(stat="summary", fun=input$barGroup, fill = "darkblue")+
      scale_x_date(date_labels = "%d-%m-%y", breaks = input$barDateSteps, 
                   limits = as.Date(c(input$barStartDate,
                                      input$barEndDate)))+
      theme(axis.text.x=element_text(size=10, angle=45))+
      scale_y_continuous(breaks = seq(input$barYlimLow, 
                                      input$barYlimUp, input$barYstep),
                         limits=c(input$barYlimLow, input$barYlimUp))+
      if(input$barTranspose){coord_flip()}
    
    ggplotly(p_bar, width = cdata$output_pid_width, height = 800)
    
  })
  
  output$box <- renderPlotly({
    
    p_box <- ggplot(df[df$slug == c(input$boxFrstOpt, input$boxScndOpt, 
                                    input$boxTrdOpt, input$boxFrthOpt),], 
                    aes_string(x=input$boxDate, y=input$boxFrstVariable, 
                               group=input$boxDate)) + 
      geom_boxplot()+
      geom_point(aes_string(size=input$boxScndVariable, colour="slug"))+
      scale_y_continuous(breaks = seq(input$boxYlimLow, 
                                      input$boxYlimUp, input$boxYstep),
                         limits=c(input$boxYlimLow, input$boxYlimUp))+
      scale_x_date(date_labels = "%d-%m-%y", breaks = input$boxDateSteps, 
                   limits = as.Date(c(input$boxStartDate,
                                      input$boxEndDate)))+
      theme(axis.text.x=element_text(size=10, angle=45))+
      theme_bw()+
      if(input$boxTranspose){coord_flip()}
    
    ggplotly(p_box, width = cdata$output_pid_width, height = 800)
    
  })
  
  output$dist1 <- renderPlotly({
    p_dist <- if(input$dist1Type ==  "Histogram"){
      ggplot(df[df$slug == input$dist1Currency,],
             aes_string(x=input$dist1Variable))+
        geom_histogram(colour="darkblue", fill="lightblue")
    } else if(input$dist1Type ==  "Kernel Density Plot"){
      ggplot(df[df$slug == input$dist1Currency,],
             aes_string(x=input$dist1Variable))+
        geom_density(colour="darkblue", fill="lightblue")
      }
      
    
    ggplotly(p_dist, width = cdata$output_pid_width)
    
  })
  
  output$dist2 <- renderPlotly({
    p_dist <- if(input$dist2Type ==  "Histogram"){
      ggplot(df[df$slug == input$dist2Currency,],
             aes_string(x=input$dist2Variable))+
        geom_histogram(colour="darkblue", fill="lightblue")
    } else if(input$dist2Type ==  "Kernel Density Plot"){
      ggplot(df[df$slug == input$dist2Currency,],
             aes_string(x=input$dist2Variable))+
        geom_density(colour="darkblue", fill="lightblue")
    }
    
    
    ggplotly(p_dist, width = cdata$output_pid_width)
    
  })
  
  output$dist3 <- renderPlotly({
    p_dist <- if(input$dist3Type ==  "Histogram"){
      ggplot(df[df$slug == input$dist3Currency,],
             aes_string(x=input$dist3Variable))+
        geom_histogram(colour="darkblue", fill="lightblue")
    } else if(input$dist3Type ==  "Kernel Density Plot"){
      ggplot(df[df$slug == input$dist3Currency,],
             aes_string(x=input$dist3Variable))+
        geom_density(colour="darkblue", fill="lightblue")
    }
    
    
    ggplotly(p_dist, width = cdata$output_pid_width)
    
  })
  
  output$mytable <- DT::renderDataTable({
    DT::datatable(df, options=list(lengthMenu=c(15, 30, 50), pageLength=15))
    })
}

shinyApp(ui = ui, server = server)