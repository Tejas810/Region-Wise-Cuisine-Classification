library(shiny)

shinyUI(fluidPage(tags$style(
        " h2{
            font-size:3em;
            color:brown;
            text-align:center;
            font-weight:bold;
          }
          .selectize-control.single .selectize-input, .selectize-control.single .selectize-input input{
            border:1px solid #4eafcd;
            border-radius:2em;
          }
          .dataTables_wrapper .dataTables_length select{
            border-radius:4em;
          }
          .dataTables_wrapper .dataTables_filter input{
            border-radius:4em;
          }
          #PieChart img{
            margin:1em 0em 0em 4em;
          }
          #PieChart2 img{
            margin:1em 0em 0em 8em;
          }
          img{
            margin:1em 0em 0em 17em;
          }
          hr{
            width:92em;
            border-bottom:4px solid #141e30;
          }
          #first-label{
            font-family:calibri;
            color:orange;
            font-size:1.5em;
          }
          #PieChart{
            margin-left:10em;
          }
          h1{
            margin-left:11em;
            color:#ff6361;
          }
          .tabbable ul{
            width:92em;
          }
          .tabbable li{
            padding-left:0.3em;
          }
          .tabbable li a{
            font-size:1em;
            font-weight:700;
          }
          .dataTables_length label{
            margin-left:53em;
            color:#ff6361;
            width:22em;
          }
          .dataTables_wrapper .dataTables_filter{
            text-align:inherit;
            float:inherit;
          }
        "
      ),
    titlePanel("Region wise cuisine classification"),
    mainPanel(
      tags$br(),tags$hr(),tags$br(),
      tabsetPanel(
        tabPanel("Data",column(5,offset = 7,tags$div(
                          tags$br(),
                          tags$label("Select a Flavour ",id="first-label"),
                          selectInput("flavour","",
                                      c("spicy","sweet","bitter","sour"),
                                      selected = "spicy"
                                      )
                          )
                    ),
                 tags$br(),tags$br(),
                  column(5,offset=3,dataTableOutput("flavour_data"))
                 ), 
        tabPanel("Flavours Pie Chart",plotOutput("PieChart")),
        tabPanel("Region Wise food Pie Chart",plotOutput("PieChart2")),
        tabPanel("Heatmap",tags$br(),plotOutput("heatMap")),
        tabPanel("Preparation Time for Snacks Bar Plot",tags$br(),plotOutput("barPlot3")),
        tabPanel("Region Wise Diet Bar Plot",tags$br(),plotOutput("barPlot")),
        tabPanel("Region Wise Flavours Bar Plot",tags$br(),plotOutput("barPlot2")),
         type="pills"
      ),
    )
)
)

