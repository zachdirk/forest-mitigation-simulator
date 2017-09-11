tabPanelMap = tabPanel(
    strong("Map"),
    leafletOutput("map", width = '100%', height = 700),
    p(),
    sliderInput("timestep", "Timestep", 1, timesteps, 1),
    radioButtons("indicator", "Select Indicator", choices = indicators, selected = "Age", inline = TRUE)
)