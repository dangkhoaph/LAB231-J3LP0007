package khoaphd.quiz;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 *
 * @author KhoaPHD
 */
public class QuizDTO implements Serializable {
    
    private int quizId;
    private Timestamp createDate;
    private double score;
    private int subjectId;
    private String email;

    public QuizDTO() {
    }

    public QuizDTO(Timestamp createDate, double score, int subjectId, String email) {
        this.createDate = createDate;
        this.score = score;
        this.subjectId = subjectId;
        this.email = email;
    }

    public int getQuizId() {
        return quizId;
    }

    public void setQuizId(int quizId) {
        this.quizId = quizId;
    }

    public Timestamp getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Timestamp createDate) {
        this.createDate = createDate;
    }

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }

    public int getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(int subjectId) {
        this.subjectId = subjectId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}