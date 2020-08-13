package khoaphd.question;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;
import khoaphd.answer.AnswerDTO;

/**
 *
 * @author KhoaPHD
 */
public class QuestionDTO implements Serializable {
    
    private int questionId;
    private String questionContent;
    private String correctAnswer;
    private Timestamp createDate;
    private int subjectId;
    private String subjectCode;
    private int statusId;
    private String status;
    private List<AnswerDTO> answerList;
    
    public QuestionDTO() {
    }

    public QuestionDTO(int questionId, String questionContent, String correctAnswer) {
        this.questionId = questionId;
        this.questionContent = questionContent;
        this.correctAnswer = correctAnswer;
    }
    
    public QuestionDTO(int questionId, String questionContent, String correctAnswer, int subjectId, int statusId) {
        this.questionId = questionId;
        this.questionContent = questionContent;
        this.correctAnswer = correctAnswer;
        this.subjectId = subjectId;
        this.statusId = statusId;
    }

    public QuestionDTO(int questionId, String questionContent, String correctAnswer, Timestamp createDate, String subjectCode, String status) {
        this.questionId = questionId;
        this.questionContent = questionContent;
        this.correctAnswer = correctAnswer;
        this.createDate = createDate;
        this.subjectCode = subjectCode;
        this.status = status;
    }

    public QuestionDTO(String questionContent, String correctAnswer, Timestamp createDate, int subjectId, int statusId) {
        this.questionContent = questionContent;
        this.correctAnswer = correctAnswer;
        this.createDate = createDate;
        this.subjectId = subjectId;
        this.statusId = statusId;
    }

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public String getQuestionContent() {
        return questionContent;
    }

    public void setQuestionContent(String questionContent) {
        this.questionContent = questionContent;
    }

    public String getCorrectAnswer() {
        return correctAnswer;
    }

    public void setCorrectAnswer(String correctAnswer) {
        this.correctAnswer = correctAnswer;
    }

    public Timestamp getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Timestamp createDate) {
        this.createDate = createDate;
    }

    public int getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(int subjectId) {
        this.subjectId = subjectId;
    }

    public String getSubjectCode() {
        return subjectCode;
    }

    public void setSubjectCode(String subjectCode) {
        this.subjectCode = subjectCode;
    }

    public int getStatusId() {
        return statusId;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List<AnswerDTO> getAnswerList() {
        return answerList;
    }

    public void setAnswerList(List<AnswerDTO> answerList) {
        this.answerList = answerList;
    }
}