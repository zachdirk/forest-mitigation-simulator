# All the real UI code is not located in this file, rather it is organized within the src/ui folder.
# This is to try and keep things segregated and easier to work on
# Otherwise this file would be hundreds of lines long and very difficult to parse 
# When creating a new ui element, you must define the object in the other file,
# then reference the object here. See the examples.


# The general structure for ui files is as follows:
# All ui files are somewhere within in src/ui (exception for this file)
# All ui code related to the 3 buttons and file input in the bottom left of the sidebar are in src/ui/buttons.R
# All ui code related to the tab box (where the plots and map are) is located in src/ui/tabBox
# All ui code related to the 4 menuItems in the sidebar is located in src/ui/menuItems
# All ui code for the hover tooltips is located in the src/ui/tooltips.R file

# This bit here just sources all the src/ui files. 
# If your ui code is not in a file somewhere in src/ui, it will not be found
for (f in list.files("src/ui",pattern="\\.R$", recursive = TRUE, full.names = TRUE, ignore.case = TRUE)){ 
    source(f, local = TRUE)
}
#-----------------------------------------------------------HEADER------------------------------------------------------------#
header = dashboardHeader(
    title = "Forest Mitigation Simulator", 
    titleWidth = 340
)
#-----------------------------------------------------------SIDEBAR-----------------------------------------------------------#
sidebar = dashboardSidebar(
    width = 340,
    sidebarMenu(
        menuItemSimSetup, #see ui/menuItems/simSetup.R
		menuItemGCBMParams, #see ui/menuItems/GCBMParams.R
        menuItemLLPMix, #see ui/menuItems/LLPMix.R
        menuItemHWPDisplacementFactors #see ui/menuItems/HWPDisplacementFactors.R
    ),
    uploadButton, # see ui/buttons.R
    saveFilePathInput, # see ui/buttons.R
    runMasterBatchButton, # see ui/buttons.R
    saveButtonUI, # see ui/buttons.R
    tooltips #see ui/tooltips
)
#-------------------------------------------------------------BODY------------------------------------------------------------#
body = dashboardBody(
    tags$head(
        # this sets up the fms to use my custom css sheet located in src/www
        tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
		# uncomment this to get a scrollbar on the left hand sidebar when it overflows
        #tags$style(HTML(".sidebar { height: 86vh; overflow-y: auto; }"))
    ),
#------------------------------------------------------------TABBOX-----------------------------------------------------------#
    tabBox(
        side = "left",
        width = "100%",
        tabPanelYearlyEmissions, #see ui/tabBox/annualCarbonEmissions.R
        tabPanelYearlyMitigation, #see ui/tabBox/annualMitigation.R
        tabPanelCumulativeMitigation, #see ui/tabBox/cumulativeMitigation.R
        tabPanelCumulativeMitigationByComponent, #see ui/tabBox/cumulativeMitigationByComponent.R
        tabPanelPool, #see ui/tabBox/Pool.R
        tabPanelStock, #see ui/tabBox/Stock.R
        tabPanelFutureTimberSupply, #see ui/tabBox/FutureTimberSupply.R
        tabPanelMap #see ui/tabBox/Map.R
    )

)

dashboardPage(header, sidebar, body)
