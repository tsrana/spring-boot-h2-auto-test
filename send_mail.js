const sgMail = require('@sendgrid/mail');
sgMail.setApiKey(process.env.SENDGRID_API_KEY);

const fs = require("fs");

pathToAttachment = `emailable-report.html`;
attachment = fs.readFileSync(pathToAttachment).toString("base64");

const msg = {
  to: 'thecloudteacher@gmail.com',
  from: 'tsrana@gmail.com',
  subject: 'Sending with SendGrid is Fun',
  text: 'and easy to do anywhere, even with Node.js',
  attachments: [
    {
      content: attachment,
      filename: "emailable-report.html",
      type: "text/html",
      disposition: "attachment"
    }
  ]
};

sgMail.send(msg).catch(err => {
  console.log(err);
});
