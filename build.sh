#!/usr/bin/env bash

SCRIPTPATH=`readlink -e $(dirname $0)`
cd ${SCRIPTPATH}

vue build -t lib -n VueWeekdays src/index.js

