# test run xtensor-python

2019-01: considering using xtensor-python and pybind11 to access ensemble forecast time series in C++ and expose them to Python. xframe is also likely to be of prime interest but very new. Anyway, all exploratory at this stage.

## Log

Trying to use cookiecutter as per the readme documentation.

```bat
conda activate uchronia
conda install -c conda-forge xtensor-python
pip install cookiecutter
cookiecutter https://github.com/QuantStack/xtensor-python-cookiecutter.git
```

`FileNotFoundError: [WinError 2] The system cannot find the file specified`

