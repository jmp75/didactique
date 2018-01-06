import os
import sys
import numpy as np

root_src = os.path.dirname(__file__)

sys.path.append(os.path.join(root_src, 'minimal'))
import mypypkg

print(dir(mypypkg))

a = mypypkg.returns_char_array()
b = mypypkg.takes_char_array("blah")
c = mypypkg.returns_double_array(7)

d = np.zeros(5)
e = mypypkg.takes_double_array(d)

