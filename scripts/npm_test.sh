#!/bin/bash

return_code=0;

echo starting linter
./node_modules/.bin/eslint *.js
if [ $? -eq 1 ]
then
	echo eslint ko
	return_code=1
else
	echo eslint ok
fi
echo starting unit-test
./node_modules/.bin/mocha
if [ $? -eq 1 ]
then
	echo unit-test ko
	return_code=1
else
	echo unit-test ok
fi
exit $return_code;
