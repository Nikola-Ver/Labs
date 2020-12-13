package org.leatherclub.testingSystem.controller.command.impl;

import org.leatherclub.testingSystem.bean.Subject;
import org.leatherclub.testingSystem.bean.Test;
import org.leatherclub.testingSystem.controller.command.Command;
import org.leatherclub.testingSystem.service.SubjectService;
import org.leatherclub.testingSystem.service.TestService;
import org.leatherclub.testingSystem.service.exception.ServiceException;
import org.leatherclub.testingSystem.service.factory.ServiceFactory;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class GoToTestsCommand implements Command {

    private static final String TESTS_PAGE_URI = "WEB-INF/jsp/tests.jsp";

    private static final String TESTS_SESSION_ATTR = "tests";
    private static final String REQUEST_PARAMETER_SUBJECTID = "subjectId";
    private static final String SUBJECTID_SESSION_ATTR = "subjectId";
    private static final String TESTID_SESSION_ATTR = "testId";
    private static final String NUMBER_OF_QUESTIONS_SESSION_ATTR = "numOfQuestions";
    private static final String RIGHT_ANSWERS_SESSION_ATTR = "rightAnswers";
    private static final String CURRENT_QUESTION_SESSION_ATTR = "currQuestion";

    private static final String REDIRECT_COMMAND_ERROR = "Controller?command=go_to_main&error=error";

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {


        HttpSession session = req.getSession(true);
        session.removeAttribute(TESTID_SESSION_ATTR);
        session.removeAttribute(NUMBER_OF_QUESTIONS_SESSION_ATTR);
        session.removeAttribute(RIGHT_ANSWERS_SESSION_ATTR);
        session.removeAttribute(CURRENT_QUESTION_SESSION_ATTR);


        ServiceFactory serviceFactory = ServiceFactory.getInstance();
        TestService testService = serviceFactory.getTestService();

        int subjectId;
        if(session.getAttribute(SUBJECTID_SESSION_ATTR) == null) {
            subjectId = Integer.parseInt(req.getParameter(REQUEST_PARAMETER_SUBJECTID));
            session.setAttribute(SUBJECTID_SESSION_ATTR, subjectId);
        }
        else
            subjectId = (int)session.getAttribute(SUBJECTID_SESSION_ATTR);

        List<Test> tests = null;
        try {
            tests = testService.getTests(subjectId);
        } catch (ServiceException e) {
            resp.sendRedirect(REDIRECT_COMMAND_ERROR);
        }
        session.setAttribute(TESTS_SESSION_ATTR, tests);

        RequestDispatcher requestDispatcher = req.getRequestDispatcher(TESTS_PAGE_URI);
        requestDispatcher.forward(req, resp);
    }
}
