

I started to move some projects to .NET core such as [Dynamic Interop](https://github.com/jmp75/dynamic-interop-dll). Cannot locate learning notes if I wrote any, hence this doc.

[Daniel Crabtree's blog](https://www.danielcrabtree.com/blog/314/upgrading-to-net-core-and-net-standard-made-easy)

[Microsoft Porting to .NET Core from .NET Framework](https://docs.microsoft.com/en-us/dotnet/core/porting/)

There is a [portability VS extension](https://marketplace.visualstudio.com/items?itemName=ConnieYau.NETPortabilityAnalyzer)

I had a look at running rClr on .NET core. Some links:
[Hosting .NET Core from native code](https://docs.microsoft.com/en-us/dotnet/core/tutorials/netcore-hosting)

# Log

Following the instructions in the MS post, easy upgrade all to 4.6.2, and contrary to dynamic interop, out of the box 100% compat. Woot woot.

Also found the following for migration: [DotNetTools](https://github.com/pchalamet/DotNetTools)

## 2018-01-06

Having another go at porting r.net to .net core 2.0. 

* Decided to go the manual route to upgrade projects. i don't seem to get expected output from DotNetTools .
* Following instructions in (Paket for dotnet)[https://fsprojects.github.io/Paket/paket-and-dotnet-cli.html] this seems to have had a positive effect on an isssue I had with NETStandard.Library conflict (downgrade version issue between r.net native lib and R.NET assemblies)
* nunit package causing grief - not found in build via vs. 

```
3>SimpleTest -> C:\src\github_jm\rdotnet\TestApps\SimpleTest\bin\Debug\netcoreapp2.0\SimpleTest.dll
4>------ Build started: Project: RDotNet.TestBase, Configuration: Debug Any CPU ------
4>C:\src\github_jm\rdotnet\RDotNet.TestBase\RDotNet.TestBase.csproj : error NU1102: Unable to find package nunit.framework with version (>= 3.9.0)
4>C:\src\github_jm\rdotnet\RDotNet.TestBase\RDotNet.TestBase.csproj : error NU1102:   - Found 1 version(s) in nuget.org [ Nearest version: 2.63.0 ]
4>C:\src\github_jm\rdotnet\RDotNet.TestBase\RDotNet.TestBase.csproj : error NU1102:   - Found 0 version(s) in local
4>C:\src\github_jm\rdotnet\RDotNet.TestBase\RDotNet.TestBase.csproj : error NU1102:   - Found 0 version(s) in Microsoft Visual Studio Offline Packages
```

[nunit has a section on .net core standard](https://github.com/nunit/docs/wiki/.NET-Core-and-.NET-Standard) the packagereference item should be nunit not nunit.framework `xml <PackageReference Include="NUnit" Version="3.9.0" />
`

```
1>C:\src\github_jm\rdotnet\RDotNet.TestBase\RDotNet.TestBase.csproj : warning NU1701: Package 'Microsoft.NET.Test.Sdk 15.0.0' was restored using '.NETFramework,Version=v4.6.1' instead of the project target framework '.NETStandard,Version=v2.0'. This package may not be fully compatible with your project.
```

solved via sdding `nuget Microsoft.NET.Test.Sdk` to paket.dependencies and proj paket.dep and then update/restore

```
4>RDotNetTestFixture.cs(30,10,30,26): error CS0246: The type or namespace name 'TestFixtureSetUpAttribute' could not be found (are you missing a using directive or an assembly reference?)
```
[setup and teardown changes in nunit 3](https://github.com/nunit/docs/wiki/SetUp-and-TearDown-Changes)

I cannot see any test in VS Test Explorer. It seems another nuget package dependency is needed... [dotnet-test-nunit](https://www.nuget.org/packages/dotnet-test-nunit/)

note that i need `<TargetFramework>netcoreapp2.0</TargetFramework>` in  dynamicinterop.tests proj file otherwise 
```
[7/01/2018 5:57:02 PM Warning] [xUnit.net 00:00:00.7239823] Skipping: DynamicInterop.Tests (Could not find/load any of the following assemblies: xunit.execution.desktop.dll)
```
and there are no tests shown in the test explorer. 

Looking into porting dynamic-interop-dll  to .net standard 2.0.

TIL:
* paths operations with DirectoryInfo appears to go very wrong in VSCode debug; fullnames seem to double lengths oddly.
I was utterly confused by the compilation process, sometimes getting complains about Directory.GetParent should be calle as a static method (which I was doing). I stabbed in the dark including removing stuff in ~/.dotnet and ~/.nuget suspecting I had a dodgy System.IO.FileSystem assembly wrecking things. No idea.
Tried to run unit tests from the command line besides vscode. from vscode, fails with screwed path handling. Command line trying to run specific tests but hard to locate documentation: [there](https://github.com/Microsoft/vstest-docs/blob/master/docs/filter.md)

```bash
# note the ~ is for contains...
dotnet test DynamicInterop.Tests/DynamicInterop.Tests.csproj --filter DisplayName~TestNativeObjectReferenceCounting
```






# 2018-01-16

Trying with the prerelease of dynamicinterop

Found that you can override the behavior of `packet restore` (NOT `paket update` !) with a `paket.local` file:
```
nuget DynamicInterop -> source c:\local\nuget\ version 0.9.0-alpha.1
```

[paket local file](https://fsprojects.github.io/Paket/local-file.html) and [this blog](http://theimowski.com/blog/2016/05-19-paket-workflow-for-testing-new-nuget-package-before-release/index.htm)

# 2018-01-28

Trying to work on the fsproj files. Working by inference from e.g. [SQLProvider.Standard.fsproj](https://github.com/fsprojects/SQLProvider/blob/master/src/SQLProvider.Standard/SQLProvider.Standard.fsproj)


TIL I use 

```xml
    <OutputType>Exe</OutputType>
    <TargetFramework>netstandard2.0</TargetFramework>
```
but I get the output:
`netstandard2.0\EngineDisposeTest.dll`

