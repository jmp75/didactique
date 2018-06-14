Notes for self during the handover of an [EDA of Lithology](https://github.com/jmp75/Exploratory-Lithology-Analysis) 


executing `tile = cimgt.OSM()` got a `ModuleNotFoundError: No module named 'pyepsg'` even if main package cartopy is installed. Doing `sudo apt-get install python3-pyepsg` solves.

```bash
aptitude search mayavi
sudo apt-get install mayavi2
pip3 install --user mayavi
```

ModuleNotFoundError: No module named 'vtk'

```sh
aptitude search vtk
sudo apt-get install python-vtk6 # was already??
```

```sh
pip3 install --user vtk
pip3 install --user mayavi
```

```
UnicodeEncodeError: 'ascii' codec can't encode character '\xe9' in position 541: ordinal not in range(128)
```