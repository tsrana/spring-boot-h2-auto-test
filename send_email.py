import os
import base64

from sendgrid import SendGridAPIClient
from sendgrid.helpers.mail import (Mail, Attachment, FileContent, FileName, FileType, Disposition)

print(os.environ.get('subject'))
print(os.environ.get('body'))

message = Mail(
    from_email='tsrana@gmail.com',
    to_emails='thecloudteacher@gmail.com',
    subject=os.environ.get('subject'),
    html_content=os.environ.get('body')
)

with open('emailable-report.html', 'rb') as f:
    data = f.read()
    f.close()
encoded_file = base64.b64encode(data).decode()

attachedFile = Attachment(
    FileContent(encoded_file),
    FileName('emailable-report.html'),
    FileType('text/html'),
    Disposition('attachment')
)
message.attachment = attachedFile

sg = SendGridAPIClient(os.environ.get('SENDGRID_API_KEY'))
response = sg.send(message)
print(response.status_code, response.body, response.headers)
