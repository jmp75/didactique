```sh
cd shyft
conda env create -f ./environment.yml
conda activate shyft
```

sudo apt install libarmadillo-dev lidlib-dev

mkdir build
cd build
cmake ..

```text
-- No build type specified. Defaulting to 'Release'.
-- SHYFT_DEPENDENCIES directory: /home/xxxyyy/src/github/shyft/shyft_dependencies
--   You can override the above via the $SHYFT_DEPENDENCIES_DIR environment variable
CMake Error at CMakeLists.txt:67 (find_package):
  By not providing "Finddoctest.cmake" in CMAKE_MODULE_PATH this project has
  asked CMake to find a package configuration file provided by "doctest", but
  CMake did not find one.

  Could not find a package configuration file provided by "doctest" with any
  of the following names:

    doctestConfig.cmake
    doctest-config.cmake
```

`sudo apt install doctest-dev`

Then I get complaints about boost not version at least 1.73. Indeed I seem to have 1.71 held back by something. Seems I can upgrade but need to do explicitely:

`sudo apt install libboost-atomic-dev  libboost-chrono-dev  libboost-date-time-dev  libboost-filesystem-dev libboost-graph-dev libboost-regex-dev libboost-system-dev libboost-thread-dev`

the `libboost-regex1.71.0-icu67` rings a bell, but cannot pin what. Something about dotnet installation? reported a github issue. Also, 1.71 version found in swift debian packages. so mostly my bad. Possibly.

i A libboost-date-time1.71.0 - set of date-time libraries based on generic programming concepts
i A libboost-filesystem1.71.0 - filesystem operations (portable paths, iteration over directories, etc) in C++
i A libboost-graph1.71.0 - generic graph components and algorithms in C++
i A libboost-regex1.71.0 - regular expression library for C++
v  libboost-regex1.71.0-icu67 - 
i A libboost-system1.71.0 - Operating system (e.g. diagnostics support) library
i A libboost-thread1.71.0 - portable C++ multi-threading

sudo apt remove libboost-date-time1.71.0  libboost-filesystem1.71.0  libboost-graph1.71.0  libboost-regex1.71.0  libboost-system1.71.0  libboost-thread1.71.0  libboost-regex1.71.0-icu67 

The following package was automatically installed and is no longer required:
  libjsoncpp1


`sudo apt install libboost-python-dev`

warning
  New Boost version may have incorrect or missing dependencies and imported targets

Seems to be something safe to overlook though, after googling it.

However:

```text
CMake Error at cpp/shyft/py/time_series/CMakeLists.txt:93 (get_filename_component):
  get_filename_component unknown component CACHE
```

  which seems to happens on

```text
        get_filename_component(d_lib ${dlib_lib} REALPATH CACHE)
```

Trying again later on, this time that error is gone. Unclear why.

```text
CMake Error at cpp/shyft/energy_market/ui/CMakeLists.txt:5 (find_package):
  By not providing "FindQt5.cmake" in CMAKE_MODULE_PATH this project has
```

```sh
sudo apt-get install qtbase5-dev
sudo apt-get install qtdeclarative5-dev
```

`sudo apt install libqt5charts5-dev`

Back to get_filename_component issue now:

```text
The path to the armadillo libraries is /usr/lib/libarmadillo.so
The path to the dlib libraries is 
The path to the OPENSSL_SSL_LIBRARY libraries is /usr/lib/x86_64-linux-gnu/libssl.so
The path to the OPENSSL_CRYPTO_LIBRARY libraries is /usr/lib/x86_64-linux-gnu/libcrypto.so
CMake Error at cpp/shyft/py/time_series/CMakeLists.txt:99 (get_filename_component):
```

`get_property(dlib_lib TARGET dlib::dlib PROPERTY IMPORTED_LOCATION_RELEASE)` seems to fail to retrieve anything. 

cmake's target properties are a novelty to me. I found it hard to figure out which to get and fish for them. When are they set, by what? seems whatever I did the system install had no IMPORTED_LOCATION_RELEASE property defined that I could see. 

```text
https://github.com/davisking/dlib/issues/616
https://cmake.org/cmake/help/latest/prop_tgt/IMPORTED_LOCATION.html
```

