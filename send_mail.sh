echo "key -- $SENDGRID_API_KEY"

curl --request POST --url https://api.sendgrid.com/v3/mail/send --header "authorization: Bearer $SENDGRID_API_KEY" --header 'Content-Type: application/json' --data '{"personalizations": [{"to": [{"email": "thecloudteacher@gmail.com"}]}],"from": {"email": "tsrana@gmail.com"},"subject":"Hello, World!","content": [{"type": "text/html","value": "Hey,<br>Please find attachment."}], "attachments": [{"content": "BASE64_ENCODED_CONTENT", "type": "text/plain", "filename": "config.properties"}]}'