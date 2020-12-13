package org.leatherclub.testingSystem.bean;

import java.io.Serializable;
import java.util.List;
import java.util.Objects;

public class Question implements Serializable {
    private int questionId;
    private int testId;
    private String question;
    private int rightAnswers = 0;
    private List<Answer> answers;

    public Question(int questionId, int testId, String question, List<Answer> answers) {
        this.questionId = questionId;
        this.testId = testId;
        this.question = question;
        this.answers = answers;
        for (Answer answer : answers) {
            if(answer.getRight())
                rightAnswers++;
        }
    }

    public int getQuestionId() {
        return questionId;
    }

    public int getTestId() {
        return testId;
    }

    public String getQuestion() {
        return question;
    }

    public int getRightAnswers() {
        return rightAnswers;
    }

    public List<Answer> getAnswers() {
        return answers;
    }

    public void setAnswers(List<Answer> answers) {
        this.answers = answers;
        rightAnswers = 0;
        for (Answer answer : answers) {
            if(answer.getRight())
                rightAnswers++;
        }
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        Question that = (Question) obj;
        return Objects.equals(questionId, that.questionId) &&
                Objects.equals(testId, that.testId) &&
                Objects.equals(question, that.question) &&
                answers.equals(that.answers) &&
                Objects.equals(rightAnswers, that.rightAnswers);
    }

    @Override
    public int hashCode() {
        return Objects.hash(questionId, testId, question, answers, rightAnswers);
    }

    @Override
    public String toString() {
        return "Question{" +
                "questionId='" + questionId + '\'' +
                ", testId='" + testId + '\'' +
                ", question='" + question + '\'' +
                ", answers='" + answers + '\'' +
                ", rightAnswers='" + rightAnswers + '\'' +
                '}';
    }
}
