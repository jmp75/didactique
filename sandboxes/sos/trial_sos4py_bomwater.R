## ---- include = FALSE--------------------------------------------------------------------------------------------------------------------------------------------


## ----setup-------------------------------------------------------------------------------------------------------------------------------------------------------
library(devtools)
devtools::load_all('/home/per202/src/github/sos4R')


## ----niwa_hydro--------------------------------------------------------------------------------------------------------------------------------------------------
niwaHydro <- SOS(url = "https://hydro-sos.niwa.co.nz/",
                  binding = "POX", useDCPs = FALSE,
                  #binding = "KVP",
                  version = "2.0.0",
                 verboseOutput = TRUE)
sosContents(niwaHydro)


## ----niwa_hydro_data---------------------------------------------------------------------------------------------------------------------------------------------
#sosResponseFormats(niwaHydro)
discharge29808 <- getObservation(sos = niwaHydro,
                                 observedProperty = list("Discharge"), # phenomena
                                 featureOfInterest = list("29808"), # sites
                                 #saveOriginal = "../tests/responses/hydro-sos.niwa.co.nz_Discharge_29808.xml",
                                 #responseFormat = "http://www.opengis.net/waterml/2.0",
                                 #inspect = TRUE,
                                 retrieveFOI = FALSE)
sosResult(discharge29808)


## ----niwa_climate------------------------------------------------------------------------------------------------------------------------------------------------
# service offline - HTTP 503
#niwaClimate <- SOS(url = "http://clidb-sos.niwa.co.nz/sos/kvp", binding = "KVP", useDCPs = FALSE, version = "2.0.0")
#sosContents(niwaClimate)


## ----bom_hydro---------------------------------------------------------------------------------------------------------------------------------------------------
bomHydro <- SOS(url = "http://www.bom.gov.au/waterdata/services?service=SOS&version=2.0.0",
#bomHydro <- SOS(url = "http://www.bom.gov.au/waterdata/services", 
                 binding = "POX",
                 version = "2.0.0",
                useDCPs = FALSE,
                 verboseOutput = TRUE)
sosContents(bomHydro)


## ----bom_hydro_data----------------------------------------------------------------------------------------------------------------------------------------------
#sosResponseFormats(bomHydro)
discharge29808 <- getObservation(sos = bomHydro,
                                 observedProperty = list("Discharge"), # phenomena
                                 featureOfInterest = list("29808"), # sites
                                 #saveOriginal = "../tests/responses/hydro-sos.bom.co.nz_Discharge_29808.xml",
                                 #responseFormat = "http://www.opengis.net/waterml/2.0",
                                 #inspect = TRUE,
                                 retrieveFOI = FALSE)
sosResult(discharge29808)


## ----bom_climate-------------------------------------------------------------------------------------------------------------------------------------------------

