tabPanelPool = tabPanel(
    strong("Carbon Pools"),
    plotOutput("pool", brush = brushOpts(id = "poolBrush",resetOnNew = TRUE),dblclick = "poolDoubleClick"),
    uiOutput("poolSelection"),
    actionButton("refreshPool", icon = icon("bar-chart"), "Refresh Plot"),
    downloadButton("downloadPool", "Download Plot")
)