package user;

// Data Transfer Object (DTO) class for the User entity
public class UserDTO {
	
    // Fields representing user properties
    private String userID; // Unique ID for the user
    private String userPassword; // Password for the user's account
    private String userEmail; // Email address of the user
    private String userEmailHash; // Hash value of the user's email (used for verification)
    private boolean userEmailChecked; // Status indicating whether the email is verified

    // Getter and setter for userID
    public String getUserID() {
        return userID;
    }
    public void setUserID(String userID) {
        this.userID = userID;
    }

    // Getter and setter for userPassword
    public String getUserPassword() {
        return userPassword;
    }
    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

    // Getter and setter for userEmail
    public String getUserEmail() {
        return userEmail;
    }
    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    // Getter and setter for userEmailHash
    public String getUserEmailHash() {
        return userEmailHash;
    }
    public void setUserEmailHash(String userEmailHash) {
        this.userEmailHash = userEmailHash;
    }

    // Getter and setter for userEmailChecked
    public boolean isUserEmailChecked() {
        return userEmailChecked;
    }
    public void setUserEmailChecked(boolean userEmailChecked) {
        this.userEmailChecked = userEmailChecked;
    }

    // Default constructor
    public UserDTO() {
        // Empty constructor for cases where fields are set individually
    }

    // Parameterized constructor
    public UserDTO(String userID, String userPassword, String userEmail, String userEmailHash,
            boolean userEmailChecked) {
        super(); // Call to the parent class constructor (optional)
        this.userID = userID;
        this.userPassword = userPassword;
        this.userEmail = userEmail;
        this.userEmailHash = userEmailHash;
        this.userEmailChecked = userEmailChecked;
    }
}