#!/bin/bash

#set -x

if [ -d target/surefire-reports  ]
then
	if [ ! -f "target/surefire-reports/testng-results.xml"  ]
	then
		echo "test result not generated -- contact admin"
		exit 1
	fi	
	
	skipped=$(xmllint --xpath 'string(//testng-results/@skipped)' target/surefire-reports/testng-results.xml)
	failed=$(xmllint --xpath 'string(//testng-results/@failed)' target/surefire-reports/testng-results.xml)
	total=$(xmllint --xpath 'string(//testng-results/@total)' target/surefire-reports/testng-results.xml)
	passed=$(xmllint --xpath 'string(//testng-results/@passed)' target/surefire-reports/testng-results.xml)
	
	echo "Test Result --- skipped=$skipped failed=$failed total=$total passed=$passed"
		
	email_to=thecloudteacher@gmail.com
	subject="Test Result for H2 Build - `date`"
	echo "Test Result --- skipped=$skipped failed=$failed total=$total passed=$passed  -- Please find the atteched TEST Results" > target/surefire-reports/body.txt
	cd target/surefire-reports
	#zip -r surefire-reports.zip .
	echo ""
	echo ""
	if ! (mail -a emailable-report.html -s "$subject" "$email_to" < body.txt)
	then
		echo >&2 "Sending Mail Failed"
		exit 1
	fi
	echo "Test Result sent to - $email_to"
		
	if [ $skipped -eq "0" -a $failed -eq "0" -a $total -eq $passed ]
	then
		echo "All test cases passed --- "
		exit 0
	fi
fi

echo ""
echo "Test FAILED -- contact admin"
exit 1;