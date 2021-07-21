
```sh
git clone

cd ~/src/github/leafmap
conda env create --name bm -f=./environment.yml 
conda activate bm
conda remove leafmap
# removes more than that...
conda install -c conda-forge mamba
mamba install -c conda-forge bqplot colour folium>=0.12.0 googledrivedownloader ipyevents ipyleaflet matplotlib mss numpy pandas pycrs pyshp>=2.1.3 python-box whitebox whiteboxgui here-map-widget-for-jupyter>=1.1.1

rm \=* # odd files with three version numbers.

python -m ipykernel install --user --name bm --display-name "Biomass"
```

`mamba install leafmap xarray_leaflet -c conda-forge`

pip install arcgis2geojson

pip install arcgis 


