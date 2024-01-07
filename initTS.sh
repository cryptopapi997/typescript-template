#!/bin/bash

# Variable to store the path to this directory (no extra slash, i.e. /home/user/typescript-template NOT /home/user/home/user/typescript-template/ )
packagePath="ABSOLUTE_PATH_TO_DIR"

# Check if the number of arguments is not equal to 1
if [ "$#" -ne 1 ]; then
    echo "Error: Exactly one argument is required [package-name]"
    exit 1
fi

echo "Initialzing package $1..."

mkdir "$1"
cd "$1"
npm init -y


cp "$packagePath"/tsconfig.json .
cp "$packagePath"/.eslintrc.json .
cp "$packagePath"/.mocharc.json .
cp "$packagePath"/gitignoreTemplate .gitignore
cp -r "$packagePath"/src/ .
cp -r "$packagePath"/test/ .
cp -r "$packagePath"/config/ .

echo "Setting package scripts..."

npm pkg set 'scripts.lint'='eslint --ext .ts src/ test/'
npm pkg set 'scripts.lint:fix'='eslint --ext .ts src/ test/ --fix'
npm pkg set 'scripts.lint:clean'='rm -rf dist/ && rm -rf build/'
npm pkg set 'scripts.compile'='tsc'
npm pkg set 'scripts.bundle:cjs'='node node_modules/rollup/dist/bin/rollup --config config/rollup.config.cjs.js'
npm pkg set 'scripts.bundle:esm'='node node_modules/rollup/dist/bin/rollup --config config/rollup.config.esm.js'
npm pkg set 'scripts.bundle:dts'='node node_modules/rollup/dist/bin/rollup --config config/rollup.config.dts.js'
npm pkg set 'scripts.bundle'='npm run compile && npm run bundle:cjs && npm run bundle:esm && npm run bundle:dts'
npm pkg set 'scripts.test'='mocha 'test/**/*.{ts,js}' --exit'
npm pkg set 'scripts.test-single'='mocha $1 --exit'
npm pkg set 'type'='module'
npm pkg set 'main'='build/index.mjs'
npm pkg set 'module'='build/index.mjs'
npm pkg set 'types'='build/index.d.ts'
npm pkg set 'files[]'='build/index.cjs'
npm pkg set 'files[]'='build/index.mjs'
npm pkg set 'files[]'='build/index.d.ts'
npm pkg set 'exports[0].import'='./build/index.mjs'
npm pkg set 'exports[0].require'='./build/index.cjs'

echo "Installing dev dependencies..."
npm install -D typescript chai @types/chai mocha @types/mocha eslint rollup ts-node


echo "Installing more dev dependencies..."
# Some deps have to be installed seperately for some reason, else they throw weird errors
npm install -D @rollup/plugin-typescript eslint-config-airbnb-base \
    eslint-plugin-import @typescript-eslint/eslint-plugin @typescript-eslint/parser
