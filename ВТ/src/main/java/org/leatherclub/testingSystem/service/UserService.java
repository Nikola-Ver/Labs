package org.leatherclub.testingSystem.service;

import org.leatherclub.testingSystem.bean.User;
import org.leatherclub.testingSystem.service.exception.ServiceException;

public interface UserService {
        User signIn(String login, byte[] password) throws ServiceException;
        boolean signUp(String login, byte[] password, String name, String lastname, String email, int roleId) throws ServiceException;
}
