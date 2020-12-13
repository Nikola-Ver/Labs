package org.leatherclub.testingSystem.controller.command.impl;

import org.leatherclub.testingSystem.bean.Answer;
import org.leatherclub.testingSystem.bean.Question;
import org.leatherclub.testingSystem.bean.User;
import org.leatherclub.testingSystem.controller.command.Command;
import org.leatherclub.testingSystem.service.QuestionService;
import org.leatherclub.testingSystem.service.exception.ServiceException;
import org.leatherclub.testingSystem.service.factory.ServiceFactory;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class NextQuestion implements Command {

    private static final String NEXT_PAGE_URI = "WEB-INF/jsp/test.jsp";
    private static final String FINISH_TEST_PAGE_URI = "WEB-INF/jsp/finishTest.jsp";

    private static final String REQUEST_PARAM_RADIO = "answer";
    private static final String REQUEST_PARAM_FINISH = "finishTest";
    private static final String QUESTIONS_SESSION_ATTR = "questions";
    private static final String RIGHT_ANSWERS_SESSION_ATTR = "rightAnswers";
    private static final String CURRENT_QUESTION_SESSION_ATTR = "currQuestion";

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        HttpSession session = req.getSession(true);


        Question currQuestion = ((List<Question>)session.getAttribute(QUESTIONS_SESSION_ATTR)).
                get(((Integer)session.getAttribute(CURRENT_QUESTION_SESSION_ATTR)));

        if(currQuestion.getRightAnswers() == 1) {
            int answerId = Integer.parseInt(req.getParameter(REQUEST_PARAM_RADIO));
            int rightAnswerId = 0;

            for(Answer answer : currQuestion.getAnswers())
                if(answer.getRight()) {
                    rightAnswerId = answer.getAnswerId();
                    break;
                }

            if(answerId == rightAnswerId)
                session.setAttribute(RIGHT_ANSWERS_SESSION_ATTR, (Integer)session.getAttribute(RIGHT_ANSWERS_SESSION_ATTR) + 1);
        }
        else {
            int rightAnswers = 0;

            for (Answer answer : currQuestion.getAnswers()) {
                if(req.getParameter(String.valueOf(answer.getAnswerId())) != null)
                    if(answer.getRight())
                        rightAnswers++;
                    else {
                        rightAnswers = 0;
                        break;
                    }
            }

            if(rightAnswers == currQuestion.getRightAnswers())
                session.setAttribute(RIGHT_ANSWERS_SESSION_ATTR, (Integer)session.getAttribute(RIGHT_ANSWERS_SESSION_ATTR) + 1);
        }


        if(req.getParameter(REQUEST_PARAM_FINISH) != null) {
            RequestDispatcher requestDispatcher = req.getRequestDispatcher(FINISH_TEST_PAGE_URI);
            requestDispatcher.forward(req, resp);
        }
        else {
            session.setAttribute(CURRENT_QUESTION_SESSION_ATTR, (Integer)session.getAttribute(CURRENT_QUESTION_SESSION_ATTR) + 1);
            RequestDispatcher requestDispatcher = req.getRequestDispatcher(NEXT_PAGE_URI);
            requestDispatcher.forward(req, resp);
        }
    }
}
