package util;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class Gmail extends Authenticator {
    private PasswordAuthentication passwordAuthentication;

    public Gmail() {
        // Gmail Account Information setting
        String email = "your_email@gmail.com";
        String password = "your_password";
        passwordAuthentication = new PasswordAuthentication(email, password);
    }

    @Override
    protected PasswordAuthentication getPasswordAuthentication() {
        return passwordAuthentication;
    }
}