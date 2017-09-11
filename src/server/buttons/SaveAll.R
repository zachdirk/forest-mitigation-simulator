#reactively generates the label for the save button based on what the user has currently input as their save directory
output$saveButton = renderUI({
    saveFilePath <<- gsub("[[:space:]]","",input$saveFilePath) #removes all whitespaces
    if (saveFilePath == "")
        label = "Supply a filepath to enable saving."
    else
        label = paste("Save to",file.path("output",saveFilePath), sep = " ")
    actionButton("saveToResults",
        label = label,
        width = "332px"
    )
})

observeEvent(
    input$saveToResults,
    {
        i = 2
        if (saveFilePath != "")
            resultDir <<- file.path(getwd(),"/output",saveFilePath)
        else
            resultDir <<- file.path(getwd(),"/output","default")
            
        if (!dir.exists(resultDir))
            dir.create(file.path(resultDir,"Plots"), recursive=TRUE)
        else {
            while(dir.exists(resultDir)){
                resultDir <<- file.path(getwd(),"/output",saveFilePath)
                resultDir <<- paste(resultDir, "_(", i, ")",sep = "")
                i = i + 1
            }
            dir.create(file.path(resultDir,"plots"), recursive=TRUE)
        }
        write.csv(inputParameters, file.path(resultDir, "parameters.csv"))
        ggsave(filename = "Yearly_forest_mitigation.png", plot = yearlyMitiPlot("Forest"), path = paste(resultDir,"plots",sep="/"),  height = 6, width = 13)
        ggsave(filename = "Yearly_hwp_mitigation.png", plot = yearlyMitiPlot("Harvested Wood Products"), path = paste(resultDir,"plots",sep="/"),  height = 6, width = 13)
        ggsave(filename = "Yearly_dfp_mitigation.png", plot = yearlyMitiPlot("Wood Product Displacement"), path = paste(resultDir,"plots",sep="/"),  height = 6, width = 13)
        ggsave(filename = "Yearly_dfe_mitigation.png", plot = yearlyMitiPlot("Energy Displacement"), path = paste(resultDir,"plots",sep="/"),  height = 6, width = 13)
        ggsave(filename = "Yearly_total_mitigation.png", plot = yearlyMitiPlot("Total"), path = paste(resultDir,"plots",sep="/"),  height = 6, width = 13)
        ggsave(filename = "Yearly_forest_emissions.png", plot = yearlyMitiPlot("Forest"), path = paste(resultDir,"plots",sep="/"),  height = 6, width = 13)
        ggsave(filename = "Yearly_hwp_emissions.png", plot = yearlyEmissionsPlot("Harvested Wood Products"), path = paste(resultDir,"plots",sep="/"),  height = 6, width = 13)
        ggsave(filename = "Yearly_dfe_emissions.png", plot = yearlyEmissionsPlot("Energy Displacement"), path = paste(resultDir,"plots",sep="/"),  height = 6, width = 13)
        ggsave(filename = "Yearly_dfp_emissions.png", plot = yearlyEmissionsPlot("Wood Product Displacement"), path = paste(resultDir,"plots",sep="/"),  height = 6, width = 13)
        ggsave(filename = "Yearly_total_emissions.png", plot = yearlyEmissionsPlot("Total"), path = paste(resultDir,"plots",sep="/"),  height = 6, width = 13) 
        ggsave(filename = "Cumulative_mitigation_plot.png", plot = cumulativeMitiPlot(), path = paste(resultDir,"plots",sep="/"),  height = 6, width = 13)
        ggsave(filename = "Cumulative_mitigation_by_component_2020.png", plot = cumulativeMitiBarByComponent(2020), path = paste(resultDir,"plots",sep="/"),  height = 6, width = 13)
        ggsave(filename = "Cumulative_mitigation_by_component_2030.png", plot = cumulativeMitiBarByComponent(2030), path = paste(resultDir,"plots",sep="/"),  height = 6, width = 13)
        ggsave(filename = "Cumulative_mitigation_by_component_2050.png", plot = cumulativeMitiBarByComponent(2050), path = paste(resultDir,"plots",sep="/"),  height = 6, width = 13)
        ggsave(filename = "Cumulative_mitigation_by_component_2070.png", plot = cumulativeMitiBarByComponent(2070), path = paste(resultDir,"plots",sep="/"),  height = 6, width = 13)
        # manually copying the databases using SQL is about 3x faster than doing it via system commands
        # really only significant on the very large databases
        if ("CBM" %in% input$saveDatabases){
            dir.create(file.path(resultDir, "databases", "CBM_rollup_input"), recursive = TRUE)
            dir.create(file.path(resultDir, "databases", "CBM_rollup_output"), recursive = TRUE)
            oldDatabasePath = file.path(reactiveDirectories$rootDir, "06_cbm_rollup/inputs")
            newDatabasePath = file.path(resultDir, "databases", "CBM_rollup_input")
            for (dbfile in list.files(path = oldDatabasePath, pattern = "*.db")){
                db1 = dbConnect(RSQLite::SQLite(), file.path(oldDatabasePath, dbfile))
                db2 = dbConnect(RSQLite::SQLite(), file.path(newDatabasePath, dbfile))
                sqliteCopyDatabase(db1, db2)
            }
            oldDatabasePath = file.path(reactiveDirectories$rootDir, "06_cbm_rollup/outputs")
            newDatabasePath = file.path(resultDir, "databases", "CBM_rollup_output")
            for (dbfile in list.files(path = oldDatabasePath, pattern = "*.db")){
                db1 = dbConnect(RSQLite::SQLite(), file.path(oldDatabasePath, dbfile))
                db2 = dbConnect(RSQLite::SQLite(), file.path(newDatabasePath, dbfile))
                sqliteCopyDatabase(db1, db2)
                dbDisconnect(db1)
                dbDisconnect(db2)
            }
        }
        if ("HWP" %in% input$saveDatabases){
            dir.create(file.path(resultDir, "databases", "HWP"), recursive = TRUE)
            file.copy(file.path(reactiveDirectories$rootDir, "07_hwp"), file.path(resultDir, "databases", "HWP"), recursive = TRUE)
        }
        if ("Miti" %in% input$saveDatabases){
            dir.create(file.path(resultDir, "databases", "Miti"), recursive = TRUE)
            file.copy(file.path(reactiveDirectories$rootDir, "09_miti"), file.path(resultDir, "databases", "Miti"), recursive = TRUE)
        }
        updateActionButton(session, "saveToResults", "Finished saving!", icon("check"))
    }
)