import os
import sys
import numpy as np

root_src = os.path.dirname(__file__)

sys.path.append(os.path.join(root_src, 'minimal'))
import mypypkg
from mypypkg.wrap.low_level import mylib_ffi

print(dir(mypypkg))

a = mypypkg.returns_char_array()
b = mypypkg.takes_char_array("blah")

size = mylib_ffi.new("int *", 0)
c = mypypkg.returns_double_array(size)
print(size[0])
returned_str = [mylib_ffi.string(c[idx]) for idx in range(size[0])]

d = np.zeros(5)
e = mypypkg.takes_double_array(d)

