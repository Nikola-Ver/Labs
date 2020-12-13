package org.leatherclub.testingSystem.service;

import org.leatherclub.testingSystem.bean.Question;
import org.leatherclub.testingSystem.service.exception.ServiceException;

import java.util.List;

public interface QuestionService {
    List<Question> getQuestions(int testId) throws ServiceException;
    boolean addQuestion(int testId, String question) throws ServiceException;
    boolean editQuestion(int questionId, String question) throws ServiceException;
    boolean deleteQuestion(int questionId) throws ServiceException;
}
