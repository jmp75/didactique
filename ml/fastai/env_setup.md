# Setup notes for fast.ai

Notes at 2022-04 for fast.ai course; setting up a fastai kernel and jupyterlab on my laptop as a compulsive need, not necessarily rational. Follow fast.ai course recommendations by default.

This describe a recipe for Debian 11.x (Bullseye). Since I just reinstalled from scratch my Linux box partition "downgrading" Debian to stable (from Bookworm to Bullseye), I may as well document.

The end point of this document is a working fast.ai conda environment, GPU enabled, run from jupyter-lab interface. Using conda packages is mostly given a preference over using pypi.

Hardware assumption is that you have an nvidia card and an Optimus laptop; you may be able to adapt this to another context.

## Resources

* [Fast.ai Course](https://course.fast.ai/)
* [Fast.ai Docs](https://docs.fast.ai/)

See also [NVIDIA Optimus on Debian wiki](https://wiki.debian.org/NVIDIA%20Optimus)

## Steps

I have a Dell laptop with a so-called "optimus" architecture: Intel graphics plus an NVIDIA card I pretty much got for ML.

**Note**: Debian 11.x Bullseye still requires a more explicit use of the `optirun` (and/or `primusrun`?) command(s) to access the NVIDIA card. Debian Bookworm (currently 'testing') is a bit more seamless with the Optimus architecture, but as Bookworm comes with some multi-screen and kernel frustrations lately for me, I go with Bullseye.

Make sure you enabled the contrib and non-free channels for apt. Not sure this is still required these days, but probably, with nvidia.

then `sudo apt install nvidia-detect nvidia-smi bumblebee-nvidia nvidia-driver`

as root run `/usr/sbin/usermod -G bumblebee xyzxyz` to add yourself user xyzxyz to the bumblebee group

`optirun nvidia-detect` should then work (may need a reboot to take group updates?)

use `groups yourusername` to check you are a member of the bumblebee group

`optirun nvidia-smi` should return:

```text
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 460.91.03    Driver Version: 460.91.03    CUDA Version: 11.2     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  Quadro RTX 4000     Off  | 00000000:01:00.0 Off |                  N/A |
| N/A   41C    P0    33W /  N/A |     10MiB /  7982MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
```

## conda environment with fastai

Check the [latest miniconda](https://docs.conda.io/en/latest/miniconda.html)

```bash
cd $HOME
# adjust the version of miniconda below to current latest, which may not be py39_4.11.0
wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.11.0-Linux-x86_64.sh -O ~/miniconda.sh
bash ~/miniconda.sh -b -p $HOME/miniconda
```

```bash
. $HOME/miniconda/etc/profile.d/conda.sh
which conda
conda env list
```

There are ways to automate the activation conda by default in your shell at startup; I'd recommend *NOT* doing it (can lead to issues in OS level library dependency compatibilites)

I really recommend installing and using `mamba` the drop-in replacement for `conda`. It is clearly better at most things conda does. Install it in the base environment rather than the new environment(s) you'll create later.

```sh
conda install mamba -c conda-forge
```

## fastai

**CAUTION**: expect 3GB download and a long install time

```sh
myenv="fai_pt"
```

I used to use `main` as a conda channel a few months back for fastai conda env, but now have issue with missing dependencies for nbdev ghapi. Using `conda-forge` instead seems to prevent this issue.

```sh
# cn="main"
cn="conda-forge"
```

Note as of Apr 2022: starting from python 3.10 leeds to a mess for `torchvision` versions. Stick to 3.9.

```sh
mamba create -n $myenv -c $cn python=3.9
mamba install -n $myenv -c $cn matplotlib pandas requests pyyaml pillow scikit-learn scipy spacy
```

At this point a bit of caution. `mamba install -n $myenv pytorch -c pytorch -c nvidia` is typically what you would infer from the official fast.ai install instructions. I got a perplexing

```text
  - nothing provides cudatoolkit >=8.0,<8.1 needed by pytorch-1.0.1-py2.7_cuda8.0.61_cudnn7.1.2_2
```

Seems you have to force a version and add the fallback channel (conda forge if what you used). Caution that it is a ~2GB download.

```sh
mamba install -n $myenv pytorch=1.11 -c pytorch -c nvidia -c $cn
```

```sh
mamba install -n $myenv torchvision torchaudio -c pytorch -c nvidia -c $cn
```

Install from conda channel the substantial dependencies required by `nbdev` (if you'll install it), which we will install from pip. Installing too main dependencies from pip on top of conda can cause grief in my experience.

I also personally prefer to install some of the fastai ecosystem from source and in develop mode. Personal, not compulsory.

```sh
# nbdev requirements in a file extracted from https://github.com/fastai/nbdev/blob/master/settings.ini
mamba install -n $myenv -c pytorch -c $cn --file nbdev.txt
```

Assuming you have git installed, and ssh keys set up (alternative your way)

```sh
cd $HOME/src
git clone git@github.com:fastai/fastdownload.git
git clone git@github.com:fastai/fastcore.git
git clone git@github.com:fastai/fastrelease.git
git clone git@github.com:fastai/fastai.git
```

```sh
conda activate $myenv
cd ~/src/fastcore
python setup.py develop

cd ~/src/fastdownload
python setup.py develop

cd ~/src/fastrelease
python setup.py develop
```

Installing nbdev but not sure this is really required. Probably only for fastai devs. TODO unpack https://github.com/fastai/fastai/blob/master/settings.ini

```sh
# requires fastcore>=1.3.21 ghapi fastrelease that should already have been via conda 
pip install nbdev
```

```sh
cd ~/src/fastai
python setup.py develop
```

## fastbook

```sh
conda deactivate # get back to base env. Mamba may be accessible from myenv, but I am wary of using the -n arg from the kernel environment
# fastbook requirements: sentencepiece
mamba install -n $myenv -c $cn sentencepiece
# or
# pip install sentencepiece
```

```sh
# Note that there is a graphviz packge on conda-forge, but module is still unavailable (Huh??? sus.)
conda activate $myenv
pip install graphviz

pip install --no-deps fastbook
# Note to self I never remember when kernel specs are...
# /home/xyzxyz/.local/share/jupyter/kernels/fai_pt/kernel.json
python -m ipykernel install --user --name $myenv --display-name "fastai_pt"
```

At this point, illustration of the need to use optirun to access the GPU:

`python`:

```text
Python 3.9.12 | packaged by conda-forge | (main, Mar 24 2022, 23:22:55) 
[GCC 10.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import torch
>>> torch.cuda.is_available()
True
```

whereas `optirun python`:

```text
Python 3.9.12 | packaged by conda-forge | (main, Mar 24 2022, 23:22:55) 
[GCC 10.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import torch
>>> torch.cuda.is_available()
True
```

So you need to modify your kernel specification file /home/xyzxyz/.local/share/jupyter/kernels/fai_pt/kernel.json with something like:

```json
{
 "argv": [
  "optirun",
  "/home/xyzxyz/miniconda/envs/fai_pt/bin/python",
  "-m",
  "ipykernel_launcher",
  "-f",
  "{connection_file}"
 ],
 "display_name": "fastai_pt",
 "language": "python",
 "metadata": {
  "debugger": true
 }
}
```

Finally, jupyter-lab (unless you have another conda env with it already installed):

```sh
# jupyterlab
conda deactivate # get back to base env. 
mamba install -n $myenv -c $cn jupyterlab 
```

A word of caution: I noticed once after updating kernel.json and restarting the kernel of "01_intro.ipynb" that `torch.cude.is_available()`  and `torch.cude.is_initialized()` were both true, but visibly `learn.fine_tune(1)` still ran on the CPU. After one or two restarts of the notebook kernel, fastai finally ran reliably on the GPU as expected. Not sure what was going on transiently.

To definitely check the GPU is used, the terminal command `nvtop` is nifty, and `optirun nvtop` will ascertain the status (as well as providing insights)

## Fastai coursework fastbook

```sh
mkdir -p ${HOME}/Documents/mlai/fastai/
cd ${HOME}/Documents/mlai/fastai/
git clone --depth 1 -b master git@github.com:fastai/fastbook.git
```

```sh
conda activate $myenv
```

Personal preference only: comment out the shell command that installs the fastbook package from pip. from e.g. visual studio code replace all `! [ -e /content ] && pip` with `# ! [ -e /content ] && pip`

Seems required: Bulk replace the name of the kernels in the notebooks .ipynb files from the default `"name": "python3"`  to e.g. `"name": "fai_pt"` and display name as well. This is the drawback to naming conda envs descriptively. Or, change the kernel from the jupyterlab manually for each notebook; tedious but feasible.

`"display_name": "Python 3 (ipykernel)"` with `"display_name": "fastai"`

```sh
cd ${HOME}/Documents/mlai/fastai/
jupyter-lab .
```
