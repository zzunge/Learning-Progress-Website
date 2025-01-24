package util;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

// Class for Gmail authentication using javax.mail
public class Gmail extends Authenticator {

    // Field to hold the password authentication information
    private PasswordAuthentication passwordAuthentication;

    // Constructor to initialize the Gmail account credentials
    public Gmail() {
        // Set the Gmail account credentials
        String email = "your_email@gmail.com"; // Replace with your Gmail address
        String password = "your_password"; // Replace with your Gmail app password
        
        // Initialize the PasswordAuthentication object with the credentials
        passwordAuthentication = new PasswordAuthentication(email, password);
    }

    // Override the getPasswordAuthentication method to return the credentials
    @Override
    protected PasswordAuthentication getPasswordAuthentication() {
        return passwordAuthentication; // Return the stored password authentication object
    }
}