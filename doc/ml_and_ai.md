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


Trying to follow instal instructions from [this post](https://unix.stackexchange.com/a/241127) but:

```
Installing the NVIDIA display driver...
The driver installation has failed due to an unknown error. Please consult the driver installation log located at /var/log/nvidia-installer.log.
```

So instead looking in the same thread, which seems to have had the same issue: https://unix.stackexchange.com/a/478951


```
The MiniSSDP daemon is being installed (perhaps as a dependency for UPnP support) but will not function correctly until it is configured.
MiniSSDP is a daemon used by MiniUPnPc to speed up device discovery. For security reasons, no out-of-box default configuration can be provided, so it requires manual configuration.
Alternatively you can simply override the recommendation and remove MiniSSDP, or leave it unconfigured - it won't work, but MiniUPnPc (and UPnP applications) will still function properly despite some performance loss.
```

After upgrating to testing (buster, actually) I do get NVIDIA drivers that appear mych closer to the version that the cuda installer would install. Good. 

```/usr/local/cuda-10.0/lib64
Err/usr/local/cuda-10.0/lib64r: 8.3.0. Use --override to override this check.
```/usr/local/cuda-10.0/lib64

Sur/usr/local/cuda-10.0/lib640.0.130_410.48_linux.run --override`

```/usr/local/cuda-10.0/lib64
===/usr/local/cuda-10.0/lib64
= Summary =
===========

Driver:   Not Selected
Toolkit:  Installed in /usr/local/cuda-10.0
Samples:  Not Selected

Please make sure that
 -   PATH includes /usr/local/cuda-10.0/bin
 -   LD_LIBRARY_PATH includes /usr/local/cuda-10.0/lib64, or, add /usr/local/cuda-10.0/lib64 to /etc/ld.so.conf and run ldconfig as root

To uninstall the CUDA Toolkit, run the uninstall script in /usr/local/cuda-10.0/bin

Please see CUDA_Installation_Guide_Linux.pdf in /usr/local/cuda-10.0/doc/pdf for detailed information on setting up CUDA.

***WARNING: Incomplete installation! This installation did not install the CUDA Driver. A driver of version at least 384.00 is required for CUDA 10.0 functionality to work.
To install the driver using this installer, run the following command, replacing <CudaInstaller> with the name of this run file:
    sudo <CudaInstaller>.run -silent -driver
```

Creating  /etc/ld.so.conf.d/cuda.conf  and note that ldconfig was not avail from root but `sudo which ldconfig` works...

Going back to https://www.tensorflow.org/install/gpu, wants to do an `export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-10.0/extras/CUPTI/lib64` so instead appending cuda.conf...


Need to install cuDNN. Need to log in using google account, Grumpf.  `Download cuDNN v7.5.1 (April 22, 2019), for CUDA 10.0`  cuDNN Library for Linux


tar zxpvf cudnn-10.0-linux-x64-v7.5.1.10.tgz 
sudo cp -i cuda/include/cudnn.h /usr/local/cuda/include/
sudo cp -i -P cuda/lib64/libcudnn* /usr/local/cuda/lib64/https://stackoverflow.com/a/42405657

sudo ldconfig.

Update my .profile with:

```sh
# set PATH so it includes cuda bin if it exists
if [ -d "/usr/local/cuda/bin" ] ; then
    PATH="$PATH:/usr/local/cuda/bin"
fi
```

one off `source ~/.profile`

```sh
source ~/anaconda3/bin/activate
conda activate ML
conda list tensor
pip uninstall tensorboard tensorflow-estimator
```

`pip install tensorflow-gpu==2.0.0-alpha0`

handson-ml 2.0 notebooks seem to run OK. However `tf.config.experimental_list_devices()` returns

```text
['/job:localhost/replica:0/task:0/device:CPU:0',https://stackoverflow.com/a/42405657
'/job:localhost/replica:0/task:0/device:XLA_CPU:https://stackoverflow.com/a/42405657
```

[install-tensorflow-with-gpu-support-on-debian-s](https://stackoverflow.com/a/42405657.com/@tristan.sch/install-tensorflow-with-gpu-support-on-debian-sid-15e68348387f) seems I need to start the python interp via optirun, but how do I do that from within jupyter-lab??

[SO post...](https://stackoverflow.com/a/48781063)

command `optirun python` gives me more information thankfully:

```text
>>> tf.config.experimental_list_devices()
2019-04-29 16:34:43.753539: I tensorflow/core/platform/cpu_feature_guard.cc:142] Your CPU supports instructions that this TensorFlow binary was not compiled to use: AVX2 FMA
2019-04-29 16:34:43.798154: I tensorflow/stream_executor/platform/default/dso_loader.cc:53] Could not dlopen library 'libcuda.so.1'; dlerror: libcuda.so.1: cannot open shared object file: No such file or directory; LD_LIRARY_PATH: /usr/lib/x86_64-linux-gnu/primus:/usr/lib/i386-linhttps://stackoverflow.com/a/42405657ux-gnu/primus:/usr/lib/primus:/usr/lib32/primus:/usr/lib/x86_64-linux-gnu/nvidia:/usr/lib/i386-linux-gnu/nvidia:/usr/lib/nvidia
2019-04-29 16:34:43.798190: E tensorflow/stream_executor/cuda/cudahttps://stackoverflow.com/a/42405657_driver.cc:318] failed call to cuInit: UNKNOWN ERROR (303)
2019-04-29 16:34:43.798216: I tensorflow/stream_executor/cuda/cudahttps://stackoverflow.com/a/42405657_diagnostics.cc:166] retrieving CUDA diagnostic information for host: gamma-bm
2019-04-29 16:34:43.798226: I tensorflow/stream_executor/cuda/cudahttps://stackoverflow.com/a/42405657_diagnostics.cc:173] hostname: gamma-bm
2019-04-29 16:34:43.798271: I tensorflow/stream_executor/cuda/cudahttps://stackoverflow.com/a/42405657_diagnostics.cc:197] libcuda reported version is: Not found: was unable to find libcuda.so DSO loaded into this program
2019-04-29 16:34:43.798307: I tensorflow/stream_executor/cuda/cudahttps://stackoverflow.com/a/42405657_diagnostics.cc:201] kernel reported version is: 410.104.0
2019-04-29 16:34:43.818096: I tensorflow/core/platform/profile_utihttps://stackoverflow.com/a/42405657ls/cpu_utils.cc:94] CPU Frequency: 2904000000 Hz
2019-04-29 16:34:43.819040: I tensorflow/compiler/xla/service/service.cc:162] XLA service 0x5590d98e3570 executing computations on platform Host. Devices:
2019-04-29 16:34:43.819067: I tensorflow/compiler/xla/service/service.cc:169]   StreamExecutor device (0): <undefined>, <undefined>
['/job:localhost/replica:0/task:0/device:CPU:0', '/job:localhost/replica:0/task:0/device:XLA_CPU:0']
```

https://stackoverflow.com/a/42405657  and I see that while the nvidia cuda drivers should have been installed previously, manually, some link may have not been done proper;y. 



`more ~/.local/share/jupyter/kernels/ela/kernel.json `

```json
{
 "argv": [
    "/usr/bin/optirun",
    "/home/xxxxxx/anaconda3/envs/ELA/bin/python",
"-m",
  "ipykernel_launcher",
  "-f",
  "{connection_file}"
 ],
 "display_name": "Py3 ELA",
 "language": "python"
}
```