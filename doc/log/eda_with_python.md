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

## ipyleaflet

Gridded spat-temp data sets data; trying [ipyleaflet](https://ipyleaflet.readthedocs.io/en/latest/installation.html)

```sh
pip install ipyleaflet
jupyter labextension install jupyter-leaflet
```

```text
WARNING in @jupyter-widgets/base
  Multiple versions of @jupyter-widgets/base found:
    1.2.5 ./~/@jupyter-widgets/base from ./~/@jupyter-widgets/base/css/index.css
    2.0.1 ./~/@jupyter-widgets/controls/~/@jupyter-widgets/base from ./~/@jupyter-widgets/controls/~/@jupyter-widgets/base/lib/widget.js

Check how you can resolve duplicate packages: 
https://github.com/darrenscerri/duplicate-package-checker-webpack-plugin#resolving-duplicate-packages-in-your-bundle
```

And sure enouth the typical jupyter-* experience:

```text
from ipywidgets import Button
Button()

Error displaying widget
```

Using the dev tools in the browser `semver range ^1.2.0 is not registered as a widget module`

trying `npm dedupe`:

```text
npm WARN saveError ENOENT: no such file or directory, open '/home/per202/src/csiro/package.json'
npm notice created a lockfile as package-lock.json. You should commit this file.
up to date in 0.432s
found 0 vulnerabilities
```

No idea???

Can I just turn it off and on again please?

```sh
jupyter-labextension install @jupyter-widgets/jupyterlab-manager
jupyter labextension install jupyter-leaflet
```

Try to not mix pip and conda. Stick to conda then.

```sh
conda list | grep ypi
pip uninstall beautifulsoup4       branca               ipyleaflet           ipywidgets           protobuf             siphon               soupsieve            traittypes           widgetsnbextension   
conda uninstall jupyter          jupyter_client   jupyter_console  jupyter_core     jupyterlab       jupyterlab_server

conda install -c conda-forge jupyterlab ipywidgets jupyter ipyleaflet
```
```sh
jupyter-labextension install @jupyter-widgets/jupyterlab-manager
jupyter-labextension install jupyter-leaflet
```
