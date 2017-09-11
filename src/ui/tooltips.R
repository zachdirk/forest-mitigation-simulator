
tooltips = list(
#-------------------------------------------------------SETTINGS TOOLTIPS-----------------------------------------------------#
    bsTooltip(id = "stages", title = "Select which stages of the mitigation process to run", placement = "bottom", trigger = "hover"),
    bsTooltip(id = "selectScenarios", title = "Select which CBM scenarios to use in the simulation", placement = "top", trigger = "hover"),
    bsTooltip(id = "saveDatabases", title = "Select which databases to save alongside the plots. CAUTION! CBM takes >10 minutes to save", placement = "top", trigger = "hover"),
    bsTooltip(id = "landfills", title = "You can save time at the cost of accuracy by disabling landfills in HWP", placement = "top", trigger = "hover"),
    bsTooltip(id = "spatialUnit", title = "Must be of the form type:number e.g.: MSPU:110010", placement = "top", trigger = "hover"),
    bsTooltip(id = "yearRange", title = "Choose the starting year for simulation and the ending year", placement = "top", trigger = "hover"),
    bsTooltip(id = "activityStartYear", title = "Activity defines all things that are considered mitigation", placement = "top", trigger = "hover"),
#-----------------------------------------------------DISPLACEMENT TOOLTIPS---------------------------------------------------#
    bsTooltip(id = "utilizationSlider", title = "Select a utilization rate for scenarios A and D, default is 90%", placement = "bottom", trigger = "hover"),
    bsTooltip(id = "residuesSlider", title = "Select what percentage of residues are to be captured for bioenergy in scenario C, default is 25%", placement = "top", trigger = "hover"),
    bsTooltip(id = "gcbmScenarios", title = "Select which scenarios to run in GCBM (i.e. if you changed the utilization rate, you should select A and D)", placement = "top", trigger = "hover"),
    bsTooltip(id = "resetGCBM", title = "Reset utilization and harvest residue capture rates to base values", placement = "top", trigger = "hover"),
    bsTooltip(id = "saveGCBM", title = "Save utilization and harvest residue capture rates", placement = "top", trigger = "hover"),
    bsTooltip(id = "loadGCBM", title = "Load utilization and harvest residue capture rates", placement = "top", trigger = "hover"),
#-----------------------------------------------------HWP COMMODITY TOOLTIPS--------------------------------------------------#
    # SEE SERVER.R output$HWPInput FUNCTION FOR REST OF TOOLTIPS
    bsTooltip(id = "resetHWPDistribution", title = "Reset commodity mix to LLP values", placement = "top", trigger = "hover"),
    bsTooltip(id = "saveHWPDistribution", title = "Save current mix to be loaded later", placement = "top", trigger = "hover"),
    bsTooltip(id = "loadHWPDistribution", title = "Load previously saved mix", placement = "top", trigger = "hover"),
#-----------------------------------------------------DISPLACEMENT TOOLTIPS---------------------------------------------------#
    bsTooltip(id = "sawnwoodDFSlider", title = "Select a displacement factor for Sawnwood", placement = "bottom", trigger = "hover"),
    bsTooltip(id = "panelsDFSlider", title = "Select a displacement factor for Panels", placement = "top", trigger = "hover"),
    bsTooltip(id = "oirDFSlider", title = "Select a displacement factor for OIR", placement = "top", trigger = "hover"),
    bsTooltip(id = "ppDFSlider", title = "Select a displacement factor for Pulp & Paper", placement = "top", trigger = "hover"),
    bsTooltip(id = "resetHWPDF", title = "Reset DFs to base values", placement = "top", trigger = "hover"),
    bsTooltip(id = "saveHWPDF", title = "Save current DFs to be loaded later", placement = "top", trigger = "hover"),
    bsTooltip(id = "loadHWPDF", title = "Load previously saved DFs", placement = "top", trigger = "hover"),
#--------------------------------------------------------BUTTONS TOOLTIPS-----------------------------------------------------#
    bsTooltip(id = "uploadInput", title = "Click here to search for a csv table to upload parameters", placement = "top", trigger = "hover"),
    bsTooltip(id = "runMasterBatch", title = "Click here to start a simulation based on your parameters", placement = "top", trigger = "hover"),
    bsTooltip(id = "saveFilePath", title = "Enter a filepath here, it will be appended to the output folder", placement = "top", trigger = "hover"),
    bsTooltip(id = "saveButton", title = "Click here to copy all the plots and the input parameters to the filepath you provided", placement = "top", trigger = "hover")
)