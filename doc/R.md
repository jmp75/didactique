
## Compiling R from sources on Windows

See "R Installation and Administration"

Installing Miktex

```bat
cd c:\src\tmp\R-4.0.2\src\gnuwin32
where pdflatex
make
```

Cylance craps again:

```
Suspicious file found:
C:\src\tmp\R-4.0.2\src\gnuwin32\Rpwd.exe
```

```text
connections.c:2016:10: fatal error: lzma.h: No such file or directory
 #include <lzma.h>
          ^~~~~~~~
```

the PDF "R Installation and Administration" looks woefully lacking in important step instructions... No mention of target `rsync-extsoft`

https://colinfay.me/r-installation-administration/installing-r-under-windows.html

Actually, tar zxpvf and tar -xf both have issues such as:

x R-4.0.2/tests/Pkgs/pkgA: Can't create '\\\\?\\c:\\src\\tmp\\R-4.0.2\\tests\\Pkgs\\pkgA'

So, try to do the extractiion from Linux. 

Reboot, kill Cylance.

```bat
cd c:\src\tmp\R-4.0.2\src\gnuwin32
make rsync-extsoft
make rsync-recommended
:: Try retrieving also the extras for version 3.6
cd c:\src\tmp\R-4.0.2\extsoft\
sync --timeout=60 -rcvp --delete cran.r-project.org::CRAN/bin/windows/extsoft/3.6/ .
mkdir newtcl
cd newtcl
sync --timeout=60 -rcvp --delete cran.r-project.org::CRAN/bin/windows/extsoft/4.0/ .
mv tcltk-8.6.8.zip ../

cd c:\src\tmp\R-4.0.2\src\gnuwin32
make clean
make DEBUG=1
```

The flag  `-I"/extsoft"/include` in the failing command  `c:/rtools40/mingw32/bin/gcc -std=gnu99  -I. -I../include -DHAVE_CONFIG_H -DR_DLL_BUILD -DR_ARCH='"i386"' -DLZMA_API_STATIC -I"/extsoft"/include -O3 -Wall -pedantic -mfpmath=sse -msse2 -mstackrealign -gdwarf-2   -c connections.c -o connections.o`  looks suspiciously like a variable subsititution failed.
