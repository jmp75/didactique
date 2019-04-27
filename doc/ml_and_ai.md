# AI/ML things

## fastai

Investigating [fastai](http://docs.fast.ai) that builds on pytorch, after picking up a news item at The Register.

`conda search "cuda*" -c pytorch` returns cuda92 as the max. There is CUDA toolkit 10 at nvidia but only just released so [sticking with Cuda 9.2](https://developer.nvidia.com/cuda-92-download-archive). Choosing the network installer (otherwise 1.5 GB and not sure how much of it is really needed)

```cmd
py3env
set env_name=AI
conda create --name %env_name%
conda activate %env_name%
conda install --name %env_name% -c pytorch -c fastai fastai pytorch-nightly cuda92
```

Complains. Looking at [pytorch/pytorch-nightly](https://anaconda.org/pytorch/pytorch-nightly) this appears not available for windows.

## tensorflow

Hands on ML book

```cmd
py3env
set env_name=AI
conda activate %env_name%
REM pip3 install --upgrade tensorflow
conda search tensorflow-gpu
conda install --name %env_name% tensorflow-gpu
```

```sh
git clone git@github.com:ageron/handson-ml.git
```

## Hands-On Machine Learning with Scikit-Learn and TensorFlow

```sh
source ~/anaconda3/bin/activate
env_name=ML
conda create --name $env_name python=3.6
conda activate $env_name
conda install --name $env_name tensorflow  # Note that I purposely try not to tap into conda-forge and ommit `-c conda-forge` option
conda install --name $env_name scikit-learn
conda install --name $env_name ipykernel

python -m ipykernel install --user --name $env_name --display-name "Python3 (ML)"

conda install -n $env_name jupyterlab jupyterlab_launcher
conda install -n $env_name matplotlib

## jupyter-labextension  install @jupyter-widgets/jupyterlab-manager

cd ~/src/github/handson-ml
jupyter-lab
```

## Practical Text Classification With Python and Keras

Found [this tutorial](https://realpython.com/python-keras-text-classification/) from Francois Chollet's tweet. Decided to give a spin to [google colaboratory](https://colab.research.google.com). Note that I logged in with an @csiro.au account - not sure this was the same as my .it one. Oops credentials.

## Tensorflow explorations

### 2018-12

Tensorflow 2.0 is on the roadmap, but there does not seem to be a way to install it as such (seems some options in 1.12 generate code for 2.0 API however). Still, better stick to [tutorials](https://www.tensorflow.org/tutorials)

## LSTM for water yield modelling

### 2019-01

Exploring [https://github.com/kratzert/AGU2018](https://github.com/kratzert/AGU2018)

```sh
cd ~/src/github/AGU2018-master
source ~/anaconda3/bin/activate
my_env_name=LSTM
conda create --name ${my_env_name} python=3.6
conda activate  ${my_env_name}

conda install pytorch pandas numpy scipy matplotlib scikit-learn numba tqdm
```

`pip install tensorboardX` 

what is `tydm` ? cannot find anything relevant.  That was actually `tqdm`

Loading data: seems it may have changed. looking for _str:'/home/per202/data/basin_timeseries_v1p2_metForcing_obsFlow/basin_mean_forcing/daymet' but this is '/home/per202/data/basin_timeseries_v1p2_metForcing_obsFlow/basin_dataset_public/basin_mean_forcing/daymet/' and this may be superseeded by  home/per202/data/basin_timeseries_v1p2_metForcing_obsFlow/basin_dataset_public_v1p2/basin_mean_forcing/daymet/

`rm -rf /home/per202/src/github/AGU2018-master/code/results` before rerunning.

Unexpectly (tersorboardX should have been diisabled)

```
Exception has occurred: AttributeError
'PosixPath' object has no attribute 'split'
```
Ah! python...

### Handsonnl 2019-04-27

Trying tensorflow2 on Linux. Following trying gpu with instructions https://www.tensorflow.org/install/gpu . Only instructions for Ubuntu - not sure how this will feed into Debian. I also recall I had a look earlier (where did you write notes then???) and looked at https://wiki.debian.org/NvidiaGraphicsDrivers and https://wiki.debian.org/Bumblebee given I seem to have a laptop with Intel + NVIDIA graphics. 

`lspci -nn | egrep -i "3d|display|vga"` reports:

```text
0:02.0 VGA compatible controller [0300]: Intel Corporation Device [8086:591b] (rev 04)
00:16.3 Serial controller [0700]: Intel Corporation Sunrise Point-H KT Redirection [8086:a13d] (rev 31)
01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:13b6] (rev ff)
```

Seems I had managed to get bumblebee working; at least I can run the cogs example with `optirun`

https://wiki.debian.org/NvidiaGraphicsDrivers/Optimus

https://towardsdatascience.com/how-to-use-tensorflow-on-the-gpu-of-your-laptop-with-ubuntu-18-04-554e1d5ea189

`sudo apt install nvidia-smi`

`optirun nvidia-smi` returns, err, something. Not directly `nvidia-smi`

Installing CUDA, now very very important to get version 10.0 exactly for tensorflow 2.0. Choosing Ubuntu 18.04 and hoping gfor the best...

* `sudo dpkg -i cuda-repo-ubuntu1804-10-0-local-10.0.130-410.48_1.0-1_amd64.deb`
* `sudo apt-key add /var/cuda-repo-<version>/7fa2af80.pub`
* `sudo apt-get update`
* `sudo apt-get install cuda`


```text
The following packages have unmet dependencies:
 cuda : Depends: cuda-10-0 (>= 10.0.130) but it is not going to be installed
E: Unable to correct problems, you have held broken packages.
```

OK, uninstall.

https://tracker.debian.org/pkg/nvidia-cuda-toolkit points me to version 10.0 is in non-free of https://packages.debian.org/source/experimental/nvidia-cuda-toolkit . Experimental, he? Nope.

https://gist.github.com/ingo-m/60a21120f3a9e4d7dd1a36307f3a8cce  maybe but for one version down...



* `sudo dpkg -i cuda-repo-ubuntu1604_10.0.130-1_amd64.deb`
* `sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub`
* `sudo apt-get update`
* `sudo apt-get install cuda`

Nope, still not..
