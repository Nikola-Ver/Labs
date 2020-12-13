package org.leatherclub.testingSystem.dao;

import org.leatherclub.testingSystem.bean.Question;
import org.leatherclub.testingSystem.dao.exception.DAOException;

import java.util.List;

public interface QuestionDAO {
    List<Question> getQuestions(int testId) throws DAOException;
    void addQuestion(int testId, String question) throws DAOException;
    void editQuestion(int questionId, String question) throws DAOException;
    void deleteQuestion(int questionId) throws DAOException;
}
