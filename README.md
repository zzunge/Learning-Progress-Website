# Learning-Progress-Website
## Project Overview

This project is a web application designed for Japanese learners studying Korean. It allows users to log in, track, and manage their learning progress efficiently. The platform provides a bulletin board feature for progress tracking and plans to include additional features like schedule management and resource sharing in the future.

## Key Features

- **User Authentication System**: Secure login system for personalized accounts.
- **Learning Progress Bulletin Board**: A centralized space for users to log and track their learning activities.
- **Responsive Design**: The interface is optimized for use across different devices.
- **Future Enhancements**:
  - Resource Sharing
  - Submission and Feedback System for Assignments
 
## Technology Stack

- **Frontend**: 
  - HTML, CSS, JavaScript: For building a responsive and dynamic user interface.
  
- **Backend**:
  - Eclipse and Tomcat: For handling server-side logic.
  - MySQL: For data storage and management of user accounts and learning progress data.

### **Prerequisites**
Before running the application, make sure you have the following installed:

- **Java JDK** (Version 8 or later)
- **Apache Tomcat** (Version 9 or later)
- **MySQL Database** (Version 5.7 or later)
- **Eclipse IDE** (or any preferred Java EE-supported IDE)
- **JDBC Connector for MySQL** (for database connectivity)
- **Git** (if cloning from a repository)

---
### **1. Clone the Repository**
If you haven't already, clone the project using Git:
```sh
git clone https://github.com/your-repository/Learning-Progress-Website.git
cd Learning-Progress-Website
```

---

### **2. Set Up the Database**
1. Open **MySQL Workbench** or use the MySQL command line.
2. Create a new database:
   ```sql
   CREATE DATABASE LectureEvaluation;
   ```
3. Use the database:
   ```sql
   USE LectureEvaluation;
   ```
4. If no SQL file is available, manually create the necessary tables:
   ```sql
   CREATE TABLE USER (
       id INT AUTO_INCREMENT PRIMARY KEY,
       userID VARCHAR(50) UNIQUE NOT NULL,
       userPassword VARCHAR(255) NOT NULL,
       userEmail VARCHAR(100) UNIQUE NOT NULL
   );

   CREATE TABLE EVALUATION (
       id INT AUTO_INCREMENT PRIMARY KEY,
       userID VARCHAR(50) NOT NULL,
       lectureName VARCHAR(100) NOT NULL,
       professorName VARCHAR(100) NOT NULL,
       lectureYear INT NOT NULL,
       evaluationTitle VARCHAR(255) NOT NULL,
       evaluationContent TEXT NOT NULL
   );
   ```
---

### **3. Configure the Project in Eclipse**
1. Open **Eclipse** and select **File → Import → Existing Projects into Workspace**.
2. Browse to the **Lecture Evaluation** project folder and import it.
3. Configure **Apache Tomcat**:
   - Go to **Window → Preferences → Server → Runtime Environments**.
   - Click **Add**, select **Apache Tomcat**, and provide the installation path.
   - Set up a new **Tomcat Server** from **Servers tab**.

---
### **4. Configure Database Connection**
1. Open the `DatabaseUtil.java` file.
2. Modify the database connection details:
   ```java
   private static final String DB_URL = "jdbc:mysql://localhost:3306/LectureEvaluation";
   private static final String DB_USER = "root"; 
   private static final String DB_PASSWORD = "gPwjd@99"; 
   ```
3. Ensure the **JDBC Driver** is included in the project's `lib` folder.

---
### **5. Run the Project**
1. In Eclipse, right-click on **Tomcat Server** in the **Servers** tab and click **Start**.
2. Right-click on the project and select **Run on Server**.
3. Open your browser and go to:
   ```
   http://localhost:8082/Learning-Progress-Website/
   ```
4. The login page should appear. You can now register, log in, and use the bulletin board.

---
### **6. Testing the Application**
- Use sample credentials :
  ```
  userID: 123
  password: 1234
  ```
- Try posting an evaluation and verify database updates.
- Run all test cases to check functionality.

---
### **Troubleshooting**
| Issue | Solution |
|-------|----------|
| Cannot connect to MySQL | Ensure MySQL is running and credentials are correct |
| Tomcat startup issues | Check port conflicts or logs for errors |
| Database table missing | Recreate tables using the schema provided |
| Page not loading correctly | Clear browser cache or restart the server |

---
