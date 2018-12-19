# Know-How

A list of things I infrequently use and need howto reminders 

## Unix cmds bloopers

Because I always get it wrong: `ln -s /path/to/dir newlink`, `tar cfv a.tar /path/to/dir`

## jupyter

Converting a jupyter notebook to a script. At least, on Debian sid which seems to have differnt CLi commands.

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

reading pypa guidelines

using conda for enb rather than pip though:

`conda install  wheel twine six pytest`

Looking all right on Windows but I may want to continue testing from Linux. Need to adjust unit tests also.
