package org.leatherclub.testingSystem.controller.command.impl;

import org.leatherclub.testingSystem.controller.command.Command;
import org.leatherclub.testingSystem.service.UserService;
import org.leatherclub.testingSystem.service.exception.ServiceException;
import org.leatherclub.testingSystem.service.exception.ServiceUserAlreadyExistsException;
import org.leatherclub.testingSystem.service.factory.ServiceFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class SignUpCommand implements Command {

    private static final String REQUEST_PARAM_LOGIN = "login";
    private static final String REQUEST_PARAM_EMAIL = "email";
    private static final String REQUEST_PARAM_NAME = "name";
    private static final String REQUEST_PARAM_LASTNAME = "lastname";
    private static final String REQUEST_PARAM_PASSWORD = "password";
    private static final String REDIRECT_COMMAND_SUCCESS = "Controller?command=go_to_main&register=success";
    private static final String REDIRECT_COMMAND_ERROR = "Controller?command=go_to_signup&error=error";
    private static final String REDIRECT_COMMAND_ERROR_DUPLICATE = "Controller?command=go_to_signup&error=unique";
    private static final int DEFAULT_ROLE_ID = 2;

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {

        String login = req.getParameter(REQUEST_PARAM_LOGIN);
        String email = req.getParameter(REQUEST_PARAM_EMAIL);
        String name = req.getParameter(REQUEST_PARAM_NAME);
        String lastname = req.getParameter(REQUEST_PARAM_LASTNAME);
        String password = req.getParameter(REQUEST_PARAM_PASSWORD);
        int roleId = DEFAULT_ROLE_ID;

        ServiceFactory serviceFactory = ServiceFactory.getInstance();
        UserService userService = serviceFactory.getUserService();

        Boolean registrationResult;

        try {
            registrationResult = userService.signUp(login, password.getBytes(), name, lastname, email, roleId);

            if(registrationResult)
                resp.sendRedirect(REDIRECT_COMMAND_SUCCESS);
            else
                resp.sendRedirect(REDIRECT_COMMAND_ERROR);
        }
        catch (ServiceUserAlreadyExistsException e) {
            resp.sendRedirect(REDIRECT_COMMAND_ERROR_DUPLICATE);
        }
        catch (ServiceException e) {
            resp.sendRedirect(REDIRECT_COMMAND_ERROR);
        }
    }
}
