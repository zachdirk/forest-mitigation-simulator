tabPanelYearlyEmissions = tabPanel(
    strong("Annual Carbon Emissions"),
    plotOutput("yearlyEmissionsPlot", brush = brushOpts(id = "emissionBrush",resetOnNew = TRUE),dblclick = "emissionDoubleClick"),
    uiOutput("yearlyEmissionsComponent"),
    actionButton("refreshYearlyEmissions", icon = icon("bar-chart"), "Refresh Plot"),
    downloadButton("downloadYearlyEmissions", "Download Plot")
)