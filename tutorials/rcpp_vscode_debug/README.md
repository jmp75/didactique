# Debugging Rcpp-dependent packages from VS Code

You need to have installed the [C/C++ for Visual Studio Code](https://code.visualstudio.com/docs/languages/cpp) extension in visual studio

This folder contains the R package 'mypkg' which uses Rcpp.

The Makevars file of the package under the src folder defines additional compilation flags to output debug symbols for GDB:

```makefile
DBG_FLAGS=-Wall -pedantic -g -Og -UNDEBUG -ggdb
PKG_CPPFLAGS = $(DBG_FLAGS)
```

Install the package using `R CMD INSTALL mypkg`. This will install it, in this documentation, under ~/.local/lib/R/4.0.2/site-library/. You may want to check in your case.

## Attaching to the R process to debug 'mypkg'

See [Debugging](https://code.visualstudio.com/docs/editor/debugging) for general info.

Configure the 'launch.json' file of your vscode project to include a section derived from the following json snippet.

Something noteworthy is that this instructs to load only selected libraries, i.e. only 'mypkg.so' in this instance. This prevents having spurious exceptions caught in other libraries, as happened in a context attaching to jupyter kernels.

```json
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            // Adapted from debugging a native lib loaded by Python
            // https://code.visualstudio.com/docs/cpp/launch-json-reference
            // Not used as such but looking like a useful source: https://www.justinmklam.com/posts/2017/10/vscode-debugger-setup/
            // Maybe: https://marketplace.visualstudio.com/items?itemName=webfreak.debug
            // https://stackoverflow.com/questions/31763639/how-to-prevent-gdb-from-loading-debugging-symbol-for-a-large-library
            // I follow the instructions in https://developer.mozilla.org/en-US/docs/Archive/Mozilla/Using_gdb_on_wimpy_computers . May need adaptation to make it 
            // Nope. Need to use symbolLoadInfo below, but still stuck on libc6 exception
            // https://gist.github.com/asroy/ca018117e5dbbf53569b696a8c89204f
            "name": "(gdb) Attach to R session",
            "type": "cppdbg",
            "request": "attach",
            "program": "/usr/local/lib/R/bin/exec/R",
            "processId": "${command:pickProcess}",
            "MIMode": "gdb",
            "miDebuggerPath": "gdb",
            "additionalSOLibSearchPath": "/home/per202/.local/lib/R/4.0.2/site-library/mypkg/libs",
            "symbolLoadInfo":{
                "loadAll": false,
                "exceptionList": "mypkg.so"
            },
            "setupCommands": [
                {
                    "description": "Enable pretty-printing for gdb",
                    "text": "-enable-pretty-printing",
                    "ignoreFailures": true
                }
            ]
        }
   ]
}
```

Start the R program in an external console

in VSCode Use the 'F5' key to launch the debug task; choose '(gdb) Attach to R session' if prompted 

Choose the `R` process to attach to. If you have several, it may be tricky to guess the right one.

Back to the R console, load your package:

```R
library(mypkg)
```

Under the VSVode debug console you should now see: 

```text
Stopped due to shared library event (no libraries added or removed)
Stopped due to shared library event:
  Inferior loaded /home/per202/.local/lib/R/4.0.2/site-library/Rcpp/libs/Rcpp.so
Loaded '/home/per202/.local/lib/R/4.0.2/site-library/Rcpp/libs/Rcpp.so'. Cannot find or open the symbol file.
Stopped due to shared library event (no libraries added or removed)
Stopped due to shared library event:
  Inferior loaded /home/per202/.local/lib/R/4.0.2/site-library/mypkg/libs/mypkg.so
Loaded '/home/per202/.local/lib/R/4.0.2/site-library/mypkg/libs/mypkg.so'. Symbols loaded.
```

In Visual Studio Code put a breakpoint on the line `rcpp_result_gen = Rcpp::wrap(rcpp_hello_world());` in the file './mypkg/src/RcppExports.cpp'

It seems you cannot really put a breakpoint within `rcpp_hello_world` itself because it is a very simple function and all logic uses Rcpp constructs. Not sure whether compiling Rcpp in debug mode would change this, but if we had business logic in mypkg we could step through it in VSCode.


