# These are helpful functions that do not fit in either the UI or Server categories.

# a functino to generate the batch script needed to run the scenarios
generateBatchFile = function(rootDir){
    bat = file.path(rootDir, "run_all_configured.bat")
    batConnection = file.path(batchDir, "generate_and_run.bat")
    writeLines(
        c(
            "@echo on",
            "echo 1 > temp.txt",
            "pushd %~dp0",
            "python M:/Spatially_explicit/01_Projects/13_PICS/06_Master_Batch_Interface/00_config_and_run/06_Testing/version_FMU/generate_batch_scripts.py FMS_Config.xls",
            paste("CALL \"", bat, "\"", sep = ""),
            "popd",
            "@echo on",
            "echo 0 > temp.txt",
            "pause"
        ), batConnection
    )
}

# a function to edit parameters in the excel configuration file
editBatchParam = function(variable, value){
    df = XLConnect::readWorksheetFromFile(file.path(batchDir, "FMS_Config.xls"), "Config")
    i = 0
    for (name in df[,3]){
        if (is.na(name))
            next
        if (name == variable){
            ind = i + 1
        }    
        i = i + 1
    }
    df[ind,4] = value
    writeWorksheetToFile(file.path(batchDir, "FMS_Config.xls"), df, "Config", styleAction = XLC$STYLE_ACTION.NONE)
}

# a function to read a value from the excel configuration file
read_batch_param = function(variable){
    df = XLConnect::readWorksheetFromFile(file.path(batchDir, "FMS_Config.xls"), "Config")
    i = 0
    for (name in df[,3]){
        if (is.na(name))
            next
        if (name == variable)
            ind = i + 1
        i = i + 1
    }
    return(df[ind,4]) 
}           

# a function to edit the color of an excel node 
# used to mark which stages of simulation to run
editBatchColor = function(variable, status){
    wb = loadWorkbook(file.path(batchDir, "FMS_Config.xls"))
    df = XLConnect::readWorksheetFromFile(file.path(batchDir, "FMS_Config.xls"), "Config")
    i = 0
    ind = 0
    for (name in df[,2]){
        if (is.na(name)){
            i = i + 1
            next
        }
        if (name == variable){
            ind = i + 2
        }    
        i = i + 1
    }
    CellColor = createCellStyle(wb)
    if (status == "on"){
        setFillPattern(CellColor, fill = XLC$"FILL.NO_FILL")
    }else if (status == "off"){
        setFillPattern(CellColor, fill = XLC$"FILL.SOLID_FOREGROUND")
        setFillForegroundColor(CellColor, color = XLC$"COLOR.CORAL")
    }
    setCellStyle(wb, sheet = "CONFIG", row = ind, col = 2, cellstyle=CellColor)
    saveWorkbook(wb)
}

# a function to read a csv input and set all the parameters
setValues = function(session, data){
	# this procedure splits "BASE, A, B, C, D, BASE, LLP" into a vector like c("A","B","C","D", "LLP")
	scen = paste(data["CBM Scenarios", 1], data["HWP Scenarios", 1], sep = ", ")
	scen = unlist(strsplit(scen, ", ", fixed = TRUE))
	scen = scen[scen != "BASE"]
    updateCheckboxGroupInput(session, "selectScenarios", selected = scen)
    
    updateTextInput(session, "spatialUnit", value = data["Spatial ID", 1])

    updateSliderInput(session, "yearRange", value = c(data["Start year", 1], data["End year",1]))

    updateSliderInput(session, "activityStartYear", value = data["Activity Start year", 1])
	
	updateSliderInput(session, "utilizationSlider", value = data["Utilization Rate", 1])
	
	updateSliderInput(session, "residuesSlider", value = data["Harvest Residues Rate", 1])
    
    updateSliderInput(session, "sawnwoodProportion", value = data["Sawnwood Proportion",1])
    
    updateSliderInput(session, "panelsProportion", value = data["Wood Panels Proportion",1])

    updateSliderInput(session, "oirProportion", value = data["Other Industrial Proportion",1])

    updateSliderInput(session, "ppProportion", value = data["Pulp and Paper Proportion",1])

    updateSliderInput(session, inputId = 'sawnwoodDFSlider', value = data["Sawnwood Displacement Factor",1])
    
    updateSliderInput(session, inputId = 'panelsDFSlider', value = data["Panels Displacement Factor",1])
    
    updateSliderInput(session, inputId = 'ppDFSlider', value = data["Pulp and Paper Displacement Factor",1])
    
    updateSliderInput(session, inputId = 'oirDFSlider', value = data["Other Industrial Roundwood Displacement Factor",1])
    
}