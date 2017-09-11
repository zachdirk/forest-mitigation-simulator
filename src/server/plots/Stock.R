stockPlot = function(...){
    stockIndicator = input$selectStock
    number = 11

    db = RSQLite::dbConnect(RSQLite::SQLite(), reactiveDirectories$scenarioRollupDir)
    
    carbonStock = dbGetQuery(db,paste('select Year, scenario, flux_tc from carbon_stock_summary WHERE indicator =', "'",stockIndicator,"'", sep="" ))
    x = "Years"
    a = aes(x = Year, y = Flux_tc/1e6, colour = scenario)
    y = "MgC"
    scienceTheme = theme(panel.grid.major = element_line(size = 1.5,
        color = "white"),
        axis.line = element_line(size = 1.4),
        legend.position = "right",
        text = element_text(size = 18)
    )
    p = ggplot(data=carbonStock, a) +
        geom_line() +
        scale_x_continuous() +
        scienceTheme+
        labs(title=stockIndicator, x=x, y=y, colour="Scenario") +
        theme(plot.title = element_text(hjust = 0.5))+
        coord_cartesian(xlim = rangesStocks$x, ylim = rangesStocks$y, expand = FALSE)
    return(p)
}
observeEvent(
    input$refreshStock,
    {
        output$stock = renderPlot({
            stockPlot()
        })
    }
)  
output$downloadStock = downloadHandler(
    filename = paste(input$selectStock, "_timeseries.png",sep=""),
    content = function(file){
        ggsave(file, plot = stockPlot(), device = "png", height = 6, width = 13)
    }
)

observeEvent(input$stockDoubleClick,{
    brush <- input$stockBrush
    if (!is.null(brush)) {
        rangesStocks$x <- c(brush$xmin, brush$xmax)
        rangesStocks$y <- c(brush$ymin, brush$ymax)
    } else {
        rangesStocks$x <- NULL
        rangesStocks$y <- NULL
    }
})

reactiveStockSelection = reactive({
    db = RSQLite::dbConnect(RSQLite::SQLite(), reactiveDirectories$scenarioRollupDir)
    carbonStock = dbGetQuery(db,"select distinct indicator from carbon_stock_summary")
    return(carbonStock[[1]])
})

output$stockSelection = renderUI({
    stocks = reactiveStockSelection()
    selectInput("selectStock",
        label = "Select a stock:",
        choices = stocks,
        selected = stocks[1]
    )
})