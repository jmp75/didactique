# C++ related learnings

## xtensor

[Docs](https://xtensor.readthedocs.io/en/latest) and [source](https://github.com/QuantStack/xtensor)

```sh
cd ~/src/github
git clone git@github.com:QuantStack/xtl.git
git clone git@github.com:QuantStack/xsimd.git
git clone git@github.com:QuantStack/xtensor.git
```

```sh
cd ~/src/github/xtl/
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr/local ..
sudo make install
```

```sh
cd ~/src/github/xsimd/
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr/local ..
sudo make install
```

[Cmake Build options for xtensor](https://xtensor.readthedocs.io/en/latest/build-options.html)

```sh
sudo apt-get install libgtest-dev

cd ~/src/github/xtensor/
mkdir build
cd build
# cmake -DCMAKE_INSTALL_PREFIX=/usr/local ..
cmake -DBUILD_TESTS=ON  -DCMAKE_INSTALL_PREFIX=/usr/local -DGTEST_SRC_DIR=/usr/include/gtest -DXTENSOR_USE_XSIMD=ON ..
```

```txt
Make Error at test/CMakeLists.txt:68 (add_subdirectory):
  The source directory

    /home/per202/src/github/xtensor/build/test/googletest-src
```

Note the `BUILD_BENCHMARK` option, which may not be correctly documented in the readme and installation/build instructions (which say BUILD_TESTS enables tests and benchmark)

```sh
cmake -DBUILD_TESTS=ON -DBUILD_BENCHMARK=ON -DCMAKE_INSTALL_PREFIX=/usr/local -DDOWNLOAD_GTEST=ON -DXTENSOR_USE_XSIMD=ON ..
```

```txt
Specified unknown feature "cxx_std_14" for target
```

I am using cmake version 3.7.2 out of the Debian Stable box. This may not be quite enough for c++ 14 though a wild second guess from google stab...

```sh
cd /usr/local
sudo ~/Downloads/cmake-3.12.1-Linux-x86_64.sh
ls
which cmake
```

Well, this seems to indeed solve that issue.

```sh
make xtest
make xbenchmark
```

sudo make install