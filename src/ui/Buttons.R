uploadButton = actionButton("uploadInput",
    icon = icon('upload'),
    label = "Upload Parameters"
)
saveFilePathInput = textInput("saveFilePath",
    label = NULL,   
    placeholder = "e.g. \"100_MH/run_2\" or \"zach\\\\100_MH\\\\demo\\\\\"" #demonstrating escaping backslashes with escaped backslashes
)
runMasterBatchButton = actionButton("runMasterBatch",
    icon = icon('refresh'),
    label = "Run Simulation"
)
saveButtonUI = uiOutput("saveButton")
