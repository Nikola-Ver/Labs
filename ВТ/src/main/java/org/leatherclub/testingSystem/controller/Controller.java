package org.leatherclub.testingSystem.controller;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.leatherclub.testingSystem.controller.command.Command;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class Controller extends HttpServlet {

    private static final String REQUEST_PARAM_COMMAND = "command";
    private static final String LAST_REQUEST_PARAM = "lastRequest";

    private final Logger logger;

    public Controller() {
        super();

        logger = Logger.getLogger(Controller.class);
        PropertyConfigurator.configure(Controller.class.getClassLoader().getResource("log4j.properties"));
    }

    private final CommandProvider provider = new CommandProvider();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processGetRequest(req, resp);
        return;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processPostRequest(req, resp);
        return;
    }

    private void processGetRequest(HttpServletRequest req, HttpServletResponse resp) throws  ServletException, IOException {
        String commandName;
        Command executionCommand;

        commandName = req.getParameter(REQUEST_PARAM_COMMAND);

        executionCommand = provider.getCommand(commandName);
        try {
            executionCommand.execute(req, resp);
        }
        catch (Exception e) {
            logger.debug(e);
        }


        req.getSession(true).setAttribute(LAST_REQUEST_PARAM, req.getRequestURI() + "?" + req.getQueryString());
    }

    private void processPostRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String commandName;
        Command executionCommand;

        commandName = req.getParameter(REQUEST_PARAM_COMMAND);

        executionCommand = provider.getCommand(commandName);
        try {
            executionCommand.execute(req, resp);
        }
        catch (Exception e) {
            logger.debug(e);
        }

    }
}
