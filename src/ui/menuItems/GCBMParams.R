menuItemGCBMParams = menuItem(
    "GCBM Parameters",
    tabName = "gcbm",
    icon = icon("sliders"),
    helpText("Adjust scenario-specific GCBM parameters."),
    helpText("Scenario A:"),
    sliderInput("utilizationSlider", 
        label = "Utilization Percentage",
        min = 0, max = 100, step = 0.5,
        value = utilizationBase
    ),
    helpText("Scenario C:"),
    sliderInput("residuesSlider", 
        label = "Residues Collected",
        min = 0, max = 100, step = 0.5,
        value = residuesBase
    ),
    checkboxGroupInput("gcbmScenarios",
        label = "Select GCBM scenarios to apply changes to:",
        choices = c("Increased Utilization (Scenario A)" = "A", "Harvest Residues (Scenario C)" = "C", "Inc. Util. & Harvest Residues (Scenario D)" = "D")
    ),
    actionButton("resetGCBM",
        label = "Reset"
    ),
    actionButton("saveGCBM",
        label = "Save"
    ),
    actionButton("loadGCBM",
        label = "Load"
    )
)