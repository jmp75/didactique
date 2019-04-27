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
mkdir -p build
cd build
rm -rf ../build/*
cmake -DCMAKE_INSTALL_PREFIX=/usr/local ..
make
sudo make install
```

```sh
cd ~/src/github/xsimd/
mkdir -p build
cd build
rm -rf ../build/*
cmake -DCMAKE_INSTALL_PREFIX=/usr/local ..
make
sudo make install
```

[Cmake Build options for xtensor](https://xtensor.readthedocs.io/en/latest/build-options.html)

```sh
sudo apt-get install libgtest-dev

cd ~/src/github/xtensor/
mkdir -p build
cd build
#rm -rf ../build/*
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

```sh
cmake -DBUILD_TESTS=OFF -DBUILD_BENCHMARK=OFF -DCMAKE_INSTALL_PREFIX=/usr/local -DXTENSOR_USE_XSIMD=ON _DXTENSOR_USE_TBB=ON ..
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
# sudo make install
```

## getting started docco

[getting_started first example](https://xtensor.readthedocs.io/en/latest/getting_started.html#first-example )

```text
~/src/tmp/xtensor/first_example/build$ make
[ 50%] Linking CXX executable first_example
/usr/bin/ld: cannot find -lxsimd
```

## cling

while exploring xtensor ([this post](https://blog.esciencecenter.nl/irregular-data-in-pandas-using-c-88ce311cb9ef)) I came accross [The cling C++ interpreter](https://github.com/root-project/cling). CERN goodie. With a Jupyter Kernel.

```sh
cd ~/src/tmp/
mkdir cling
cd cling

source ~/anaconda3/bin/activate
my_env_name=cling
conda create --name ${my_env_name} python=3.6
conda activate  ${my_env_name}

wget https://raw.githubusercontent.com/root-project/cling/master/tools/packaging/cpt.py
chmod +x cpt.py
```

Now go fetch a coffee because the following will take some time. Even scramming all CPUs. For some reasons cpt seems to not try to use llvm/clang stuff from the distro but recompile instead. Also, this will gobble up quite a few GBs of HDD. Like, 24GB when I stopped.

```sh
./cpt.py --check-requirements && ./cpt.py --create-dev-env Debug --with-workdir=./cling-build/
```

The cling repo has a jupyter kernel, but there is also the more recent [xeus-cling](https://github.com/QuantStack/xeus-cling). See [this post](https://blog.jupyter.org/interactive-workflows-for-c-with-jupyter-fe9b54227d92) for context.