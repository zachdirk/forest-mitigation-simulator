tabPanelFutureTimberSupply = tabPanel(
    strong("Future Timber Supply"),
    plotOutput("futureTimberSupply", brush = brushOpts(id = "futureTimberSupplyBrush",resetOnNew = TRUE),dblclick = "futureTimberSupplyDoubleClick"),           
    actionButton('refreshFutureTimberSupply',icon = icon("bar-chart"), 'Refresh Plot'),
    downloadButton('downloadFutureTimberSupply','Download Plot')
)