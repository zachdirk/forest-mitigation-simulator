futureTimberSupplyPlot = function(){
    flux_a <- "PICS Net Merch Growth"
    flux_b <- "Merch"


    db = RSQLite::dbConnect(RSQLite::SQLite(), reactiveDirectories$scenarioRollupDir)

    carbonStock = dbGetQuery(db,paste('select Year, scenario, flux_tc from carbon_stock_summary WHERE indicator =', "'",flux_a,"'", sep="" ))
    carbonPool = dbGetQuery(db,paste('select Year, scenario, Pool from carbon_pool_summary WHERE indicator =', "'",flux_b,"'", sep="" ))

    futureTimber <- left_join(carbonStock, carbonPool, by=c("Year", "scenario"))
    futureTimber[is.na(futureTimber)]=0
    futureTimber["Future_Timber_Supply"]=futureTimber$Flux_tc+futureTimber$Pool

    futureTimber$scenario=factor(futureTimber$scenario, 
            levels=c(
                "CBM_BASE",
                "CBM_A",
                "CBM_B",
                "CBM_C",
                "CBM_D"
            ),
            labels=c(
                "Base",
                "Inc. Util",
                "Harvest Less",
                "Residues",
                "Util+Res"
        )
    )
    scienceTheme = theme(panel.grid.major = element_line(size = 1.5,
        color = "white"),
        axis.line = element_line(size = 1.4),
        legend.position = "right",
        text = element_text(size = 18)
    )
    p = ggplot() +
        geom_line(data=futureTimber, aes(Year,Future_Timber_Supply, colour=scenario)) +
        scale_x_continuous() +
        scienceTheme+
        labs(title = 'Future Timber Supply', x="Years", y="MgC/yr", colour="Scenario") +
        theme(plot.title = element_text(hjust = 0.5))+
        coord_cartesian(xlim = rangesFutureTimberSupply$x, ylim = rangesFutureTimberSupply$y, expand = FALSE)
    return(p)
}
observeEvent(
    input$refreshFutureTimberSupply,
    {
        output$futureTimberSupply = renderPlot({
            futureTimberSupplyPlot()
        })
    }
)  
output$downloadFutureTimberSupply = downloadHandler(
    filename = "future_timber_supply.png",
    content = function(file){
        ggsave(file, plot = futureTimberSupplyPlot(), device = "png", height = 6, width = 13)
    }
)

observeEvent(input$futureTimberSupplyDoubleClick,{
    brush <- input$futureTimberSupplyBrush
    if (!is.null(brush)) {
        rangesFutureTimberSupply$x <- c(brush$xmin, brush$xmax)
        rangesFutureTimberSupply$y <- c(brush$ymin, brush$ymax)
    } else {
        rangesFutureTimberSupply$x <- NULL
        rangesFutureTimberSupply$y <- NULL
    }
})