# Know-How

A list of things I infrequently use and need howto reminders 

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