In the end needed to give up and use `set(dlib_lib "/usr/lib/x86_64-linux-gnu/libdlib.so")`. Then mostly compiles, but there is [this issue](https://github.com/boostorg/serialization/issues/217) showing up.

## Trying to compile against downloaded dependencies

Trying to follow https://gitlab.com/shyft-os/shyft/-/wikis/How-to/Ubuntu-installation-from-scratch

```sh
export WORKSPACE=~/workspace
mkdir -p $WORKSPACE
export SHYFT_DEPENDENCIES_DIR=$WORKSPACE
export CXX="g++-8"
export CC="gcc-8"
cd $WORKSPACE
# checkout
# git clone https://gitlab.com/shyft-os/shyft.git  
# git clone https://gitlab.com/shyft-os/shyft-data.git
# git clone https://gitlab.com/shyft-os/shyft-doc.git
```

```sh
bash shyft/build_support/build_dependencies.sh
```
leads to:
```
PackagesNotFoundError: The following packages are missing from the target environment:
  - conda-build
  - pip
  - conda-verify
  - anaconda-client
```

if trying again, `./boost/python/detail/wrap_python.hpp:57:11: fatal error: pyconfig.h: No such file or directory`
Needs to have upfront a suitable conda env activated, so using my own

```
source ~/.bc
conda activate shyft
which python
bash shyft/build_support/build_dependencies.sh
```

Seems to work. I suspect that the system FindDLIB.cmake (or similar) may be troublesome , so removing with `sudo apt-get remove libdlib19 libdlib-data`

```sh
# source $WORKSPACE/miniconda/etc/profile.d/conda.sh
# conda activate base
cd $WORKSPACE/shyft
mkdir build
cd build
cmake ..
```

```
-- Configuring done
CMake Warning at cpp/shyft/energy_market/ui/CMakeLists.txt:22 (add_library):
  Cannot generate a safe runtime search path for target em_ui because files
  in some directories may conflict with libraries in implicit directories:

    runtime library [libssl.so.1.1] in /usr/lib/x86_64-linux-gnu may be hidden by files in:
      /home/xxxyyy/anaconda3/envs/shyft/lib
    runtime library [libcrypto.so.1.1] in /usr/lib/x86_64-linux-gnu may be hidden by files in:
      /home/xxxyyy/anaconda3/envs/shyft/lib
    runtime library [libboost_system.so.1.74.0] in /usr/lib/x86_64-linux-gnu may be hidden by files in:
      /home/xxxyyy/anaconda3/envs/shyft/lib
    runtime library [libboost_filesystem.so.1.74.0] in /usr/lib/x86_64-linux-gnu may be hidden by files in:
      /home/xxxyyy/anaconda3/envs/shyft/lib
    runtime library [libboost_serialization.so.1.74.0] in /usr/lib/x86_64-linux-gnu may be hidden by files in:
      /home/xxxyyy/anaconda3/envs/shyft/lib
    runtime library [libboost_thread.so.1.74.0] in /usr/lib/x86_64-linux-gnu may be hidden by files in:
      /home/xxxyyy/anaconda3/envs/shyft/lib

```

`conda deactivate` till no env. need to clean cmake from cached dirs but then seems to work.

```
make -j 6 install > log.txt 2>&1
```

Still getting the same issue with boost serialisation

Trying for Jupyter notebook. activating conda shyft env. 

```sh
cd $WORKSPACE/shyft-doc
python
```

```py
import shyft
# Traceback (most recent call last):
#   File "<stdin>", line 1, in <module>
# ModuleNotFoundError: No module named 'shyft'
```

make install probably failed before deploying the python module. 

`python setup.py develop` not working, `python setup.py build_ext --inplace` same negative outcome:

```text
Building Shyft Open Source in /home/per202/workspace/shyft, cwd=/home/per202/workspace/shyft
VERSION file:4.20.24
One or more extension modules needs build, attempting auto build
shyft/api/_api.so: needs rebuild
shyft/energy_market/core/_core.so: needs rebuild
shyft/energy_market/ltm/_ltm.so: needs rebuild
shyft/energy_market/stm/_stm.so: needs rebuild
shyft/time_series/_time_series.so: needs rebuild
shyft/api/pt_st_k/_pt_st_k.so: needs rebuild
shyft/api/pt_gs_k/_pt_gs_k.so: needs rebuild
shyft/api/pt_hs_k/_pt_hs_k.so: needs rebuild
shyft/api/pt_hps_k/_pt_hps_k.so: needs rebuild
shyft/api/pt_ss_k/_pt_ss_k.so: needs rebuild
shyft/api/r_pm_gs_k/_r_pm_gs_k.so: needs rebuild
shyft/api/hbv_stack/_hbv_stack.so: needs rebuild
shyft/energy_market/stm/shop/_shop.so: needs rebuild
build_support/build_shyft.sh: 6: set: Illegal option -o pipefail
Problems compiling shyft, try building with the build_api.sh or build_api_cmake.sh (Linux only) script manually...
```

