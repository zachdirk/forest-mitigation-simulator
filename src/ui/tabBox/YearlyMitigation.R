tabPanelYearlyMitigation = tabPanel(
    strong("Annual Mitigation"),
    plotOutput("yearlyMitigation", brush = brushOpts(id = "mitigationBrush",resetOnNew = TRUE),dblclick = "mitigationDoubleClick"),
    uiOutput("yearlyMitigationComponent"),
    actionButton("refreshYearlyMitigation", icon = icon("bar-chart"), "Refresh Plot"),
    downloadButton("downloadYearlyMitigation", "Download Plot")
)