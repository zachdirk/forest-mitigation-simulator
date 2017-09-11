cumulativeMitiPlot = function(...) {
    db = RSQLite::dbConnect(RSQLite::SQLite(), reactiveDirectories$resultsOutputDir)
    mitiSocietyRT = RSQLite::dbGetQuery(db, 'SELECT miti_society.scenario,
        miti_society.year, 
        CAST(Sum(miti_society.miti_society_rt_mtco2e) AS REAL) AS mitiSocietyRT
        FROM miti_society
        GROUP BY miti_society.scenario, miti_society.year')
    dbDisconnect(db)
    scienceTheme = theme(
        panel.grid.major = element_line(size = 1.5, color = "white"),
        axis.line = element_line(size = 1.4),
        legend.position = "right",
        text = element_text(size = 18),
        legend.text = element_text(size = 12)
    )
    mitiSocietyRT$scenario=factor(mitiSocietyRT$scenario,
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
            "Util+Res+LLP")
        )
    mitiSocietyRT=filter(mitiSocietyRT,scenario %in% c('Util+LLP','Harvest Less','Residues','Util+Res+LLP','LLP','Inc. Util', 'Util+Res', 'Residues+LLP', 'Harvest Less+LLP'))
    mitiSocietyRT$scenario=factor(mitiSocietyRT$scenario,levels=c('Util+Res+LLP','Residues','Util+LLP','Inc. Util','LLP','Harvest Less','Util+Res', 'Residues+LLP', 'Harvest Less+LLP'))
    plot = ggplot(data=mitiSocietyRT,aes(x=year,y=-mitiSocietyRT,group=scenario,colour=scenario))+
        geom_line(size = 1)+
        geom_hline(yintercept=0)+
        scienceTheme+
        guides(fill=guide_legend(ncol=1))+
        labs(title="Cumulative Mitigation",x="Year",y="Cumulative Mitigation (TgCO2e)")+
        coord_cartesian(xlim = rangesCumulMitigation$x, ylim = rangesCumulMitigation$y, expand = FALSE)
    return(plot)
}
observeEvent(
    input$refreshCumulativeMitigation,
    {
        output$cumulativeMitigationPlot = renderPlot({
            cumulativeMitiPlot()
        })
    }
)   
output$downloadCumulativeMitigation = downloadHandler(
    filename = "cumulative_mitigation_plot.png",
    content = function(file){
        ggsave(file, plot = cumulativeMitiPlot(), device = "png", height = 6, width = 13)
    }
)

observeEvent(input$cumulMitigationDoubleClick,{
    brush <- input$cumulMitigationBrush
    if (!is.null(brush)) {
        rangesCumulMitigation$x <- c(brush$xmin, brush$xmax)
        rangesCumulMitigation$y <- c(brush$ymin, brush$ymax)
    } else {
        rangesCumulMitigation$x <- NULL
        rangesCumulMitigation$y <- NULL
    }
})