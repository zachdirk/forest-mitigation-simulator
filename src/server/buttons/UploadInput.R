observeEvent(
    input$uploadInput,
    {
        # the trycatch lets people cancel the input without crashing the interface
        inFile = tryCatch({file.choose()}, warning = function(w) {""}, error = function(e) {""})
        if (inFile != "")
            setValues(session = session, data = read.csv(inFile,stringsAsFactors = FALSE, header = TRUE, row.names = c(1)))
    }
)