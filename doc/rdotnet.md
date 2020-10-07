# R.NET

## 2019-04 testing RProvider installation.

```bat
cd c:\src\github\RProvider
build.cmd
```


```text
BuildTests          Failure
Total:              00:00:13.4586189
---------------------------------------------------------------------
Status:             Failure
---------------------------------------------------------------------
---------------------------------------------------------------------
  1) Building c:\src\github\RProvider\RProvider.Tests.sln failed with exitcode 1.
  2) : error FS3053(0,0): The type provider constructor has thrown an exception: Initialization of R.NET failed
---------------------------------------------------------------
```

mOdify to contactnate the error messge of the innter exception, though not super useful in this case:

```text
parse error FS3053: error : The type provider constructor has thrown an exception: Initialization of R.NET failed: Object reference not set to an instance of an object.
```

Very likely due to default detection of R 3.5.x. While annoying that this is this error message null ref, let us move on to the latest R.NET rather than diagnose soon to be superseded versions. 

Trying to compile a prerelease R.net.fsharp nuget. Using VS2017 for R.NET but:

```text
Building the projects in this solution one at a time. To enable parallel build, please add the "/m" switch.
C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\MSBuild\Sdks\Microsoft.NET.Sdk\build\Microsoft.NET.TargetFrameworkInference.targets(126,5): error : The current .NET S DK does not support targeting .NET Standard 2.0.  Either target .NET Standard 1.6 or lower, or use a version of the .NET SDK that supports .NET Standard 2.0. [c:\src\github_jm\rdotnet \R.NET\RDotNet.csproj]
```

My guess is that installing VS2019 recently brought a newer version of dotnet, [2.1.602, which does not work with vs2017](https://github.com/dotnet/sdk/issues/3124)


Changing the dependencies change R.NET.Community to R.NET - change pin pkg dep to 1.8.0-alpha;  moving to pin to `FSharp.Core 4.5.2`, because previous update attempts complained about a conflict in dependencies. 
 need to do:

```bat
cd c:\src\github\RProvider
.paket\paket.exe update
```

```bat
build.cmd
```

```
System.Exception: Could not detect package version for DynamicInterop ---> System.Exception: Package DynamicInterop was not found.
```

Curious how the dependency of R.NET on DynamicInterop is not detected anymore in the resulting paket.lock file:

```
    R.NET (1.8.0-alpha1)
    R.NET.FSharp (1.8.0-alpha)
```

Checking [paket documentation](https://fsprojects.github.io/Paket/nuget-dependencies.html#Prereleases)

## 2019-05 testing RProvider installation against R.NET 1.8.2

I try `build.cmd` again after updating `RProvider\paket.dependencies` to R.NET.* 1.8.2 but the compilation fails. Also the dependency pacage seem to only reer to the older alpha versions. Annoying. Same mistake as last month. So:

```bat
cd c:\src\github\RProvider
.paket\paket.exe update
```

"Package R.NET contains libraries, but not for the selected TargetFramework net461"

```bat
build.cmd
```

`error FS0039: The namespace or module 'RDotNet' is not defined.`.