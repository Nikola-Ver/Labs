package org.leatherclub.testingSystem.controller.command.impl;

import org.leatherclub.testingSystem.controller.command.Command;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class SignOutCommand implements Command {

    private static final String REDIRECT_COMMAND_LOGOUT = "Controller?command=go_to_main";
    private static final String USER_SESSION_ATTR = "user";
    private static final String SUBJECTS_SESSION_ATTR = "subjects";
    private static final String TESTS_SESSION_ATTR = "tests";

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        HttpSession session = req.getSession(true);
        session.removeAttribute(USER_SESSION_ATTR);
        session.removeAttribute(SUBJECTS_SESSION_ATTR);
        session.removeAttribute(TESTS_SESSION_ATTR);
        resp.sendRedirect(REDIRECT_COMMAND_LOGOUT);
    }
}
