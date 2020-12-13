package org.leatherclub.testingSystem.service;

import org.leatherclub.testingSystem.bean.Answer;
import org.leatherclub.testingSystem.service.exception.ServiceException;

import java.util.List;

public interface AnswerService {
    List<Answer> getAnswers(int questionId) throws ServiceException;
    boolean addAnswer(int questionId, String answer, boolean isRight) throws ServiceException;
    boolean editAnswer(int answerId, String answer, boolean isRight) throws ServiceException;
    boolean deleteAnswer(int answerId) throws ServiceException;
}
