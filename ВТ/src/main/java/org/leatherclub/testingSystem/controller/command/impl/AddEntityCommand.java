package org.leatherclub.testingSystem.controller.command.impl;

import org.leatherclub.testingSystem.controller.command.Command;
import org.leatherclub.testingSystem.service.AnswerService;
import org.leatherclub.testingSystem.service.QuestionService;
import org.leatherclub.testingSystem.service.SubjectService;
import org.leatherclub.testingSystem.service.TestService;
import org.leatherclub.testingSystem.service.exception.ServiceException;
import org.leatherclub.testingSystem.service.factory.ServiceFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AddEntityCommand implements Command {

    private static final String REQUEST_PARAM_NAME = "name";
    private static final String REQUEST_PARAM_ENTITY = "entity";
    private static final String REQUEST_PARAM_ID = "id";
    private static final String REQUEST_PARAM_ISRIGHT = "isRight";

    private static final String ENTITY_SUBJECT = "subject";
    private static final String ENTITY_TEST = "test";
    private static final String ENTITY_QUESTION = "question";
    private static final String ENTITY_ANSWER = "answer";
    private static final String REDIRECT_COMMAND_SUCCESS_SUBJECT = "Controller?command=go_to_main";
    private static final String REDIRECT_COMMAND_ERROR_SUBJECT = "Controller?command=go_to_main&error=subject";
    private static final String REDIRECT_COMMAND_SUCCESS_TEST = "Controller?command=go_to_tests";
    private static final String REDIRECT_COMMAND_ERROR_TEST = "Controller?command=go_to_tests&error=test";
    private static final String REDIRECT_COMMAND_SUCCESS_QUESTION = "Controller?command=go_to_questions";
    private static final String REDIRECT_COMMAND_ERROR_QUESTION = "Controller?command=go_to_questions&error=question";

    private static final String REDIRECT_COMMAND_ERROR = "Controller?command=go_to_main&error=error";

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {

        String name = req.getParameter(REQUEST_PARAM_NAME);
        String entity = req.getParameter(REQUEST_PARAM_ENTITY);

        ServiceFactory serviceFactory = ServiceFactory.getInstance();
        Boolean result;

        switch (entity) {
            case ENTITY_SUBJECT:
                SubjectService subjectService = serviceFactory.getSubjectService();
                try {
                    result = subjectService.addSubject(name);
                    if(result)
                        resp.sendRedirect(REDIRECT_COMMAND_SUCCESS_SUBJECT);
                    else resp.sendRedirect(REDIRECT_COMMAND_ERROR_SUBJECT);
                }
                catch (ServiceException e) {
                    resp.sendRedirect(REDIRECT_COMMAND_ERROR_SUBJECT);
                }
                break;

            case ENTITY_TEST:
                TestService testService = serviceFactory.getTestService();
                int subjectId = Integer.parseInt(req.getParameter(REQUEST_PARAM_ID));
                try {
                    result = testService.addTest(subjectId, name);
                    if(result)
                        resp.sendRedirect(REDIRECT_COMMAND_SUCCESS_TEST );
                    else
                        resp.sendRedirect(REDIRECT_COMMAND_ERROR_TEST);
                }
                catch (ServiceException e) {
                    resp.sendRedirect(REDIRECT_COMMAND_ERROR_TEST);
                }
                break;

            case ENTITY_QUESTION:
                QuestionService questionService = serviceFactory.getQuestionService();
                int testId = Integer.parseInt(req.getParameter(REQUEST_PARAM_ID));
                try {
                    result = questionService.addQuestion(testId, name);
                    if(result)
                        resp.sendRedirect(REDIRECT_COMMAND_SUCCESS_QUESTION);
                    else
                        resp.sendRedirect(REDIRECT_COMMAND_ERROR_QUESTION);
                }
                catch (ServiceException e) {
                    resp.sendRedirect(REDIRECT_COMMAND_ERROR_QUESTION);
                }
                break;

            case ENTITY_ANSWER:
                AnswerService answerService = serviceFactory.getAnswerService();
                int questionId = Integer.parseInt(req.getParameter(REQUEST_PARAM_ID));
                boolean isRight = req.getParameter(REQUEST_PARAM_ISRIGHT) != null;
                try {
                    result = answerService.addAnswer(questionId, name, isRight);
                    if(result)
                        resp.sendRedirect(REDIRECT_COMMAND_SUCCESS_QUESTION);
                    else
                        resp.sendRedirect(REDIRECT_COMMAND_ERROR_QUESTION);
                }
                catch (ServiceException e) {
                    resp.sendRedirect(REDIRECT_COMMAND_ERROR_QUESTION);
                }
                break;

            default:
                resp.sendRedirect(REDIRECT_COMMAND_ERROR);
        }
    }
}
