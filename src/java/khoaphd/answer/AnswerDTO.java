package khoaphd.answer;

import java.io.Serializable;

/**
 *
 * @author KhoaPHD
 */
public class AnswerDTO implements Serializable {
    
    private int answerId;
    private String symbol;
    private String answerContent;
    private int questionId;

    public AnswerDTO() {
    }

    public AnswerDTO(int answerId, String symbol, String answerContent) {
        this.answerId = answerId;
        this.symbol = symbol;
        this.answerContent = answerContent;
    }

    public AnswerDTO(String symbol, String answerContent, int questionId) {
        this.symbol = symbol;
        this.answerContent = answerContent;
        this.questionId = questionId;
    }
    
    public int getAnswerId() {
        return answerId;
    }

    public void setAnswerId(int answerId) {
        this.answerId = answerId;
    }

    public String getSymbol() {
        return symbol;
    }

    public void setSymbol(String symbol) {
        this.symbol = symbol;
    }

    public String getAnswerContent() {
        return answerContent;
    }

    public void setAnswerContent(String answerContent) {
        this.answerContent = answerContent;
    }

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }
}