#ifdef _MSC_VER
#define STRDUP _strdup
#else
#include <string.h>
#define STRDUP strdup
#endif

#ifdef _MSC_VER
#ifdef USING_NATIVE
#define NATIVE_API __declspec(dllimport)
#define TEMPLATE_SPECIALIZATION_EXTERN extern
#else
#define NATIVE_API __declspec(dllexport)
//#define TEMPLATE_SPECIALIZATION_EXTERN

#pragma warning (disable : 4251)

#endif
#else
#define NATIVE_API // nothing
#define TEMPLATE_SPECIALIZATION_EXTERN
#endif

#include <string>
using std::string;

class native_class {
private:
	string name;
	double value;
public:
	native_class(const string& s, double value);

};


#ifdef __cplusplus
extern "C" {
#endif

	NATIVE_API char* returns_char_array();
	NATIVE_API void takes_char_array(const char* my_array);

	NATIVE_API double* returns_double_array(int* size);
	NATIVE_API void takes_double_array(const double* my_array, int size);

#ifdef __cplusplus
}
#endif
