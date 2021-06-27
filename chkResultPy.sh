#!/bin/bash

#set -x

if [ -d target/surefire-reports  ]
then
	if [ ! -f "target/surefire-reports/testng-results.xml"  ]
	then
		echo "test result not generated -- contact admin"
		exit 1
	fi	
	
	mv send_email.py target/surefire-reports
		
	skipped=$(xmllint --xpath 'string(//testng-results/@skipped)' target/surefire-reports/testng-results.xml)
	failed=$(xmllint --xpath 'string(//testng-results/@failed)' target/surefire-reports/testng-results.xml)
	total=$(xmllint --xpath 'string(//testng-results/@total)' target/surefire-reports/testng-results.xml)
	passed=$(xmllint --xpath 'string(//testng-results/@passed)' target/surefire-reports/testng-results.xml)
	
	echo "Test Result --- skipped=$skipped failed=$failed total=$total passed=$passed"
		
	email_to=thecloudteacher@gmail.com
	subject="Test Result for H2 Build - `date`"
	body="<h1>Test Result --- </h1> <p style='color:DodgerBlue;font-size:30px'>Skipped=$skipped </p> <p style='color:Tomato;font-size:30px'>Failed=$failed </p> <p style='color:MediumSeaGreen;font-size:30px'>Passed=$passed </p> <p style='color:Gray;font-size:30px'>Total=$total  </p> <br><br>-- Please find the atteched TEST Results" 
	export subject
	export body
	cd target/surefire-reports
	echo ""
	#if ! (mailx -a emailable-report.html -s "$subject" "$email_to" < body.txt)
	if ! (python send_email.py)
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