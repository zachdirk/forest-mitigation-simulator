menuItemLLPMix = menuItem(
    "Longer Lived Wood Products Commodity Mix",
    helpText("Default values correspond to the LLP scenario."),
    tabName = "hwpDistribution",
    icon = icon("percent"),
    radioButtons("sliderOrNumeric",
        label = "Choose how you'd like to input your values:",
        choices = c("Slider", "Numeric"),
        selected = "Slider",
        inline = TRUE
    ),
    htmlOutput("commodityDiff"),
    uiOutput("HWPInput"),
    actionButton("resetHWPDistribution",
        label = "Reset"
    ),
    actionButton("saveHWPDistribution",
        label = "Save"
    ),
    actionButton("loadHWPDistribution",
        label = "Load"
    )    
)