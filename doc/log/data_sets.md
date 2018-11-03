# All things data set related, exploratory mode

## Lithology data sets

Using ecocloud Explorer, noticed that a National Groundwater Information System was [referenced in](https://data.gov.au/dataset/0ddc1f79-6ed3-4f4f-9195-52cf3eb59127) data.gov.au. Despite its possible lock-in dependence on ArcGIS, giving it a go at downloading to explore. [Posted a comment that I could not unzip the resulting file](http://disq.us/p/1wwja48). Disappointed.

Could open the subset for NSW office of water; however the ESRI dependency is an issue of course. 

I think I will have to request the national dataset via email... [see](http://www.bom.gov.au/water/groundwater/ngis/data.shtml)

Reboot to windows and install Arc things 10.1 thsn archydro. [this tutorial](http://ahgw.aquaveo.com/Boreholes.pdf). Seems I need [Arc Hydro Groundwater Tools](http://resources.arcgis.com/en/communities/hydro/01vn00000011000000.htm). Which seems to default to AHGW 3.4 for ArcGIS 10.5, so be careful to check all available downloads. 


Using File -- Add Data... and the odd open dialog mode, figured out I could open one of the "blah.gdb" folders. Selecting most of the stuff to add to the layers. The lithology logs seem to be data tables. 
Trying in the toolbox AHGT "BoreholeLog to Points". Can select the NGIS_BoreholeLog tabke. 

Fails with a "This tool requires a Subsurface Analyst License". FT.

Trying again, seems to work now.
Trying to export one of the tables i.e. lithology logs but as text this leads to a 600mb txt file.
Joining NGIS_bore layer with the lithology logs on the HydroCode but this is unclear what happened. On the NGIS_LithologyLogs in the property panel, tab "joins and relates" has an entry NGIS_BOre now in the "joins" side. The 'fields' tab now has columns lat and lon, and northing/easting.

