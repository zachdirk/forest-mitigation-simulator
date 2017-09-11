#--------------------------------------------------------------SERVER-------------------------------------------------------------#
shinyServer(function(input,output,session){
    # All code for server files is located elsewhere, this is to try and keep things segregated and easier to work on
    # Otherwise this file would be thousands of lines long and very difficult to parse 
    # You do not need to explicitely reference the server code you are sourcing, as it is reactive code
    # that just waits for a change in the input.
    
    # The general structure for server files is as follows:
    # All server files are somewhere within in src/server (exception for this file)
    # All reactive variables (such as directory names) are in src/server/ReactiveVariables.R
    # All server code related to the 3 buttons in the bottom left of the sidebar are in src/server/buttons
    # All server code related to the tab box (where the plots and map are) is located in src/server/plots
    # All server code related to the 4 menuItems in the sidebar is located in src/server/sidebar
    
    # It may seem confusing at first but in the long run as more features are added it greatly simplifies the task
    # Of working on individual features at the expense of time to locate the code for that feature, but that can 
    # be mitigated with proper organization

    # This bit here just sources all the src/server files. 
    # If your server code is not in a file somewhere in src/server, it will not be found
    for (f in list.files("src/server",pattern="\\.R$", recursive = TRUE, full.names = TRUE, ignore.case = TRUE)){ 
        source(f, local = TRUE)
    }

    # when the website is closed, the app will stop running
    session$onSessionEnded(function() {
        stopApp()
    })
})