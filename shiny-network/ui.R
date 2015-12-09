library(shiny)
library(httr)
library(lubridate)
avail_dates <- unlist(content(GET("emhart.info/dates/AGU/2015")))

shinyUI(fluidPage(

  tags$head(
    tags$script(src = 'http://d3js.org/d3.v3.min.js')
  ),
  titlePanel("Network plot"),

  #' select a database to use
  sidebarLayout(
    sidebarPanel(
      p("Visualize twitter interaction networks for hashtags.  This demonstration uses a database of tweets based on term #AGU2015 or #AGU15. Keep in mind the conference dates were from Aug 9 - Aug 14
so tweet volume will be very high on those dates.
               "),
      p("Colors represent clusters found with the random walk algorithm from iGraph"),
      hr(),
      helpText("Date - the date of tweets to plot"),
      helpText("Minimum tweet number - the minimum number of tweets a user needs to have made to be included in the plot"),
      helpText("Edge type - are edges created by retweets, mentions or both"),
      hr(),
        dateInput("rptg_dt",
       label = "Date",
       value = Sys.Date(),
       min= min(ymd(avail_dates)),
       max= max(ymd(avail_dates))
       ),
      numericInput("tweetMin","Minimum tweet number",value=3,min = 0, step=1)
      ,
      selectInput("edgeType","Edge type:",c("Retweet" = "retweet","Mentions" = "mention","Both" ="all")),
      actionButton("toplot", "Plot")


      ),

    mainPanel(

      htmlOutput('networkPlot')
    )

    )

)
)
