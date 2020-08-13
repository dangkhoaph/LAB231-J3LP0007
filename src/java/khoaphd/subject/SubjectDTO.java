package khoaphd.subject;

import java.io.Serializable;

/**
 *
 * @author KhoaPHD
 */
public class SubjectDTO implements Serializable {
    
    private int subjectId;
    private String code;
    private String name;
    private int numberOfQuestion;
    private int duration;

    public SubjectDTO() {
    }

    public SubjectDTO(int subjectId, String code, String name, int numberOfQuestion, int duration) {
        this.subjectId = subjectId;
        this.code = code;
        this.name = name;
        this.numberOfQuestion = numberOfQuestion;
        this.duration = duration;
    }
    
    public int getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(int subjectId) {
        this.subjectId = subjectId;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getNumberOfQuestion() {
        return numberOfQuestion;
    }

    public void setNumberOfQuestion(int numberOfQuestion) {
        this.numberOfQuestion = numberOfQuestion;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }
}