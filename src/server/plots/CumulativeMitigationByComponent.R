cumulativeMitiBarByComponent = function(mitigation_year = 2050, ...) {
    db = RSQLite::dbConnect(RSQLite::SQLite(), reactiveDirectories$resultsOutputDir)
	#cbPalette = c("#009E73", "#E69F00", "#c9db06", "#3f2502", "#828282") OLD
	cbPalette <- c("#009E73", "#D55E00", "#56B4E9","#0072B2", "#000000")
    scienceTheme = theme(panel.grid.major = element_line(size = 1.5,
        color = "white"),
        axis.line = element_line(size = 1.4),
        text = element_text(size = 18),
        legend.text = element_text(size = 12),
        legend.position = "bottom",
        legend.direction = "horizontal"
    )
    cumulMiti = RSQLite::dbGetQuery(db, 'SELECT mi.scenario, mi.Year as year, 
          CAST(Sum(mi.miti_forest_rt_mtco2e) AS REAL) AS forest_rt,
          CAST(Sum(mi.miti_hwp_emissions_domestic_rt_mtco2e+mi.miti_hwp_emissions_foreign_rt_mtco2e) AS REAL) AS hwp_rt, 
          CAST(Sum(mi.miti_dfe_domestic_rt_mtco2e) AS REAL) AS dfe_rt,
          CAST(Sum(mi.miti_dfp_domestic_rt_mtco2e+mi.miti_dfp_foreign_rt_mtco2e) AS REAL) AS dfp_rt,
          CAST(Sum(mi.miti_society_rt_mtco2e) AS REAL) AS society_rt
          FROM miti_society AS mi
          GROUP BY mi.scenario, mi.Year')
    dbDisconnect(db)
    cumulMiti$scenario=factor(cumulMiti$scenario, 
        levels=c(
            "CBM_B_HWP_Base",
            "CBM_Base_HWP_LLP",
            "CBM_B_HWP_LLP",
            "CBM_A_HWP_Base",
            "CBM_A_HWP_LLP",
            "CBM_C_HWP_Base",
            "CBM_C_HWP_LLP",
            "CBM_D_HWP_Base",
            "CBM_D_HWP_LLP"
        ),
        labels=c(
            "Harvest Less",
            "LLP",
            "HLess+LLP",
            "Inc. Util",
            "Util+LLP",
            "Residues",
            "Residue+LLP",
            "Inc. Util\n+ Residues",
            "Inc. Util\n+ Residues\n+ LLP"
        )
    )
    Components <- c("hwp_rt", "forest_rt","dfe_rt", "dfp_rt")
    societyOnly <- "society_rt"
    cumulMiti <- melt(cumulMiti, id=c("scenario", "year"))
    societyValues <- subset(cumulMiti, variable==societyOnly)
    societyValues["Facets"] <- "Society"
    componentValues <- subset(cumulMiti, variable %in% Components)
    componentValues["Facets"] <- "Components"
    cumulMiti <- bind_rows(componentValues, societyValues)
    cumulMiti$variable<- as.factor(cumulMiti$variable)
    cumulMiti <- arrange(cumulMiti, desc(variable))
    NewLabels=c(
  "Harvest Less",  "LLP", "Harvest Less\n+ LLP", "Inc. Util",  "Inc. Util\n+ LLP",
  "Residues\nfor Bioenergy",   "Residues\n+ LLP",  "Residues\n+ Inc. Util",  "Residues\n+ Inc. Util\n+ LLP")
    
    cumulMiti = filter(cumulMiti,year == mitigation_year,scenario!="")
    plot = ggplot() +
    geom_bar(data=subset(cumulMiti, variable != societyOnly), aes(x = scenario, y = -value, fill=variable), 
           stat="identity", position="stack") +
    geom_errorbar(data=subset(cumulMiti, variable == societyOnly),
                aes(x = scenario, ymin=-value, ymax=-value), color="black",
                width=0.4, size=1.6) +
    #geom_text(data=subset(cumulMiti, variable != "society_rt"), position="stack", aes(x = scenario,y=value, label=round(value,2)), color="black", vjust=1, size=4.5, check_overlap = TRUE)+
    #geom_text(data=subset(cumulMiti, variable == "society_rt"), aes(x = scenario,y=value, label=round(value,2)), color="black", vjust=-4, size=9,check_overlap = TRUE)+
    guides(fill=guide_legend(ncol=4))+
    geom_hline(yintercept=0)+
    scienceTheme+
    scale_fill_manual(values=cbPalette, name = "Components:", labels = c("Forest Ecosystem", "Harvested Wood Products", "Energy Displacement", "Wood Product Displacement")) +
    scale_x_discrete(labels = NewLabels, drop = FALSE) +
    guides(alpha=FALSE) +
	
    labs(title=paste("Cumulative Mitigation in", mitigation_year, sep = " "),x="Scenario",y="Cumulative Mitigation (TgCO2e)")+
    coord_cartesian(xlim = rangesCumulMitigationByComponent$x, ylim = rangesCumulMitigationByComponent$y, expand = FALSE)
    
    return(plot)
}
observeEvent(
    input$refreshMitigationByComponent,
    {
        output$cumualtiveMitigationBarByComponent = renderPlot({
            cumulativeMitiBarByComponent(mitigation_year = input$mitigationByComponentYear)
        })
    }
)   
output$downloadMitigationByComponent = downloadHandler(
    filename = "cumulative_mitigation_bar_graph_by_component.png",
    content = function(file){
        ggsave(file, plot = cumulativeMitiBarByComponent(mitigation_year = input$mitigationByComponentYear), device = "png", height = 6, width = 13)
    }
)
output$mitigationByComponentYearSlider = renderUI({
    sliderInput(
        'mitigationByComponentYear', 
        label = NULL,
        min = startYear,
        max = endYear,
        value = endYear,
        step = 1,
        animate = animationOptions(1500, loop = TRUE),
        width = "100%"
    )
})

observeEvent(input$cumulMitigationByComponentDoubleClick,{
    brush <- input$cumulMitigationByComponentBrush
    if (!is.null(brush)) {
        rangesCumulMitigationByComponent$x <- c(brush$xmin, brush$xmax)
        rangesCumulMitigationByComponent$y <- c(brush$ymin, brush$ymax)
    } else {
        rangesCumulMitigationByComponent$x <- NULL
        rangesCumulMitigationByComponent$y <- NULL
    }
})