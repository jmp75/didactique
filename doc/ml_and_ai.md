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

