# This is the file the initalizes everything. It's the first bit of R run after run.R, and it contains all the global variable declarations

#----------------------------------------------------------PACKAGES---------------------------------------------------------#
library("shiny")
library("shinyBS")
library("shinydashboard")
library("RSQLite")
library("ggplot2")
library("XLConnect")
library("reshape2")
library("xtable")
library("leaflet")
library("raster")
library("rgdal")
library("rgeos")
library("dplyr")
library("reshape")
library("RColorBrewer")
#-------------------------------------------------------GLOBAL VALUES-------------------------------------------------------#
setwd(file.path(getwd(), ".."))
source(file.path(getwd(), 'src', 'tools.R'), local=TRUE)
initRootDir = getwd()
initialMitigationDir = choose.dir(default = initRootDir, "Select the working mitigation directory")
if (is.na(initialMitigationDir)) #if they don't select a default directory, kill the program
    stop("ERROR! Please provide the inital working mitigation directory.")
batchDir = file.path(initRootDir, "config")
spatialDir = file.path(initRootDir, "data/spatial")
cbmOutputDirPath = paste("04_run_gcbm", "02_compile", "outputs", sep="/")

indicators = list.dirs(spatialDir, full.names = FALSE, recursive = FALSE)
indicatorLayers = vector("list")
timesteps = 0
for (i in indicators){
    rasters = list.files(file.path(spatialDir, i), pattern = ".grd", full.names = TRUE)
    timesteps = length(rasters)
    indicatorLayers[[i]] = stack(rasters)
}


startYear = 1990
activityStartYear = 2018
endYear = 2070

utilizationBase = 90
residuesBase = 25

sawnwoodBasePropotion = 42.0
panelsBasePropotion = 17.8
oirBasePropotion = 3.80
ppBasePropotion = 36.4

sawnwoodBaseDF = 0.54
panelsBaseDF = 0.45
oirBaseDF = 0
ppBaseDF = 0

sawnwoodCurrentPropotion = sawnwoodBasePropotion
panelsCurrentPropotion = panelsBasePropotion
oirCurrentPropotion = oirBasePropotion
ppCurrentPropotion = ppBasePropotion

savedUtilization = utilizationBase
savedResidues = residuesBase

sawnwoodSavedProportion = sawnwoodBasePropotion
panelsSavedProportion = panelsBasePropotion
ppSavedProportion = ppBasePropotion
oirSavedProportion = oirBasePropotion

sawnwoodSavedDF = sawnwoodBaseDF
panelsSavedDF = panelsBaseDF
ppSavedDF = oirBaseDF
oirSavedDF = ppBaseDF

inputParameters = data.frame(
    Parameters = c("No"),
    Values = c("data")
)

allStages = c("Run GCBM", "CBM Rollup", "Load HWP Inputs", "HWP Simulation", "Scenario Rollup", "Energy Displacement", "HWP and Displacement Rollup", "Estimate Mitigation", "Plot Results")

BC <- readOGR(
   spatialDir, layer="TSA_boundaries_2016", verbose=TRUE) %>%
   spTransform(CRS(
     "+proj=longlat +datum=NAD83 +no_defs +ellps=GRS80 +towgs84=0,0,0"))
BC = gSimplify(BC, tol = 0.01, topologyPreserve = TRUE)

editBatchParam("Change Scenario A", "FALSE")
editBatchParam("Change Scenario C", "FALSE")
editBatchParam("Change Scenario D", "FALSE")