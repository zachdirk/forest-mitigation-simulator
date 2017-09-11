output$map <- renderLeaflet({
    leaflet() %>% 
        setView(-121.3462231,51.638694 , zoom = 8) %>% 
        addProviderTiles("Esri.WorldShadedRelief", group="Tile Overview", options = providerTileOptions(noWrap = TRUE))%>% 
        addPolygons(data = BC, group="BC Boundary", fill=FALSE, stroke=TRUE, color="black", weight=2)
})

colorPalette = reactive({
    raster = getRaster()
    pal = brewer.pal(7, "YlGn")
    colorMap = colorNumeric(palette = pal, domain = values(raster), na.color = "transparent")
    return(colorMap)
})

getRaster = reactive({
    indicator = input$indicator
    timestep = input$timestep
    layer = indicatorLayers[[indicator]][[timestep]]
    return(layer)  
})

## For now anything that calls "getRaster()" is commented because that will crash when no raster data is present
## Hopefully when either Master Batch ingests the merge script or GCBM can output tiffs then this will all be updated
## to work with that output much more smoothly. Unfortunately I might not be there to do it.

# need to devise a solution that does not crash when there is no raster
#observe({
#    leafletProxy("map") 
#        removeImage(layerId = "raster") %>%
#        addRasterImage(getRaster(), colors = colorPalette(), layerId = "raster", opacity = 1, maxBytes =  42000000, project = FALSE)
#})

# need to devise a solution that does not crash when there is no raster
#observe({
#    title = paste(input$timestep+1989, input$indicator, sep = " ")
#    leafletProxy("map") %>%
#        addLegend(pal = colorPalette(), values = values(getRaster()), title = title, layerId = "raster")
#})