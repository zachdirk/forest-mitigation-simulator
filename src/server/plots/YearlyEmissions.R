yearlyEmissionsPlot = function(component="Total"){
    db = RSQLite::dbConnect(RSQLite::SQLite(), reactiveDirectories$resultsOutputDir)
    emissions = RSQLite::dbGetQuery(db, 'SELECT d.scenario,
        d.year, 
         CAST(d.forest_mtco2e AS REAL) AS forest,
         CAST(d.hwp_emissions_domestic_mtco2e+d.hwp_emissions_foreign_mtco2e AS REAL) AS hwp,
         CAST(d.dfp_mtco2e_domestic+d.dfp_mtco2e_foreign AS REAL) AS dfp,
         CAST(d.dfe_domestic_mtco2e AS REAL) AS dfe,
         CAST(d.society_mtco2e AS REAL) AS society_mtco2e
    FROM dfe_dfp_sector_society_rt d
    GROUP BY d.scenario, d.year')
    dbDisconnect(db)
    scienceTheme = theme(panel.grid.major = element_line(size = 1.5,
        color = "white"),
        axis.line = element_line(size = 1.4),
        legend.position = "right",
        text = element_text(size = 18)
    )
    emissions$scenario=factor(emissions$scenario, 
        levels=c(
            "CBM_Base_HWP_Base",
            "CBM_A_HWP_Base",
            "CBM_B_HWP_Base",
            "CBM_C_HWP_Base",
            "CBM_D_HWP_Base",
            "CBM_Base_HWP_LLP",
            "CBM_A_HWP_LLP",
            "CBM_B_HWP_LLP",
            "CBM_C_HWP_LLP",
            "CBM_D_HWP_LLP"
        ),
        labels=c(
            "Base",
            "Inc. Util",
            "Harvest Less",
            "Residues",
            "Util+Res",
            "LLP",
            "Util+LLP",
            "Harvest Less+LLP",
            "Residues+LLP",
            "Util+Res+LLP"
        )
    )
    scenarios = c('Util+LLP','Harvest Less','Residues','Util+Res+LLP','LLP','Inc. Util','Harvest Less+LLP','Residues+LLP','Util+Res')
    if (component == "Forest"){
        title            = "Emissions from the Forest Ecosystem"
        emit        = select(emissions,forest,year,scenario)
        emissionsPlot   = filter(emit,scenario %in% scenarios)
    }else if (component == "Harvested Wood Products"){
        title            = "Emissions from Harvested Wood Products"
        emit        = select(emissions,hwp,year,scenario)
        emissionsPlot   = filter(emit,scenario %in% scenarios)
    }else if (component == "Wood Product Displacement"){
        title            = "Emissions from Wood Product Displacement"
        emit        = select(emissions,dfp,year,scenario)
        emissionsPlot   = filter(emit,scenario %in% scenarios)
    }else if (component == "Energy Displacement"){
        title            = "Emissions from Energy Displacement"
        emit        = select(emissions,dfe,year,scenario)
        emissionsPlot   = filter(emit,scenario %in% scenarios)
    }else if (component == "Total"){
        title            = "Total Emissions"
        emit        = select(emissions,society_mtco2e,year,scenario)
        emissionsPlot   = filter(emit,scenario %in% scenarios)
    }
    
    plot = ggplot(data=emissionsPlot,aes(x=year,y=emissionsPlot[1],group=scenario,colour=scenario))+
        geom_line(stat="identity", position="identity")+
        guides(fill=guide_legend(ncol=1))+
        geom_hline(yintercept=0)+
        scienceTheme+
        scale_x_continuous()+
        scale_y_continuous()+
        labs(title=title,x="Year",y="Emissions (TgCO2e/yr)")+
        coord_cartesian(xlim = rangesEmissions$x, ylim = rangesEmissions$y, expand = FALSE)
    return(plot)
}

observeEvent(
    input$refreshYearlyEmissions,
    {
        output$yearlyEmissionsPlot = renderPlot({
            yearlyEmissionsPlot(input$yearlyEmissionsComponent)
        })
    }
)   
output$downloadYearlyEmissions = downloadHandler(
    filename = "yearlyEmissionsPlot.png",
    content = function(file){
        ggsave(file, plot = yearlyEmissionsPlot(input$yearlyEmissionsComponent), device = "png", height = 6, width = 13)
    }
)
output$yearlyEmissionsComponent = renderUI({
    radioButtons(
        inputId = "yearlyEmissionsComponent",
        label = "Select Component:",
        choices = c("Forest", "Harvested Wood Products", "Energy Displacement", "Wood Product Displacement", "Total"),
        selected = "Total", 
        inline = TRUE
    )
})

observeEvent(input$emissionDoubleClick,{
    brush <- input$emissionBrush
    if (!is.null(brush)) {
        rangesEmissions$x <- c(brush$xmin, brush$xmax)
        rangesEmissions$y <- c(brush$ymin, brush$ymax)
    } else {
        rangesEmissions$x <- NULL
        rangesEmissions$y <- NULL
    }
})