menuItemSimSetup = menuItem(
    "Simulation Setup",
    tabName = "settings",
    icon = icon("cog"),
    actionButton("selectRootButton","Select Root of Working Mitigation Directory"),
    checkboxGroupInput("stages",
        label = "Select which stages to run:",
        choices = c("Run GCBM", "CBM Rollup", "Scenario Rollup", "Load HWP Inputs", "HWP Simulation", "Energy Displacement", "HWP and Displacement Rollup", "Estimate Mitigation"),
        inline = FALSE
    ),
    checkboxGroupInput("selectScenarios",
        label = "Select which CBM scenarios to run:",
        choices = c("Increased Utilization" = "A","Harvest Less" = "B","Collect Harvest Residues for Bioenergy" = "C","Increased Utilization and Harvest Residues" = "D","Longer Lived Products" = "LLP"),
        selected = c("A","B","C","D", "LLP")
    ),
    checkboxGroupInput("saveDatabases",
        label = "Select which databases to save:",
        choices = c("CBM", "HWP", "Miti"),
        inline = TRUE
    ),
    
    textInput("spatialUnit",
        label = "Provide a spatial unit:",
        value = "FMU:110001",
        placeholder = "e.g. \"MSPU:110047\""
    ),
    sliderInput("yearRange",
        label = "Adjust simulation start and end years:",
        min = 1990,
        max = 2070,
        value = c(1990, 2070),
        step = 1
    ),
    sliderInput("activityStartYear",
        label = "Adjust mitigation activity Start Year:",
        min = 1990,
        max = 2035,
        value = 2018,
        step = 1
    )
)