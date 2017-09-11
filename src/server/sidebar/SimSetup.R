observe(
    {
        editBatchParam("CBM Scenarios", reactiveScenarios$cbmScenarios)
    }
)
observe(
    {
        editBatchParam("HWP Scenarios", reactiveScenarios$hwpScenarios)            
        
    }
)

observe(
    {
        scen = input$selectScenarios
        if ("LLP" %in% scen)
            reactiveScenarios$hwpScenarios = "BASE, LLP"
        else
            reactiveScenarios$hwpScenarios = "BASE"
        
        scen = scen[scen != "LLP"]
        
        if (length(scen) == 0)
            reactiveScenarios$cbmScenarios = "BASE"
        else
            reactiveScenarios$cbmScenarios = paste("BASE", paste(scen, collapse = ", "), sep = ", ")
    }
)
observeEvent(
    input$spatialUnit,
    {
        editBatchParam("Spatial ID", input$spatialUnit) 
    }
)
observeEvent(
    input$yearRange,
    {
        editBatchParam("Start year", input$yearRange[1]) 
        editBatchParam("End year", input$yearRange[2]) 
    }
)
observeEvent(
    input$activityStartYear,
    {
        editBatchParam("Activity Start year", input$activityStartYear) 
    }
)
observe({
    if(input$selectRootButton > 0){
        # lets the user cancel the selection without crashing the program
        newDir = choose.dir(default = getwd())
        if (!is.na(newDir)) {
            reactiveDirectories$rootDir = newDir
        }
    }
})
observe({
    editBatchParam("Directory Path", reactiveDirectories$rootDir)
})
observe({
    editBatchParam("CBM Output Directory", file.path(reactiveDirectories$rootDir, cbmOutputDirPath))
})
observe({
    small = input$yearRange[1]
    big = input$yearRange[2]
    val = input$activityStartYear
    if (val < small)
        val = small
    if (val > big)
        val = big
    updateSliderInput(session, "activityStartYear", value = val, min = small, max = min(big, 2035))
})