tabPanelCumulativeMitigation = tabPanel(
    strong("Cumulative Mitigation"),
    plotOutput("cumulativeMitigationPlot", brush = brushOpts(id = "cumulMitigationBrush",resetOnNew = TRUE),dblclick = "cumulMitigationDoubleClick"),
    actionButton('refreshCumulativeMitigation',icon = icon("bar-chart"), 'Refresh Plot'),
    downloadButton('downloadCumulativeMitigation','Download Plot')
)