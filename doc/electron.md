## Exploring Electron

### Diagnosing a deployed installation

Context: SVG diagram displays nicely when using `yarn dev` but blank in the packaged app. DEBUG_PROD and another environment variable should give access to the dev tools, but not. Tried a few things from SO but no luck.
Instead found that it is possible to start the app from the command line with a command line and remote debugger on a given port. Then inspect from a Google Chrome window. Worked a treat.

```bat
cd %localappdata%\Programs\waa-application
cd "resources"
ls *.asar
```

```bat
C:\src\csiro\stash\electron-waa\node_modules\.bin\asar.cmd --help
C:\src\csiro\stash\electron-waa\node_modules\.bin\asar.cmd list app.asar
```

### Starting

```sh
git clone https://github.com/electron/electron-quick-start
cd electron-quick-start
npm install
sudo chown root /home/per202/src/github/electron-quick-start/node_modules/electron/dist/chrome-sandbox
sudo chmod 4755 /home/per202/src/github/electron-quick-start/node_modules/electron/dist/chrome-sandbox
ls -l /home/per202/src/github/electron-quick-start/node_modules/electron/dist/chrome-sandbox
npm start
```

Getting some boilerplate code.

```sh
cd ~/src/tmp
git clone --depth 1 --single-branch --branch master https://github.com/electron-react-boilerplate/electron-react-boilerplate.git your-project-name
```

To install yarn see [this install doc](https://yarnpkg.com/lang/en/docs/install/#debian-stable), though it looks like `yarnpkg` is now available from Debian repo (on bullseye - currently the testing channel) also. 

https://www.npmjs.com/package/react-grid-system


## First iteration on javascript + python flask

This is a copy of material to test feasibility for the WAA tool.

Create the electron app. Start from which template?


Download the zip snapshot from [electron-react-boilerplate](https://github.com/electron-react-boilerplate/electron-react-boilerplate)

```sh
cd ~/src/tmp/electron-react-boilerplate-next
ls

ep_src=${HOME}/src/waa-tests/electron-python
mkdir -p ${ep_src}

cd ~/src/tmp/electron-react-boilerplate-next
mv * ${ep_src}

cd ${ep_src}
yarn

yarn dev
```

Now on to how to modify this so that this spins off a python process.

Resources of interest:

* https://www.makeuseof.com/tag/python-javascript-communicate-json/  so-so 
* https://developer.okta.com/blog/2018/12/20/crud-app-with-python-flask-react   rather good - but not Electron in scope.
* https://medium.com/@abulka/electron-python-4e8c807bfa5e
* https://scotch.io/tutorials/build-a-restful-api-with-flask-the-tdd-way


```sh
conda env list
conda activate waa
conda install flask


mkdir -p ${ep_src}/pysrc
cd ${ep_src}/pysrc
```

I try  `git commit -m "Commit starting point react electron boilerplate code"`


but there us a precommit hook with "ESLint couldn't find a configuration file"

eslint --init does not work. Tried to use  https://medium.com/@kilgarenone/set-up-eslint-in-a-javascript-app-400861551a06  but resorted to  `npm uninstall husky` to just not use this.

https://developer.okta.com/blog/2018/12/20/crud-app-with-python-flask-react appears the most promising

Contrary to instructions I will use conda not pipenv

```bash
conda activate waa
conda install -c conda-forge marshmallow
conda install -c conda-forge pymongo
conda install -c conda-forge pyjwt
conda install -c conda-forge flask-cors
```

```bash
cd somewhere
FLASK_APP=$PWD/app/http/api/endpoints.py FLASK_ENV=development python -m flask run --port 4433
# yarn global add create-react-app
cd app/http/web
# create-react-app app
cd app
npm start
git log
git status
ls
cd electron-python/
ls
cd pysrc/
ls
conda activate waa
python json_io.py 
ls
cd ..
```


