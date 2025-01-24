package util;

import java.security.MessageDigest;

// Utility class for hashing strings using SHA-256
public class SHA256 {

    // Static method to compute the SHA-256 hash of an input string
    public static String getSHA256(String input) {
        StringBuffer result = new StringBuffer(); // StringBuffer to store the hash result
        try {
            // Get a MessageDigest instance for SHA-256
            MessageDigest digest = MessageDigest.getInstance("SHA-256");

            // Define a salt value to add additional security to the hash
            byte[] salt = "Hello! This is Salt.".getBytes(); // Salt value
            digest.reset(); // Reset the digest to its initial state
            digest.update(salt); // Add the salt to the digest

            // Compute the hash of the input string
            byte[] chars = digest.digest(input.getBytes("UTF-8")); // Hash the input with UTF-8 encoding

            // Convert the byte array into a hexadecimal string
            for (int i = 0; i < chars.length; i++) {
                String hex = Integer.toHexString(0xff & chars[i]); // Convert each byte to hex
                if (hex.length() == 1) result.append("0"); // Add a leading zero for single-digit hex values
                result.append(hex); // Append the hex value to the result
            }

        } catch (Exception e) {
            e.printStackTrace(); // Print stack trace for debugging if an exception occurs
        }
        return result.toString(); // Return the resulting hash as a string
    }
}