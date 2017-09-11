poolPlot = function(...){
    poolIndicator = input$selectPool
    number = 11

    db = RSQLite::dbConnect(RSQLite::SQLite(), reactiveDirectories$scenarioRollupDir)
    
    carbonPool = dbGetQuery(db,paste('select Year, scenario, Pool from carbon_pool_summary WHERE indicator =', "'",poolIndicator,"'", sep="" ))

    x = "Years"
    a = aes(x = Year, y = Pool/1e6, colour = scenario)
    y = "MgC"
    scienceTheme = theme(panel.grid.major = element_line(size = 1.5,
        color = "white"),
        axis.line = element_line(size = 1.4),
        legend.position = "right",
        text = element_text(size = 18)
    )
    p = ggplot(data=carbonPool, a) +
        geom_line() +
        scale_x_continuous() +
        scienceTheme+
        labs(title=poolIndicator, x=x, y=y, colour="Scenario") +
        theme(plot.title = element_text(hjust = 0.5))+
        coord_cartesian(xlim = rangesPools$x, ylim = rangesPools$y, expand = FALSE)
    return(p)
}
observeEvent(
    input$refreshPool,
    {
        output$pool = renderPlot({
            poolPlot()
        })
    }
)  
output$downloadPool = downloadHandler(
    filename = paste(input$selectPool, "_timeseries.png",sep=""),
    content = function(file){
        ggsave(file, plot = poolPlot(), device = "png", height = 6, width = 13)
    }
)

observeEvent(input$poolDoubleClick,{
    brush <- input$poolBrush
    if (!is.null(brush)) {
        rangesPools$x <- c(brush$xmin, brush$xmax)
        rangesPools$y <- c(brush$ymin, brush$ymax)
    } else {
        rangesPools$x <- NULL
        rangesPools$y <- NULL
    }
})

reactivePoolSelection = reactive({
    db = RSQLite::dbConnect(RSQLite::SQLite(), reactiveDirectories$scenarioRollupDir)
    carbonPool = dbGetQuery(db,"select distinct indicator from carbon_pool_summary")
    return(carbonPool[[1]])
})

output$poolSelection = renderUI({
    pools = reactivePoolSelection()
    selectInput("selectPool",
        label = "Select a pool:",
        choices = pools,
        selected = pools[1]
    )
})