package org.leatherclub.testingSystem.service.impl;

import org.leatherclub.testingSystem.bean.Answer;
import org.leatherclub.testingSystem.bean.Question;
import org.leatherclub.testingSystem.dao.AnswerDAO;
import org.leatherclub.testingSystem.dao.QuestionDAO;
import org.leatherclub.testingSystem.dao.exception.DAOException;
import org.leatherclub.testingSystem.dao.factory.DAOFactory;
import org.leatherclub.testingSystem.service.AnswerService;
import org.leatherclub.testingSystem.service.QuestionService;
import org.leatherclub.testingSystem.service.exception.ServiceException;
import org.leatherclub.testingSystem.service.factory.ServiceFactory;

import java.util.List;

public class QuestionServiceImpl implements QuestionService {
    @Override
    public List<Question> getQuestions(int testId) throws ServiceException {
        if(testId == 0)
            return null;

        DAOFactory daoFactory = DAOFactory.getInstance();
        QuestionDAO questionDAO = daoFactory.getQuestionDao();
        ServiceFactory serviceFactory = ServiceFactory.getInstance();
        AnswerService answerService = serviceFactory.getAnswerService();

        List<Question> questions;
        try {
            questions = questionDAO.getQuestions(testId);
            for(Question question : questions) {
                List<Answer> answers = answerService.getAnswers(question.getQuestionId());
                question.setAnswers(answers);
            }
            return questions;
        }
        catch (DAOException e) {
            throw new ServiceException("Error while getting questions", e);
        }
    }

    @Override
    public boolean addQuestion(int testId, String question) throws ServiceException {
        if(question.equals("") || testId == 0)
            return false;

        DAOFactory daoFactory = DAOFactory.getInstance();
        QuestionDAO questionDAO = daoFactory.getQuestionDao();

        try {
            questionDAO.addQuestion(testId, question);
        }
        catch (DAOException e) {
            throw new ServiceException("Error while adding question", e);
        }
        return true;
    }

    @Override
    public boolean editQuestion(int questionId, String question) throws ServiceException {
        if(question.equals("") || questionId == 0)
            return false;

        DAOFactory daoFactory = DAOFactory.getInstance();
        QuestionDAO questionDAO = daoFactory.getQuestionDao();

        try {
            questionDAO.editQuestion(questionId, question);
        }
        catch (DAOException e) {
            throw new ServiceException("Error while editing question", e);
        }
        return true;
    }

    @Override
    public boolean deleteQuestion(int questionId) throws ServiceException {
        if(questionId == 0)
            return false;

        DAOFactory daoFactory = DAOFactory.getInstance();
        QuestionDAO questionDAO = daoFactory.getQuestionDao();

        try {
            questionDAO.deleteQuestion(questionId);
        }
        catch (DAOException e) {
            throw new ServiceException("Error while deleting question", e);
        }
        return true;
    }
}
