echo "key -- $SENDGRID_API_KEY"

#openssl base64 -in emailable-report.html -out emailable-report1.html
cnt=`base64 emailable-report.html`
echo "cnt -- $cnt"

curl --request POST --url https://api.sendgrid.com/v3/mail/send --header "authorization: Bearer $SENDGRID_API_KEY" --header 'Content-Type: application/json' --data '{"personalizations": [{"to": [{"email": "thecloudteacher@gmail.com"}]}],"from": {"email": "tsrana@gmail.com"},"subject":"Hello, World!","content": [{"type": "text/html","value": "Hey,<br>Please find attachment."}], "attachments": [{"content": "base64", "type": "text/html", "filename": "emailable-report.html"}]}'