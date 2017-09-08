# Purpose

Been wanting to generate CFFI bindings. I have a substantial py codebase as a sample but need to be a bit more systematic in my know-how about that.

Compiling the native C++ code: using Visual Studio and VC++

# if mingw is installed (or related such as RTools)

```bat
g++ -c native.cpp --shared -o native.dll
```

In order to check on the exported function (symbol) names

```bat
nm native.dll
```
# Log

note that I came accross during tests 
```
 cannot load library C:\src\github_jm\didactique\python_cffi\minimal\mypypkg\wrap\..\..\native_lib\native.dll: error 0xc1
```
This may be when 64 bits tries to load 32 bits... 

# Related