library(d3Network)
library(tweetNetwork)
library(igraph)

shinyServer(function(input, output) {
  
  # Define a reactive expression for the document term matrix
  observeEvent(input$toplot,{
    
    withProgress(message = 'Making plot',{
    mygraph_data <- tweet_from_api(input$tweetMin,input$rptg_dt)

    mygraph <- create_graph(mygraph_data,edgeType = input$edgeType)
    
    myD3graph <- convertD3(mygraph)
  
    })
    
    output$networkPlot <- renderPrint({
      d3ForceNetwork(Nodes = myD3graph$node,
                     Links = myD3graph$d3g,
                     Source = "from", Target = "to", NodeID = "name",
                     Group = "group", width = 700, height = 700, parentElement = '#networkPlot',
                      standAlone = FALSE,zoom = TRUE,opacity = .9,linkWidth = .3)
    })
    
    
  })
  

}
)