observeEvent(
    input$sawnwoodDFSlider,
    {
        editBatchParam("Sawnwood Displacement Factor", input$sawnwoodDFSlider) 
    }
)
observeEvent(
    input$panelsDFSlider,
    {
        editBatchParam("Panels Displacement Factor", input$panelsDFSlider)
    }
)
observeEvent(
    input$ppDFSlider,
    {
        editBatchParam("Pulp and Paper Displacement Factor", input$ppDFSlider) 
    }
)
observeEvent(
    input$oirDFSlider,
    {
        editBatchParam("Other Industrial Roundwood Displacement Factor", input$oirDFSlider) 
    }
)
observeEvent(
    input$sawnwoodDFSlider,
    {
        editBatchParam("Sawnwood Displacement Factor", input$sawnwoodDFSlider) 
    }
)
observeEvent(
    input$panelsDFSlider,
    {
        editBatchParam("Panels Displacement Factor", input$panelsDFSlider)
    }
)
observeEvent(
    input$ppDFSlider,
    {
        editBatchParam("Pulp and Paper Displacement Factor", input$ppDFSlider) 
    }
)
observeEvent(
    input$oirDFSlider,
    {
        editBatchParam("Other Industrial Roundwood Displacement Factor", input$oirDFSlider) 
    }
)
observeEvent(
    input$saveHWPDF,
    {
        sawnwoodSavedDF <<- input$sawnwoodDFSlider
        panelsSavedDF <<- input$panelsDFSlider
        ppSavedDF <<- input$ppDFSlider
        oirSavedDF <<- input$oirDFSlider
    }
)
observeEvent(
    input$loadHWPDF,
    {
        updateSliderInput(session, inputId = 'sawnwoodDFSlider', value = sawnwoodSavedDF)
        updateSliderInput(session, inputId = 'panelsDFSlider', value = panelsSavedDF)
        updateSliderInput(session, inputId = 'ppDFSlider', value = ppSavedDF)
        updateSliderInput(session, inputId = 'oirDFSlider', value = oirSavedDF)
    }
)

observeEvent(
    input$resetHWPDF,
    {
        updateSliderInput(session, inputId = 'sawnwoodDFSlider', value = sawnwoodBaseDF)
        updateSliderInput(session, inputId = 'panelsDFSlider', value = panelsBaseDF)
        updateSliderInput(session, inputId = 'ppDFSlider', value = ppBaseDF)
        updateSliderInput(session, inputId = 'oirDFSlider', value = oirBaseDF)
    }
)