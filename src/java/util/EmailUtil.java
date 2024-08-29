package util;

import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.Email;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;

public class EmailUtil {

    public static void sendOverdueEmail(String userEmail, String username, String bookTitle, String returnDate, int fine) throws EmailException {
        System.out.println("Sending overdue email...");

        Email email = new SimpleEmail();
        email.setHostName("smtp.gmail.com");
        email.setSmtpPort(465);

        email.setAuthenticator(new DefaultAuthenticator("houserentoffice@gmail.com", "udxkiskkryaafzyn"));

        email.setSSLOnConnect(true);
        email.setStartTLSEnabled(true);
        email.setFrom("noreply@gmail.com");
        email.setSubject("Overdue Book Reminder");

        String messageText = "Dear " + username + ",<br><br>" +
                "This is a reminder that the book titled \"" + bookTitle + "\" you borrowed is overdue since " + returnDate + ".<br>" +
                "Please return it as soon as possible to avoid any penalties.<br>" +
                "A fine of " + fine + " RWF has been incurred.<br><br>" +
                "Thank you,<br>" +
                "Your Library";

        email.setMsg(messageText);
        email.addTo(userEmail);
        email.send();
    }
}
