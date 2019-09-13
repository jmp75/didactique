import os
import sys

from cffi import FFI

FFI_ = FFI()
FFI_.cdef('extern int AddIntegers(int a, int b);')

libs_path = os.path.join(os.path.dirname(__file__),'fplib')
dll_path = os.path.join(libs_path, "test_interop.dll")

LIB = FFI_.dlopen(dll_path, 1) # 1 for Lazy loading
dir(LIB)

blah = LIB.AddIntegers(1, 5)
print(blah)