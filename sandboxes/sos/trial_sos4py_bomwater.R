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


url <- "http://www.bom.gov.au/waterdata/services?service=SOS&version=2.0.0"
# url <- "https://hydro-sos.niwa.co.nz/"

.requestString <- "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<GetCapabilities xmlns=\"http://www.opengis.net/sos/1.0\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:ows=\"http://www.opengis.net/ows/1.1\" xmlns:ogc=\"http://www.opengis.net/ogc\" service=\"SOS\">\n  <ows:AcceptVersions>\n    <ows:Version>2.0.0</ows:Version>\n  </ows:AcceptVersions>\n  <ows:Sections>\n    <ows:Section>All</ows:Section>\n  </ows:Sections>\n  <ows:AcceptFormats>\n    <ows:OutputFormat>text/xml</ows:OutputFormat>\n  </ows:AcceptFormats>\n</GetCapabilities>\n"

response <- httr::POST(url = url,
                       httr::content_type_xml(),
                       httr::accept_xml(),
                       body = .requestString )

response <- httr::POST(url = "http://www.bom.gov.au/waterdata/services?service=SOS&version=2.0.0&request=GetCapabilities",
                       httr::content_type_xml(),
                       httr::accept_xml(),
                       body = .requestString )

contentType <- httr::http_type(response)

if (!httr::has_content(response)) {
  warning("Response has no content: ", toString(response),
          " | headers: ", paste(names(httr::headers(response)),
                                httr::headers(response),
                                sep = ": ",
                                collapse = "; "))
}

if (verbose) cat("[.processResponse] Response status: ", httr::status_code(response),
                 " | type: ", contentType, "\n")

if (httr::status_code(response) == 405)
  warning("Response is HTTP 405 - Method Not Allowed: Please check if endpoint and binding match.")

httr::stop_for_status(response, "sending request to SOS")

if (contentType == "text/plain") {
  text <- httr::content(response)
  if (length(text) > 0 &
      regexpr("(<html>|<HTML>|<!DOCTYPE HTML|<!DOCTYPE html)", text) > 0) {
    stop(paste("[sos4R] ERROR: Got HTML response!:\n", text, "\n\n"))
  }
  
  xml <- xml2::read_xml(text)
  return(xml)
}
else if (contentType == "text/csv") {
  if (!requireNamespace("readr", quietly = TRUE))
    stop("package readr required to handle text/csv format, please install")
  
  tibble <- httr::content(x = response, encoding = sosDefaultCharacterEncoding)
  return(tibble)
}
else if (contentType == "application/xml" || contentType == "text/xml") {
  xml <- httr::content(x = response, encoding = sosDefaultCharacterEncoding)
  return(xml)
}
else if (contentType == "application/octet-stream") {
  content <- httr::content(response)
  if (is.raw((content))) {
    content <- rawToChar(content)
  }
  xml <- xml2::read_xml(content)
  if (!inherits(xml, c("xml_node", "xml_document", "xml_nodeset"))) {
    stop(paste("[sos4R]: ERROR: Received content as 'application/octet-stream' that could not be parsed to xml:\n",
               content, "\n\n"))
  }
  return(xml)
}

stop(paste0("Unsupported content type in response: '", contentType, "'."))
}