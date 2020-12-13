package org.leatherclub.testingSystem.controller.command.impl;

import org.leatherclub.testingSystem.controller.command.Command;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class GoToSignUpPageCommand implements Command {

    private static final String SIGNUP_PAGE_URI = "WEB-INF/jsp/signUp.jsp";

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        RequestDispatcher dispatcher = req.getRequestDispatcher(SIGNUP_PAGE_URI);
        dispatcher.forward(req, resp);
    }
}
