package evaluation;

// Data Transfer Object (DTO) class for the Evaluation entity
public class EvaluationDTO {

    // Fields representing columns in the database table
    int evaluationID; // Unique ID for each evaluation
    String userID; // ID of the user who submitted the evaluation
    String lectureName; // Name of the lecture being evaluated
    String professorName; // Name of the professor for the lecture
    int lectureYear; // Year of the lecture
    String evaluationTitle; // Title of the evaluation
    String evaluationContent; // Content/details of the evaluation

    // Getter and setter for evaluationID
    public int getEvaluationID() {
        return evaluationID;
    }
    public void setEvaluationID(int evaluationID) {
        this.evaluationID = evaluationID;
    }

    // Getter and setter for userID
    public String getUserID() {
        return userID;
    }
    public void setUserID(String userID) {
        this.userID = userID;
    }

    // Getter and setter for lectureName
    public String getLectureName() {
        return lectureName;
    }
    public void setLectureName(String lectureName) {
        this.lectureName = lectureName;
    }

    // Getter and setter for professorName
    public String getProfessorName() {
        return professorName;
    }
    public void setProfessorName(String professorName) {
        this.professorName = professorName;
    }

    // Getter and setter for lectureYear
    public int getLectureYear() {
        return lectureYear;
    }
    public void setLectureYear(int lectureYear) {
        this.lectureYear = lectureYear;
    }

    // Getter and setter for evaluationTitle
    public String getEvaluationTitle() {
        return evaluationTitle;
    }
    public void setEvaluationTitle(String evaluationTitle) {
        this.evaluationTitle = evaluationTitle;
    }

    // Getter and setter for evaluationContent
    public String getEvaluationContent() {
        return evaluationContent;
    }
    public void setEvaluationContent(String evaluationContent) {
        this.evaluationContent = evaluationContent;
    }

    // Default constructor
    public EvaluationDTO() {
        // Empty constructor for cases where fields are set individually
    }

    // Parameterized constructor
    public EvaluationDTO(int evaluationID, String userID, String lectureName, String professorName, int lectureYear,
            String evaluationTitle, String evaluationContent) {
        // Initialize all fields using the provided parameters
        this.evaluationID = evaluationID;
        this.userID = userID;
        this.lectureName = lectureName;
        this.professorName = professorName;
        this.lectureYear = lectureYear;
        this.evaluationTitle = evaluationTitle;
        this.evaluationContent = evaluationContent;
    }
}