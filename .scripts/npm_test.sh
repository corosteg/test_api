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
echo $eslint > eslint.json
echo $unit_test > unitTest.json
cat unitTest.json
cat eslint.json
#quote=$(echo \") 
#git=$(git config --get remote.origin.url)
#git_url="${quote}${git}${quote}"
#response="${eslint}"
#echo $response
#unit_test_final=
#echo $git_url
#echo ${unit_test}
#echo '{"link": '$git_url'}'
#echo '{"link":'$git_url',"response":{"eslintFail":"'$eslint_return'","eslintMessage":'$eslint', "unitTest":'$unit_test'}'
#echo '{"link":'$git_url',"response":'$eslint'}' 
#curl -i -H "Accept: application/json" \
#	-H "Content-Type:application/json"  \
#	--data-urlencode '{"link":'$git_url',"response":'$eslint'}' \
#	"https://us-central1-github-hook-fe560.cloudfunctions.net/api2"
exit $return_code;
