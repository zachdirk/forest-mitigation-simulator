tabPanelCumulativeMitigationByComponent = tabPanel(
    strong("Cumulative Mitigation by Component"),
    plotOutput("cumualtiveMitigationBarByComponent", brush = brushOpts(id = "cumulMitigationByComponentBrush",resetOnNew = TRUE),dblclick = "cumulMitigationByComponentDoubleClick"),           
    uiOutput('mitigationByComponentYearSlider'),
    actionButton('refreshMitigationByComponent',icon = icon("bar-chart"), 'Refresh Plot'),
    downloadButton('downloadMitigationByComponent','Download Plot')
)