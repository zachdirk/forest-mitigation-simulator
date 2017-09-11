yearlyMitiPlot = function(component){
    db = RSQLite::dbConnect(RSQLite::SQLite(), reactiveDirectories$resultsOutputDir)
    ts_miti = RSQLite::dbGetQuery(db, 'SELECT miti_society.scenario,
        miti_society.year, 
        CAST(Sum(miti_society.miti_forest_mtco2e) AS REAL) AS miti_forest,
        CAST(Sum(miti_society.miti_hwp_emissions_domestic_mtco2e+miti_society.miti_hwp_emissions_foreign_mtco2e) AS REAL) AS miti_hwp,
        CAST(Sum(miti_society.miti_dfp_mtco2e_domestic+miti_society.miti_dfp_mtco2e_foreign) AS REAL) AS miti_dfp,
        CAST(Sum(miti_society.miti_dfe_domestic_mtco2e) AS REAL) AS miti_dfe,
        CAST(Sum(miti_society.miti_society_mtco2e) AS REAL) AS miti_society,
        CAST(Sum(miti_society.miti_society_rt_mtco2e) AS REAL) AS mitiSocietyRT
    FROM miti_society
    GROUP BY miti_society.scenario, miti_society.year')
    dbDisconnect(db)
    scienceTheme = theme(panel.grid.major = element_line(size = 1.5,
        color = "white"),
        axis.line = element_line(size = 1.4),
        legend.position = "right",
        text = element_text(size = 18)
    )
    ts_miti$scenario=factor(ts_miti$scenario, 
        levels=c(
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
    if (component == "Forest"){
        title       = "Mitigation from the Forest Ecosystem"
        miti        = select(ts_miti,miti_forest,year,scenario)
        mitigationPlot   = filter(miti,scenario %in% c('Util+LLP','Harvest Less','Residues','Util+Res+LLP','LLP','Inc. Util','Harvest Less+LLP','Residues+LLP','Util+Res'))
    }else if (component == "Harvested Wood Products"){
        title       = "Mitigation from Harvested Wood Products"
        miti        = select(ts_miti,miti_hwp,year,scenario)
        mitigationPlot   = filter(miti,scenario %in% c('Util+LLP','Harvest Less','Residues','Util+Res+LLP','LLP','Inc. Util','Harvest Less+LLP','Residues+LLP','Util+Res'))
    }else if (component == "Wood Product Displacement"){
        title       = "Mitigation from Wood Product Displacement"
        miti        = select(ts_miti,miti_dfp,year,scenario)
        mitigationPlot   = filter(miti,scenario %in% c('Util+LLP','Harvest Less','Residues','Util+Res+LLP','LLP','Inc. Util','Harvest Less+LLP','Residues+LLP','Util+Res'))
    }else if (component == "Energy Displacement"){
        title       = "Mitigation from Energy Displacement"
        miti        = select(ts_miti,miti_dfe,year,scenario)
        mitigationPlot   = filter(miti,scenario %in% c('Util+LLP','Harvest Less','Residues','Util+Res+LLP','LLP','Inc. Util','Harvest Less+LLP','Residues+LLP','Util+Res'))
    }else if (component == "Total"){
        title       = "Yearly Total"
        miti        = select(ts_miti,miti_society,year,scenario)
        mitigationPlot   = filter(miti,scenario %in% c('Util+LLP','Harvest Less','Residues','Util+Res+LLP','LLP','Inc. Util','Harvest Less+LLP','Residues+LLP','Util+Res'))
    }
    mitigationPlot$scenario=factor(mitigationPlot$scenario,levels=c('Util+LLP','Harvest Less','Residues','Util+Res+LLP','LLP','Inc. Util','Harvest Less+LLP','Residues+LLP','Util+Res'))
    plot = ggplot(data=mitigationPlot,aes(x=year,y=-mitigationPlot[1],group=scenario,colour=scenario))+
        geom_line(stat="identity", position="identity")+
        guides(fill=guide_legend(ncol=1))+
        geom_hline(yintercept=0)+
        scienceTheme+
        scale_x_continuous()+
        scale_y_continuous()+
        labs(title=title,x="Year",y="Mitigation (TgCO2e/yr)")+
        coord_cartesian(xlim = rangesMitigation$x, ylim = rangesMitigation$y, expand = FALSE)
    return(plot)
}


observeEvent(
    input$refreshYearlyMitigation,
    {
        output$yearlyMitigation = renderPlot({
            yearlyMitiPlot(input$yearlyMitigationComponent)
        })
    }
)
output$downloadYearlyMitigation = downloadHandler(
    filename = "yearly_mitigation_plot.png",
    content = function(file){
        ggsave(file, plot = yearlyMitiPlot(input$yearlyMitigationComponent), device = "png", height = 6, width = 13)
    }
)
output$yearlyMitigationComponent = renderUI({
    radioButtons(
        inputId = "yearlyMitigationComponent",
        label = "Select Component:",
        choices = c("Forest", "Harvested Wood Products", "Energy Displacement", "Wood Product Displacement", "Total"),
        selected = "Total", 
        inline = TRUE
    )
})

observeEvent(input$mitigationDoubleClick,{
    brush <- input$mitigationBrush
    if (!is.null(brush)) {
        rangesMitigation$x <- c(brush$xmin, brush$xmax)
        rangesMitigation$y <- c(brush$ymin, brush$ymax)
    } else {
        rangesMitigation$x <- NULL
        rangesMitigation$y <- NULL
    }
})