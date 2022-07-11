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


**jupytext sync setting** Because I forget every single time:

`jupytext --set-formats ipynb,py:percent dashboard_prototype.ipynb`


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

```text
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
