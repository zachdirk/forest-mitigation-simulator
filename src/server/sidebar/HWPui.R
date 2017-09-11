#this file exists to provide the two different input formats for the LLP wood mix

#this is a workaround to the problem that rendered UI is initially hidden and therefore suspended meaning it will never be updated or shown to the user
output$HWPInput <- renderUI({})
outputOptions(output, "HWPInput", suspendWhenHidden = FALSE)
output$commodityDiff <- renderUI({})
outputOptions(output, "commodityDiff", suspendWhenHidden = FALSE)

output$HWPInput = renderUI({
    if (input$sliderOrNumeric == "Slider"){
        list(
            sliderInput("sawnwoodProportion", 
                label = "Sawnwood",
                min = 0, max = 100, step = 0.1,
                value = sawnwoodCurrentPropotion
            ),
            sliderInput("panelsProportion", 
                label = "Panels",
                min = 0, max = 100, step = 0.1,
                value = panelsCurrentPropotion

            ),
            sliderInput("oirProportion", 
                label = "Other Industrial Roundwood",
                min = 0, max = 100, step = 0.1,
                value = oirCurrentPropotion
            ),
            sliderInput("ppProportion", 
                label = "Pulp & Paper",
                min = 0, max = 100, step = 0.1,
                value = ppCurrentPropotion
            ),
            bsTooltip(id = "sawnwoodProportion", title = "Modify the sawnwood proportion. The value in the base scenario is 42.0", placement = "bottom", trigger = "hover"),
            bsTooltip(id = "panelsProportion", title = "Modify the Panels proportion. The value in the base scenario is 13.8", placement = "bottom", trigger = "hover"),
            bsTooltip(id = "oirProportion", title = "Modify the OIR proportion. The value in the base scenario is 3.80", placement = "bottom", trigger = "hover"),
            bsTooltip(id = "ppProportion", title = "Modify the Pulp & Paper proportion. The value in the base scenario is 40.4", placement = "bottom", trigger = "hover")
        )
    } else {
        list(
            numericInput("sawnwoodProportion", 
                label = "Sawnwood",
                min = 0, max = 100, step = 0.1,
                value = sawnwoodCurrentPropotion

            ),
            numericInput("panelsProportion", 
                label = "Panels",
                min = 0, max = 100, step = 0.1,
                value = panelsCurrentPropotion

            ),
            numericInput("oirProportion", 
                label = "Other Industrial Roundwood",
                min = 0, max = 100, step = 0.1,
                value = oirCurrentPropotion
            ),
            numericInput("ppProportion", 
                label = "Pulp & Paper",
                min = 0, max = 100, step = 0.1,
                value = ppCurrentPropotion
            ),
            bsTooltip(id = "sawnwoodProportion", title = "Modify the sawnwood proportion. The value in the base scenario is 42.0", placement = "bottom", trigger = "hover"),
            bsTooltip(id = "panelsProportion", title = "Modify the Panels proportion. The value in the base scenario is 13.8", placement = "bottom", trigger = "hover"),
            bsTooltip(id = "oirProportion", title = "Modify the OIR proportion. The value in the base scenario is 3.80", placement = "bottom", trigger = "hover"),
            bsTooltip(id = "ppProportion", title = "Modify the Pulp & Paper proportion. The value in the base scenario is 40.4", placement = "bottom", trigger = "hover")
        )
    }
})
output$commodityDiff = renderUI({
    mix = input$sawnwoodProportion + input$panelsProportion + input$ppProportion + input$oirProportion
    if (isTRUE(all.equal(mix, 100))){
        HTML("Your distribution equals exactly 100 and is a valid input.")
    } else {
        HTML(paste(sprintf("Your distribution is %f, and is an invalid input.", mix), "Please have your distribution total to exactly 100.", sep = "<br/>"))
        # HTML(paste(u,v,sep = "<br/>"))
    }
})
# this is necessary to ensure both input formats maintain the same values
observe({
    sawnwoodCurrentPropotion <<- input$sawnwoodProportion
})
observe({
    panelsCurrentPropotion <<- input$panelsProportion
})
observe({
    ppCurrentPropotion <<- input$ppProportion
})
observe({
    oirCurrentPropotion <<- input$oirProportion
})