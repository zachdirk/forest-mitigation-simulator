#reactive variables
reactiveScenarios = reactiveValues(cbmScenarios = "BASE, A, B, C, D", hwpScenarios = "BASE, LLP")
reactiveDirectories = reactiveValues(
    rootDir = initialMitigationDir, 
    resultsOutputDir = file.path(initialMitigationDir, "09_miti", "05_compile_results", "outputs", "results_output.db"), 
    gcbmOutputDir = file.path(initialMitigationDir, "04_run_gcbm","02_compile","outputs"),
    scenarioRollupDir = file.path(initialMitigationDir, "09_miti", "02_compile_mea_results", "outputs", "scenario_rollup.db")
)

rangesEmissions                  = reactiveValues(x = NULL, y = NULL)
rangesMitigation                 = reactiveValues(x = NULL, y = NULL)
rangesCumulMitigation            = reactiveValues(x = NULL, y = NULL)
rangesCumulMitigationByComponent = reactiveValues(x = NULL, y = NULL)
rangesPools                      = reactiveValues(x = NULL, y = NULL)
rangesStocks                     = reactiveValues(x = NULL, y = NULL)
rangesFutureTimberSupply         = reactiveValues(x = NULL, y = NULL)

observe({
    reactiveDirectories$scenarioRollupDir = file.path(reactiveDirectories$rootDir, "09_miti", "02_compile_mea_results", "outputs", "scenario_rollup.db")
})

observe({
    reactiveDirectories$resultsOutputDir = file.path(reactiveDirectories$rootDir, "09_miti", "05_compile_results", "outputs", "results_output.db")
})
observe({
    reactiveDirectories$gcbmOutputDir = file.path(reactiveDirectories$rootDir, cbmOutputDirPath)
})