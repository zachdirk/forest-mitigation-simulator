observeEvent(
    input$sawnwoodProportion,
    {
        editBatchParam("Sawnwood Proportion", input$sawnwoodProportion/100) 
    }
)
observeEvent(
    input$panelsProportion,
    {
        editBatchParam("Wood Panels Proportion", input$panelsProportion/100) 
    }
)
observeEvent(
    input$ppProportion,
    {
        editBatchParam("Pulp and Paper Proportion", input$ppProportion/100) 
    }
)
observeEvent(
    input$oirProportion,
    {
        editBatchParam("Other Industrial Proportion", input$oirProportion/100) 
    }
)
observeEvent(
    input$saveHWPDistribution,
    {
        sawnwoodSavedProportion <<- input$sawnwoodProportion
        panelsSavedProportion <<- input$panelsProportion
        ppSavedProportion <<- input$ppProportion
        oirSavedProportion <<- input$oirProportion
    }
)
observeEvent(
    input$loadHWPDistribution,
    {
        updateSliderInput(session, inputId = 'sawnwoodProportion', value = sawnwoodSavedProportion)
        updateSliderInput(session, inputId = 'panelsProportion', value = panelsSavedProportion)
        updateSliderInput(session, inputId = 'ppProportion', value = ppSavedProportion)
        updateSliderInput(session, inputId = 'oirProportion', value = oirSavedProportion)
    }
)
observeEvent(
    input$resetHWPDistribution,
    {
        updateSliderInput(session, inputId = 'sawnwoodProportion', value = sawnwoodBasePropotion)
        updateSliderInput(session, inputId = 'panelsProportion', value = panelsBasePropotion)
        updateSliderInput(session, inputId = 'ppProportion', value = ppBasePropotion)
        updateSliderInput(session, inputId = 'oirProportion', value = oirBasePropotion)
    }
)