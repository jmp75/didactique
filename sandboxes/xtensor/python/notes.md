# test run xtensor-python

2019-01: considering using xtensor-python and pybind11 to access ensemble forecast time series in C++ and expose them to Python. xframe is also likely to be of prime interest but very new. Anyway, all exploratory at this stage.

## Log

Trying to use cookiecutter as per the readme documentation. See [xtensor-python-cookiecutter](https://github.com/QuantStack/xtensor-python-cookiecutter)

```bat
conda activate uchronia
conda install -c conda-forge xtensor-python
pip install cookiecutter
cookiecutter https://github.com/QuantStack/xtensor-python-cookiecutter.git
```

`FileNotFoundError: [WinError 2] The system cannot find the file specified`

Trying on Linux - works fine.

```bash
env_name=pyuchronia
conda install --name $env_name ipykernel
python -m ipykernel install --name $env_name --display-name "Python3 (uchronia)"
```

`cd xtensor-example-extension` and `jupyter-lab`
