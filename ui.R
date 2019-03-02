# UI.R
FullPage <- dashboardPage(
  skin = "blue",
  dashboardHeader(title = "Website Performance"),
  dashboardSidebar(
    collapsed=TRUE,
    sidebarMenu(#id = "sbm",
      menuItem("Combined Summary", tabName = "dashboard1", icon = icon("dashboard"),
               menuSubItem("Step Volume", tabName = "allStepVolume", icon = icon("fa fa-battery-empty")), #tabName = 'industryTargetsStateBased'
               menuSubItem("Sales",tabName = "allSales", icon = icon("search")) #tabName = "trend1"
      ),
      
      menuItem("Page Specific", tabName = "dashboard2", icon = icon("dashboard"), 
               menuSubItem("Step Volume", tabName = "stepVolume", icon = icon("fa fa-battery-empty")), #tabName = "activitySection"
               menuSubItem("Sales",tabName = "sales", icon = icon("search")) 
      )
    )# end of sidebarMenu
  ),#end of dashboardSidebar
  
  dashboardBody(
    skin = "green",
    tabItems(
      tabItem(tabName = "allStepVolume",#trend1
              fluidRow(
                box(
                  status = "info",
                  background = "green",
                  width = 3,
                  p(paste0("Last updated on ",Sys.Date()))
                )
              ),
              
              fluidRow(
                column(width = 12,
                       box(
                         title = "Volume Of Users",#'Step Volume'
                         status = "primary",
                         width = 12,
                         solidHeader = FALSE,
                         plotlyOutput("step1")
                       )
                       #End of Box
                )# end of column
              ),
              
              fluidRow(
                column(width = 12,
                       box(
                         title = "Coversion Rates",
                         status = "primary",
                         width = 12,
                         solidHeader = FALSE,
                         plotlyOutput("stepConversions1")
                       )
                       #End of Box
                )# end of column
              )
              
              
      ), # End of tabItem
      tabItem(tabName = "allSales",
              
              fluidPage(
                fluidRow(
                  box(
                    status = "info",
                    background = "green",
                    width = 3,
                    p(paste0("Last updated on ", Sys.Date()))
                  )
                ),
                br(),br(),
                
                fluidRow(
                  box(
                    title = "Combined Sales",
                    width=12,
                    solidHeader = FALSE,
                    status="primary",
                    DT::dataTableOutput("sales1"))
                )
              ) # End of fluidPage
      ), # End of tabItem
      
      tabItem(tabName = "stepVolume",
              
              fluidRow(
                box(
                  status = "info",
                  background = "green",
                  width = 3,
                  p(paste0("Last updated on ",Sys.Date()))
                )
              ),
              
              fluidRow(
                box(
                  status = "primary",
                  title = "Source",
                  solidHeader = FALSE,
                  width = 6,
                  background = "navy",
                  p("Please select from available options"),
                  selectInput("pageFilterSteps", #"sourceFilter"
                              label = "Source",
                              choices = c(Choose='', as.character(c("landing_page","clearance_page","inventory_page"))),
                              selected = "All")
                  
                )# end of box
              ),
              
              fluidRow(
                column(width = 12,
                       box(
                         title = "Volume of Users",
                         status = "primary",
                         width = 12,
                         solidHeader = FALSE,
                         plotlyOutput("step2")
                       )
                       #End of Box
                )# end of column
              ),
              
              fluidRow(
                column(width = 12,
                       box(
                         title = "Conversion Rates",
                         status = "primary",
                         width = 12,
                         solidHeader = FALSE,
                         plotlyOutput("stepConversions2")
                       )
                       #End of Box
                )# end of column
              )
      ),# End of tab item  
      
      tabItem(tabName = "sales",
              
              fluidRow(
                box(
                  status = "info",
                  background = "green",
                  width = 3,
                  p(paste0("Last updated on ",Sys.Date()))
                )
              ),
              
              fluidRow(
                box(
                  status = "primary",
                  title = "Source",
                  solidHeader = FALSE,
                  width = 6,
                  background = "navy",
                  p("Please select from available options"),
                  selectInput("pageFilterSales", #sodFilter1
                              label = "Source",
                              choices = c(Choose='', as.character(c("landing_page","clearance_page","inventory_page"))),
                              selected = "All")
                  
                )# end of box
              ),
              
              br(),br(),
              
              fluidRow(
                box(
                  title = "Page-Specific Sales",
                  width=12,
                  solidHeader = FALSE,
                  status="primary",
                  DT::dataTableOutput("sales2"))
              )
              
      )
      
    ) # end of tabITems
  )# end of dashboard body
)# end of dashboard page

