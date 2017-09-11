observeEvent(
    input$runMasterBatch,
    {   
        #turn all stages off then turn on the ones that are selected
        #rshiny has an issue where when the last item in a checkbox select is deselected, it doesn't trigger
        #so this is the only way to guarantee that a run with no stages will in fact run no stages
        for (stage in allStages){
            editBatchColor(stage, "off")
        }
        for (stage in input$stages){
            editBatchColor(stage, "on")
        }
        generateBatchFile(reactiveDirectories$rootDir) #because we don't know which directory we're in we'll have to generate the batch script on the fly
        shell.exec(file.path(batchDir, "generate_and_run.bat"))
    }
)