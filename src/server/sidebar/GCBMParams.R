observe(
    {
        scens = input$gcbmScenarios
        if ("A" %in% scens)
            editBatchParam("Change Scenario A", "TRUE")
        else 
            editBatchParam("Change Scenario A", "FALSE")
        if ("C" %in% scens)
            editBatchParam("Change Scenario C", "TRUE")
        else 
            editBatchParam("Change Scenario C", "FALSE")
        if ("D" %in% scens)
            editBatchParam("Change Scenario D", "TRUE")
        else
            editBatchParam("Change Scenario D", "FALSE")
    }
)
observeEvent(
    input$utilizationSlider,
    {
        editBatchParam("CBMA Utilization", input$utilizationSlider/100)
    }
)
observeEvent(
    input$residuesSlider,
    {
        editBatchParam("CBMC Residue Capture", input$residuesSlider/100) 
    }
)
observeEvent(
    input$saveGCBM,
    {
        savedUtilization <<- input$utilizationSlider
        savedResidues <<- input$residuesSlider
    }
)
observeEvent(
    input$loadGCBM,
    {
        updateSliderInput(session, inputId = 'utilizationSlider', value = savedUtilization)
        updateSliderInput(session, inputId = 'residuesSlider', value = savedResidues)
    }
)
observeEvent(
    input$resetGCBM,
    {
        updateSliderInput(session, inputId = 'utilizationSlider', value = utilizationBase)
        updateSliderInput(session, inputId = 'residuesSlider', value = residuesBase)
        editBatchParam("Change Scenario A", "FALSE")
        editBatchParam("Change Scenario C", "FALSE")
        editBatchParam("Change Scenario D", "FALSE")
    }
)