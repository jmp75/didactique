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

git clone git@github.com:ageron/handson-ml.git