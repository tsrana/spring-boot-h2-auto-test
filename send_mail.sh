echo "key -- $SENDGRID_API_KEY"

#openssl base64 -in emailable-report.html -out emailable-report1.html
cnt=`base64 emailable-report.html`
echo "cnt -- $cnt"

data='{"personalizations": [{"to": [{"email": "thecloudteacher@gmail.com"}]}],"from": {"email": "tsrana@gmail.com"},"subject":"Hello, World!","content": [{"type": "text/html","value": "Hey,<br>Please find attachment."}], "attachments": [{"content": "'$cnt'", "type": "text/html", "filename": "emailable-report.html"}]}'
data1="'"$data"'"

echo "data- $data1"

curl --request POST --url https://api.sendgrid.com/v3/mail/send --header "authorization: Bearer $SENDGRID_API_KEY" --header 'Content-Type: application/json' --data " $data1"