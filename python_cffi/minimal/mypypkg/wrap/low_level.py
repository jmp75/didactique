import sys

from cffi import FFI
mylib_ffi = FFI()

import os 

def load_api_from_file():
    dir_path = os.path.dirname(os.path.realpath(__file__))
    # See for important caveats:
    # https://stackoverflow.com/questions/5137497/find-current-directory-and-files-directory
    cdefs_dir = os.path.join(dir_path, 'api_definitions')
    with open(os.path.join(cdefs_dir, 'structs_cdef.h')) as f_headers:
        mylib_ffi.cdef(f_headers.read())

    with open(os.path.join(cdefs_dir, 'funcs_cdef.h')) as f_headers:
        mylib_ffi.cdef(f_headers.read())

    # native_lib_path = os.path.join(dir_path, '..', '..', 'native_lib', 'native.dll')
    if sys.platform == 'windows':
        native_lib_path = os.path.join(dir_path, '..', '..', 'native_lib/x64/Debug/native.dll')
    else:
        native_lib_path = os.path.join(dir_path, '..', '..', 'native_lib/native.so')
    mylib_so = mylib_ffi.dlopen(native_lib_path, 1)
    return(mylib_so)

