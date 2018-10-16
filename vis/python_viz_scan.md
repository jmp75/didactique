# Exploring vis. toolets in the Python ecosystem


## ipyvolume

```sh
source ~/anaconda3/bin/activate
conda activate ELA
conda list | less

cd ~/src/github/
git clone git@github.com:maartenbreddels/ipyvolume.git
cd ipyvolume
pip install -e .
```

Since I am using jupyterlab I am first trying ot install that:

```sh
jupyter-labextension install @jupyter-widgets/jupyterlab-manager
cd ~/src/github/
jupyter-labextension install ipyvolume
jupyter-labextension install jupyter-threejs
```

but:

```txt
> /usr/bin/npm pack /home/per202/src/github/ipyvolume
npm ERR! code ENOLOCAL
npm ERR! Could not install from "../../home/per202/src/github/ipyvolume" as it does not contain a package.json file.
```

This may be because one needs to be in a folder without an ipyvolume subfolder. The following seems to have worked:

```sh
cd
jupyter-labextension install ipyvolume
jupyter-labextension install jupyter-threejs
```

```sh
cd ~/src/github/ipyvolume
jupyter-nbextension install --py --symlink --sys-prefix ipyvolume
jupyter-nbextension enable --py --sys-prefix ipyvolume

# For all cases make sure ipywidgets is enabled if you use Jupyter notebook version < 5.3 (using --user instead of --sys-prefix if doing a local install):

jupyter-nbextension enable --py --sys-prefix widgetsnbextension
jupyter-nbextension enable --py --sys-prefix pythreejs
jupyter-nbextension enable --py --sys-prefix ipywebrtc
jupyter-nbextension enable --py --sys-prefix ipyvolume
```

one of the notebooks imports vaex, which depends on ipyvolume.

```sh
cd ~/src/github/
git clone git@github.com:maartenbreddels/vaex.git
cd vaex
pip install -e .
```

`AttributeError: module 'pip' has no attribute 'main'`