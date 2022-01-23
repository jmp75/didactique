# Know-How

A list of things I infrequently use and need howto reminders 

## Unix cmds bloopers

Because I always get it wrong: `ln -s /path/to/dir newlink`, `tar cfv a.tar /path/to/dir`

## jupyter

Converting a jupyter notebook to a script. At least, on Debian sid which seems to have differnt CLI commands.

```sh
jupyter-nbconvert --to python RunModel.ipynb
```

TBC Generating an Rmarkdown file to a notebook ?

Vis R mailing list came across [Jupyter notebooks as Markdown documents, Julia, Python or R scripts](https://github.com/mwouts/jupytext). Cited in this thread, an interesting essay by Yihui Xie, [The First Notebook War](https://yihui.name/en/2018/09/notebook-war/)

## CI

Have set up CI using Travis and Appveyor for [Dynamic Interop](https://github.com/jmp75/dynamic-interop-dll)

Trying to set up CI on for R.NET:

* [Travis and C#/F# etc.](https://docs.travis-ci.com/user/languages/csharp/)

## Powershell

Diagnosing issues with PowerBuild:

```ps
Get-InstalledModule -Name "PowerBuild" | Uninstall-Module
```

## Python packaging for pypi

started [refcount](https://github.com/jmp75/pyrefcount) since there seems to be no equivalent out there. Looking in  a pretty good shape based on prior work so may as well go ahead and get a spot on pipy

reading [a blog by jetbrains](https://blog.jetbrains.com/pycharm/2017/05/how-to-publish-your-package-on-pypi/)

using the test pipy repo first. 

[CI using appveyor](https://github.com/AndrewAnnex/SpiceyPy/blob/master/appveyor.yml)

reading [pypa guidelines ](https://packaging.python.org/tutorials/packaging-projects/#packaging-your-project)

using conda for enb rather than pip though:

`conda install  wheel twine six pytest`

Looking all right on Windows but I may want to continue testing from Linux. Need to adjust unit tests also.

```sh
cd ~/src/github_jm/pyrefcount
python3 setup.py sdist bdist_wheel
```

`twine upload --repository-url https://test.pypi.org/legacy/ dist/*`:

```
Uploading distributions to https://test.pypi.org/legacy/
Enter your username: xxxyyy
Enter your password:
Uploading refcount-0.5.0-py2.py3-none-any.whl
100%|###########################################################################################################################################################################################################################| 19.2k/19.2k [00:02<00:00, 6.64kB/s]
ValueError: Unknown distribution format: 'refcount-0.5.0.tar'
```

Well why is twine leaving the twine file then?  `rm dist/refcount-0.5.0.tar`  then things look OK.

Uploads, however the description is looking in raw markdown. install pypandoc to try to convert to rst for building the wheel. `conda install pypandoc`

```sh
rm dist/*
python3 setup.py sdist bdist_wheel
rm dist/*.tar
twine upload --repository-url https://test.pypi.org/legacy/ dist/*
```

Once the html commented sections of the markdown file (`<!-- blahblah. -->`) are removed, the descrption is [rendered well](https://test.pypi.org/project/refcount/0.5.0.2).

### Test installation

```sh
my_env_name=testpypirefcount
conda create --name ${my_env_name} python=3.6
conda activate ${my_env_name}
python3 -m pip install --index-url https://test.pypi.org/simple/ refcount
```

complains not finding a suitable cffi.  `pip search cffi | less` shows a suitable version of cffi. Trying `pip search --i https://test.pypi.org/simple/ cffi | less` but `405 Client Error: Method Not Allowed for url: https://test.pypi.org/simple/`

Interestingly and not obviously `pip search -i https://test.pypi.org/pypi cffi | less` works and indeed no cffi pkg there. 

OK, pragmatically: `conda install cffi`
`python3 -m pip install --index-url https://test.pypi.org/simple/ refcount` Opa! installs. Can load objects from modules.

Time to claim the spot:

```sh
rm dist/*
python3 setup.py sdist bdist_wheel
rm dist/*.tar
twine upload dist/*
```

## Batch removing spaces from files

Something like:

```sh
find . -type f -name "* *.csv" -exec bash -c 'mv "$0" "${0// /_}"' {} \;
```

## Visual Studio debug visualizer

Trying to have a debug help on that front for nested hupercube parameterizers. These are essentially forms of dictionaries, really, so would like a flattened, dict like vuew of them for debugging. 

```c++
		class HyperCubeParameterizer : public Parameterizer, public KeyValueConfiguration
        {
            // for instance:
			virtual double GetMinValue(const string &paramName) const = 0;
			virtual double GetMaxValue(const string &paramName) const = 0;
        }
```

[Create custom views of data in the Visual Studio debugger (C#, Visual Basic, C++)](https://docs.microsoft.com/en-us/visualstudio/debugger/viewing-data-in-the-debugger?view=vs-2017)

"C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\Common7\Packages\Debugger\Visualizers"; tried to infer from stl.natvis. Also already had authored some for uchronia time series

## Popping sounds on some keystroke operations

At best, I tolerate some desktop sound effects. I mostly loathe them. Fresh OS install, first things, turn off all sound effects. Then, there are 'terminal bells' on by default in obscure terminal settings. Then, you upgrade your Debian from Bullseye to Woodworm, and suddenly a double popping on some keystrokes assaults me. No settings left to turn off in sight. A desperate search for the magic stackoverflow post that will wash away the powerful irritant. I'd swap that back for that brush with a stinging tree I had. Adding insult to injury, the desperate web page full text search triggers further auditory distress. Nothing but dead ends I had already met.

Don't get me started on popcorn munchers in cinemas.

I had that issue with the linux terminal some months back. Solved by some Terminal Bell settings.

Now it is back in firefox text search, file explorer.

as root:

`rmmod pcspkr ; echo "blacklist pcspkr" >>/etc/modprobe.d/blacklist.conf`

Thank you so much [Edheldil](https://unix.stackexchange.com/a/453018/497165).

## Errors were encountered while processing nvidia-kernel-dkms

upgraded to Woodworm 

now every apt install triggers a failed dpkg processing. 
Note that the cuda repo was for debian 10? but working with the latest deb testing distro. Maybe now not enough.

/var/cuda-repo-debian10-11-4-local/nvidia-kernel-common_20151021+11_amd64.deb

```text
dpkg: error processing package nvidia-kernel-dkms (--configure):
 installed nvidia-kernel-dkms package post-installation script subprocess returned error exit status 10
dpkg: dependency problems prevent configuration of nvidia-driver:
 nvidia-driver depends on nvidia-kernel-dkms (= 470.57.02-2) | nvidia-kernel-470.57.02; however:
  Package nvidia-kernel-dkms is not configured yet.
  Package nvidia-kernel-470.57.02 is not installed.
  Package nvidia-kernel-dkms which provides nvidia-kernel-470.57.02 is not configured yet.
```

try steps in [this post](https://forums.linuxmint.com/viewtopic.php?t=281922 )

`sudo dkms status`:  nvidia-current, 470.57.02: added

`apt purge nvidia-*`

It certainly removes a lot of stuff.

Now, where is the repro doc for nvidia/cuda install I got training for fastai? or did I rely on the conda environment to install cuda stuff?

`apt autoremove`

```
dpkg: warning: while removing libnvjpeg-11-4, directory '/usr/local/cuda-11.4/targets/x86_64-linux/lib' not empty so not removed
```

But at the end it is, so `rm -rf  /usr/local/cuda-11.4`

Looking into /home/per202/src/didactique/doc/debian_install.md for the graphic card / ml section

I notice that /etc/apt/sources.list has the contrib section but on bullseye; seems redundant. 

Now on to reinstall.

[https://wiki.debian.org/NvidiaGraphicsDrivers](https://wiki.debian.org/NvidiaGraphicsDrivers) is looking nicely up to date thank you very much.

"Particularly if you're on Debian Testing or Debian Unstable, the driver might not support your kernel yet."


`apt update` and `apt upgrade` as a preparation. A few services needs restarting. Maybe better to reboot just in case.

Nope, still not able to configure nvidia-drivers

in /var/lib/dkms/nvidia-current/470.57.02/build/make.log:

```text
In file included from /var/lib/dkms/nvidia-current/470.57.02/build/common/inc/nv-linux.h:25,
                 from /var/lib/dkms/nvidia-current/470.57.02/build/nvidia/nv-mmap.c:14:
/var/lib/dkms/nvidia-current/470.57.02/build/common/inc/nv-time.h: In function ‘nv_sleep_ms’:
/var/lib/dkms/nvidia-current/470.57.02/build/common/inc/nv-time.h:217:18: error: ‘struct task_struct’ has no member named ‘state’; did you mean ‘__state’?
  217 |         current->state = TASK_INTERRUPTIBLE;
      |                  ^~~~~
      |                  __state
```

Yikes, [seems I need to patch](https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=994860#25). May have been fixed already but only on "unstable" not yet in testing?

/usr/src/nvidia-current-470.57.02/common/inc/nv-time.h

```text
Index: nvidia-current-470.57.02/common/inc/nv-time.h
===================================================================
--- nvidia-current-470.57.02.orig/common/inc/nv-time.h
+++ nvidia-current-470.57.02/common/inc/nv-time.h
@@ -214,7 +214,7 @@ static inline NV_STATUS nv_sleep_ms(unsi
         // the requested timeout has expired, loop until less
         // than a jiffie of the desired delay remains.
         //
-        current->state = TASK_INTERRUPTIBLE;
+        current->__state = TASK_INTERRUPTIBLE;
         do
         {
             schedule_timeout(jiffies);
Index: nvidia-current-470.57.02/nvidia-drm/nvidia-drm-drv.c
===================================================================
--- nvidia-current-470.57.02.orig/nvidia-drm/nvidia-drm-drv.c
+++ nvidia-current-470.57.02/nvidia-drm/nvidia-drm-drv.c
@@ -922,7 +922,7 @@ static void nv_drm_register_drm_device(c
     dev->dev_private = nv_dev;
     nv_dev->dev = dev;
     if (device->bus == &pci_bus_type) {
-        dev->pdev = to_pci_dev(device);
+        dev->dev = device;
     }

     /* Register DRM device to DRM sub-system */
```

Seems to build fine then.

`apt install nvidia-cuda-dev nvidia-cuda-toolkit` , _caution_ expect ~1.5 GB

Note [cudnn](https://developer.nvidia.com/cudnn) perhaps necessary in the future, but for now the way I installed fastai via conda it installed cudnn in the conda env and this seems to work fine.

## Linux - fan turns on and off for no visible workload

upgraded to latest deb testing. Fan turns on and off all the time now.

https://phoenixnap.com/kb/linux-cpu-temp

`apt install hddtemp lm-sensors i7z`

`apt install psensor`

Glances is mentioned in https://www.tecmint.com/monitor-cpu-and-gpu-temperature-in-ubuntu/. Not in apt repos though. Not sure. Looks neat.

`apt install hardinfo`

I notice the cpu temperature thresholds are 100 degrees

Could I change that?

`apt install tlp tlp-rdw`

[TLP doc](https://linrunner.de/tlp/settings/introduction.html)

Seems inactive as a sysctl service though.

`apt install thermald`


https://wiki.ubuntu.com/Kernel/PowerManagement/ThermalIssues

sort of OK: https://newbedev.com/stop-cpu-from-overheating

Good write up: https://www.askwoody.com/forums/topic/intel-thermald-wow/


## SSH keys and bitbucket

TIL

I was trying to add an ssh pub key to my bitbucket account, at least one of them if there are several. Must be. Tells me that I cannot add because this public key is already in use. No idea which account I set this up under though. I thought only my work email address was in use. I cannot locate a previous account, who knows. TIME related stuff??? Lost the account id if any.

Anyway. Needed to create a new ssh key to work around that. Git fetch seemed to work then after forking julien lerat's repo, but creating a new branch and pushing ot my fork failed.

Turned out I needed to add to  `~/.ssh/config`

```text
Host bitbucket.org
 IdentityFile ~/.ssh/id_rsa_bitbucket_org
```
