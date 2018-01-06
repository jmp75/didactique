

I started to move some projects to .NET core such as [Dynamic Interop](https://github.com/jmp75/dynamic-interop-dll). Cannot locate learning notes if I wrote any, hence this doc.

[Daniel Crabtree's blog](https://www.danielcrabtree.com/blog/314/upgrading-to-net-core-and-net-standard-made-easy)

[Microsoft Porting to .NET Core from .NET Framework](https://docs.microsoft.com/en-us/dotnet/core/porting/)

There is a [portability VS extension](https://marketplace.visualstudio.com/items?itemName=ConnieYau.NETPortabilityAnalyzer)

I had a look at running rClr on .NET core. Some links:
[Hosting .NET Core from native code](https://docs.microsoft.com/en-us/dotnet/core/tutorials/netcore-hosting)

# Log

Following the instructions in the MS post, easy upgrade all to 4.6.2, and contrary to dynamic interop, out of the box 100% compat. Woot woot.
