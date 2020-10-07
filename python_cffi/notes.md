# Purpose

Been wanting to generate CFFI bindings. I have a substantial py codebase as a sample but need to be a bit more systematic in my know-how about that.

Compiling the native C++ code: 

# Windows 
* using Visual Studio and VC++; or
* if mingw is installed (or related such as RTools):

```bat
g++ native.cpp -fPIC --shared -o native.dll
```

# Linux

```sh
g++ native.cpp -fPIC --shared -o native.so
```

In order to check on the exported function (symbol) names

```bat
nm native.dll
```

# test

```sh
cd ~/src/github_jm/didactique/python_cffi/minimal
python3 
```

```python
import sys
sys.path.insert(0, '.')
import mypypkg
```

# Log

note that I came accross during tests 
```
 cannot load library C:\src\github_jm\didactique\python_cffi\minimal\mypypkg\wrap\..\..\native_lib\native.dll: error 0xc1
```
This may be when 64 bits tries to load 32 bits... 

# Related

[Possible to autogenerate Cython bindings around a large, existing C library?](https://stackoverflow.com/questions/31145163/possible-to-autogenerate-cython-bindings-around-a-large-existing-c-library)