#!/bin/bash

return_code=0;

echo starting linter
eslint=$(./node_modules/.bin/eslint -f json *.js)
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
curl -i -d "eslintFail='$eslint_return'" -d "eslintMessage='$eslint'"\
	-d "unitTestFail='$unit_test_return'" -d "unitTestMessage='$unit_test'"\
	"https://us-central1-github-hook-fe560.cloudfunctions.net/test"
exit $return_code;
