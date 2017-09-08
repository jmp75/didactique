#include "native.h"
#include <string>

using std::string;

char* returns_char_array()
{
	return STRDUP(std::string("Hello").c_str());
}

void takes_char_array(const char* my_array)
{
	string so_what = string(my_array);
}

double* returns_double_array(int* size)
{
	*size = 3;
	double* result = new double[3]; 
	for (size_t i = 0; i < 3; i++)
		result[i] = i + 1;
	return result;
}

void takes_double_array(const double* my_array, int size)
{
}

native_class::native_class(const string& s, double value) 
{
	name = s; this->value = value;
}

