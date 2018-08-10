#!/bin/bash

# source ./obj.h

# obj response

return_code=0;

echo starting linter
# eslint=\"
eslint=$(./node_modules/.bin/eslint -f json src/*.js)
if [ $? -eq 1 ]
then
	echo eslint ko
	return_code=1
	eslint_return=1
else
	echo eslint ok
	eslint_return=0
fi
echo starting unit-test
unit_test=$(./node_modules/.bin/mocha --reporter json)
if [ $? -eq 1 ]
then
	echo unit-test ko
	return_code=1
	unit_test_return=1
else
	echo unit-test ok
	unit_test_return=0
fi
if [ -e ./tmp ]
then
	echo 'tmp exist'
else
	mkdir ./tmp
fi
echo $eslint_return > ./tmp/eslintFail.txt
echo $eslint > ./tmp/eslintMessage.json
echo $unit_test_return > ./tmp/unitTestFail.txt
echo $unit_test > ./tmp/unitTestMessage.json
echo $(git config --get remote.origin.url) > ./tmp/gitPath.txt
ls -lRa
rm -f ./tmp/*
exit $return_code;
