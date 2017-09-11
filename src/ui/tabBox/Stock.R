tabPanelStock = tabPanel(
    strong("Carbon Stocks"),
    plotOutput("stock", brush = brushOpts(id = "stockBrush",resetOnNew = TRUE),dblclick = "stockDoubleClick"),
    uiOutput("stockSelection"),
    actionButton("refreshStock", icon = icon("bar-chart"), "Refresh Plot"),
    downloadButton("downloadStock", "Download Plot")
)