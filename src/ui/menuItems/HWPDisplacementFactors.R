menuItemHWPDisplacementFactors = menuItem(
    "Wood Product Displacement Factors",
    tabName = "hwpDF",
    icon = icon("truck"),
    helpText("Adjust displacement factors for material products"),
    sliderInput("sawnwoodDFSlider", 
        label = "Sawnwood",
        min = 0, max = 2.1, step = 0.01,
        value = sawnwoodBaseDF
    ),
    sliderInput("panelsDFSlider", 
        label = "Panels",
        min = 0, max = 2.1, step = 0.01,
        value = panelsBaseDF
    ),
    sliderInput("oirDFSlider", 
        label = "Other Industrial Roundwood",
        min = 0, max = 2.1, step = 0.01,
        value = oirBaseDF
    ),
    sliderInput("ppDFSlider", 
        label = "Pulp & Paper",
        min = 0, max = 2.1, step = 0.01,
        value = ppBaseDF
    ),
    actionButton("resetHWPDF",
        label = "Reset"
    ),
    actionButton("saveHWPDF",
        label = "Save"
    ),
    actionButton("loadHWPDF",
        label = "Load"
    )
)