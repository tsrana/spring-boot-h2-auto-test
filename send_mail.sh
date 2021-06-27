#!/bin/bash

#set -x


	skipped="3"
	failed="6"
	total="16"
	passed="7"
	
	echo "Test Result --- skipped=$skipped failed=$failed total=$total passed=$passed"
		
	email_to=thecloudteacher@gmail.com
	subject="Test Result for H2 Build - `date`"
	body="<h1>Test Result --- </h1> <p style='color:DodgerBlue;font-size:50px'>Skipped=$skipped </p> <p style='color:Tomato;font-size:50px'>Failed=$failed </p> <p style='color:MediumSeaGreen;font-size:50px'>Passed=$passed </p> <p style='color:Gray;font-size:50px'>Total=$total  </p> <br><br>-- Please find the atteched TEST Results" 
	export subject
	export body
	echo ""
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

echo ""
echo "Test FAILED -- contact admin"
exit 1;