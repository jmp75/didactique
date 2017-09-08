"""A package to test Python/C interop with CFFI """

from mypypkg.wrap import mylib_so 

def returns_char_array():
    return(mylib_so.returns_char_array())

def takes_char_array(a_string):
    return(mylib_so.takes_char_array(a_string))

def returns_double_array(size):
    size = mylib_so.new("int *", 0)
    values = mylib_so.returns_double_array(size)
    return [mylib_so.string(values[idx]) for idx in range(size[0])]

def takes_double_array(my_array):
    return(mylib_so.takes_double_array(my_array))

__version__ = '0.1.1'
