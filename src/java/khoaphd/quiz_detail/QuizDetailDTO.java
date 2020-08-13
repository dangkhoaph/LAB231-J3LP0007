package khoaphd.quiz_detail;

import java.io.Serializable;

/**
 *
 * @author KhoaPHD
 */
public class QuizDetailDTO implements Serializable {
    
    private int quizDetailId;
    private int quizId;
    private int questionId;
    private String answer;

    public QuizDetailDTO() {
    }

    public QuizDetailDTO(int quizId, int questionId, String answer) {
        this.quizId = quizId;
        this.questionId = questionId;
        this.answer = answer;
    }

    public int getQuizDetailId() {
        return quizDetailId;
    }

    public void setQuizDetailId(int quizDetailId) {
        this.quizDetailId = quizDetailId;
    }

    public int getQuizId() {
        return quizId;
    }

    public void setQuizId(int quizId) {
        this.quizId = quizId;
    }

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }
}