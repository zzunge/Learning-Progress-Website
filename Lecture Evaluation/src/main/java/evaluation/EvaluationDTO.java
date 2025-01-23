package evaluation;

public class EvaluationDTO {

	int evaluationID;
	String userID;
	String lectureName;
	String professorName;
	int lectureYear;
	String evaluationTitle;
	String evaluationContent;
	public int getEvaluationID() {
		return evaluationID;
	}
	public void setEvaluationID(int evaluationID) {
		this.evaluationID = evaluationID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getLectureName() {
		return lectureName;
	}
	public void setLectureName(String lectureName) {
		this.lectureName = lectureName;
	}
	public String getProfessorName() {
		return professorName;
	}
	public void setProfessorName(String professorName) {
		this.professorName = professorName;
	}
	public int getLectureYear() {
		return lectureYear;
	}
	public void setLectureYear(int lectureYear) {
		this.lectureYear = lectureYear;
	}
	public String getEvaluationTitle() {
		return evaluationTitle;
	}
	public void setEvaluationTitle(String evaluationTitle) {
		this.evaluationTitle = evaluationTitle;
	}
	public String getEvaluationContent() {
		return evaluationContent;
	}
	public void setEvaluationContent(String evaluationContent) {
		this.evaluationContent = evaluationContent;
	}
	
	public EvaluationDTO() {
		
	}
	
	public EvaluationDTO(int evaluationID, String userID, String lectureName, String professorName, int lectureYear,
			String evaluationTitle, String evaluationContent) {
		this.evaluationID = evaluationID;
		this.userID = userID;
		this.lectureName = lectureName;
		this.professorName = professorName;
		this.lectureYear = lectureYear;
		this.evaluationTitle = evaluationTitle;
		this.evaluationContent = evaluationContent;
	}
	
	
}
