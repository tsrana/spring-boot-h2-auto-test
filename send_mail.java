import com.sendgrid.*;
import java.io.IOException;
//import org.apache.commons.codec.binary.Base64;
import org.apache.commons.io.FileUtils;
import java.io.File;
import java.util.Base64;

public class send_mail {
  public static void main(String[] args) throws IOException {
    Email from = new Email("tsrana@gmail.com");
    Email to = new Email("thecloudteacher@gmail.com");
    String subject = System.getenv("subject");
    Content content = new Content("text/html", System.getenv("body"));
    
    System.out.println("subject - "+subject);
    System.out.println("content - "+content.toString());
    
    Mail mail = new Mail(from, subject, to, content);
	
	Attachments attachments3 = new Attachments();
	
	byte[] fileContent = FileUtils.readFileToByteArray(new File("emailable-report.html"));
	String encodedString = Base64.getEncoder().encodeToString(fileContent);
	
	attachments3.setContent(encodedString);
	attachments3.setType("text/html");
	attachments3.setFilename("emailable-report.html");
	attachments3.setDisposition("attachment");
	attachments3.setContentId("Banner");
	mail.addAttachments(attachments3);

    SendGrid sg = new SendGrid(System.getenv("SENDGRID_API_KEY"));
	Request request = new Request();
    try {
      request.setMethod(Method.POST);
      request.setEndpoint("mail/send");
      request.setBody(mail.build());
      Response response = sg.api(request);
      System.out.println(response.getStatusCode());
      System.out.println(response.getBody());
      System.out.println(response.getHeaders());
	  
	  
    } catch (IOException ex) {
      throw ex;
    }
  }
}