# Angle Grinder

[![Build status](https://secure.travis-ci.org/9ci/angle-grinder.png)](http://travis-ci.org/9ci/angle-grinder)
[![Stories in Ready](https://badge.waffle.io/9ci/angle-grinder.png)](http://waffle.io/9ci/angle-grinder)

Documentation: http://9ci.github.io/angle-grinder

## Bootstrap

Install nodejs v0.10.12 from the sources:

```
sudo apt-get install build-essential openssl libssl-dev pkg-config

wget http://nodejs.org/dist/v0.10.12/node-v0.10.12.tar.gz
tar -xzf node-v0.10.12.tar.gz

cd node-v0.10.12
./configure
make
sudo make install
```

## Install tools

```
npm install -g coffee-script
npm install -g grunt-cli
npm install -g bower
```

### Run the app

```
./script/bootstrap
./script/run-frontend-server
./script/run-ag-demo
```

open http://localhost:9000

## Directory structure

* ./app - contains CoffeeScript sources, styles, images, fonts and other assets
  * ./app/scripts - CoffeeScript sources
  * ./app/styles - stylesheets
  * ./app/views - html views used by AngularJS
* ./test - contains tests for the application
  * ./tests/integration - protractor integration specs
  * ./tests/unit - unit tests for AngularJS components

Third-party libraries

* ./bower - components downloaded by `bower install` command
* ./third-party - you could put custom components here
* ./node_modules - command downloaded by `npm install` command

Generated stuff

* ./dev - compiled development release
* ./dist - created by `grunt build` command, contains the production minified release of the app

## Running tests

By default all tests are executed in PhantomJS browser

* `grunt test:unit` or `grunt test` - run unit tests
* `grunt test:unit:watch` or
* `grunt test:watch` - run unit tests in watch mode
* `grunt test:coverage` or
* `grunt test:unit:coverage` - run unit tests against compiled development release and generate code coverage report
* `grunt test:unit:coverage --coverage-reporter=html` - generate html code coverage report

* `grunt test --reporters=spec` - run tests with `spec` reporter
* `grunt test --browsers=Chrome,Firefox` - run tests inside Chrome and Firefox

Run test against specific browsers

`grunt test:unit --browsers=Chrome,Firefox,Opera,PhantomJS`

### How to debug failing specs

Put `debugger` in the failing spec:

```coffee
describe "Failing spec", ->

  it "should run smoothly", ->
    debugger # this is like setting a breakpoint
    failMiserably()
```

Run karma in Chrome browser:

`grunt test:watch --browsers=Chrome`

* Go to the newly opened Chrome Browser
* Open Chrome's DevTools and refresh the page
* Now in the source tab you should see the execution stopped at the debugger

### Running tests headlessly

Start Xvfb and export DISPLAY variable:

```
./script/xvfb start
export DISPLAY=:99
```

Perform single run:

`grunt test --browsers=Firefox,Chrome,Opera,PhantomJS`

or

`grunt test:watch --browsers=Chrome`

## Protractor integration tests

Install standalone Selenium `bin/install-selenium`
Start the app in the `test` env `grunt build:dev` `configureProxies connect:integration watch`
Manually run the specs `bin/run-protractor`

## Build process

```
grunt build
(cd dist/ ; python -m SimpleHTTPServer 8000)
```

## Released files

```
dist
├── scripts
│   ├── angleGrinder.gridz.min.js
│   ├── bootstrap.min.js
│   ├── gridz.min.js
│   ├── scripts.min.js
│   ├── jquery.min.js
│   └── angularjs-all.min.js
└── styles
    ├── bootstrap.min.css
    ├── gridz.min.css
    └── style.min.css
```

* `scripts/angularjs-all.min.js` - AngularJS stuff
* `styles/bootstrap.min.css` - twitter bootstrap styles
* `scripts/bootstrap.min.js` - twitter bootstrap js + angular-bootstrap
* `styles/gridz.min.css` - styles for gridz plugin
* `scripts/gridz.min.js` - sources of gridz plugin
* `scripts/angleGrinder.gridz.min.js` - AgularJS directive for gridz

And then navigate to `http://localhost:8000` to see the production release.

## File upload demo

`./node_modules/blueimp-file-upload-node/server.js`

## Build and release the documentation

Clone the `gh-pages` branch:

`git clone -b gh-pages https://github.com/9ci/angle-grinder angle-grinder-gh-pages`

You must have `angle-grinder` and `angle-grinder-gh-pages` in the same directory.
Go to `angle-grinder-gh-pages`directory,  build the app and push changes to `gh-pages` branch:

```
cd angle-grinder-gh-pages
scripts/upgrade-angle-grinder.sh
git commit -am 'chore: release the documentation'
```

## Contributing to Source Code

We'd love for you to contribute to our source code and to make Angle Grinder even
better than it is today!

 Please read the [contribution guidelines][contribute] to learn about how to submit code as well as
 other useful info like how to build and test Angle Grinder code.

[contribute]: https://docs.google.com/document/d/1QrDFcIiPjSLDn3EL15IJygNPiHORgU1_OOAqWjiDU5Y/edit#
