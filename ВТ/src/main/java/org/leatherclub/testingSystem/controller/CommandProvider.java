package org.leatherclub.testingSystem.controller;

import org.leatherclub.testingSystem.controller.command.Command;
import org.leatherclub.testingSystem.controller.command.impl.*;

import java.util.HashMap;

final class CommandProvider {
    private final HashMap<CommandName, Command> repository = new HashMap<>();

    CommandProvider() {
        repository.put(CommandName.GO_TO_SIGNUP, new GoToSignUpPageCommand());
        repository.put(CommandName.WRONG_REQUEST, new WrongRequestCommand());
        repository.put(CommandName.SIGNUP, new SignUpCommand());
        repository.put(CommandName.GO_TO_MAIN, new GoToMainCommand());
        repository.put(CommandName.SIGNIN, new SignInCommand());
        repository.put(CommandName.SIGNOUT, new SignOutCommand());
        repository.put(CommandName.GO_TO_ADD, new GoToAddCommand());
        repository.put(CommandName.ADDENTITY, new AddEntityCommand());
        repository.put(CommandName.DELETE, new DeleteCommand());
        repository.put(CommandName.GO_TO_EDIT, new GoToEditCommand());
        repository.put(CommandName.EDITENTITY, new EditEntityCommand());
        repository.put(CommandName.GO_TO_TESTS, new GoToTestsCommand());
        repository.put(CommandName.GO_TO_QUESTIONS, new GoToQuestionsCommand());
        repository.put(CommandName.NEXT_QUESTION, new NextQuestion());
    }

    Command getCommand(String name) {
        CommandName commandName = null;
        Command command = null;

        try {
            commandName = CommandName.valueOf(name.toUpperCase());
            command = repository.get(commandName);
        }
        catch (IllegalArgumentException | NullPointerException e) {
            //log
            command = repository.get(CommandName.WRONG_REQUEST);
        }
        return  command;
    }
}
