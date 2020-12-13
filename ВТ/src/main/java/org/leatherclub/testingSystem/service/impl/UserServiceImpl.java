package org.leatherclub.testingSystem.service.impl;

import org.leatherclub.testingSystem.bean.User;
import org.leatherclub.testingSystem.dao.UserDAO;
import org.leatherclub.testingSystem.dao.exception.DAOException;
import org.leatherclub.testingSystem.dao.exception.DAOUserAlreadyExistsException;
import org.leatherclub.testingSystem.dao.factory.DAOFactory;
import org.leatherclub.testingSystem.service.UserService;
import org.leatherclub.testingSystem.service.exception.ServiceException;
import org.leatherclub.testingSystem.service.exception.ServiceUserAlreadyExistsException;

public class UserServiceImpl implements UserService {
    @Override
    public User signIn(String login, byte[] password) throws ServiceException {

        if(login.equals("") || password.equals(""))
            return null;

        DAOFactory daoFactory = DAOFactory.getInstance();
        UserDAO userDAO = daoFactory.getUserDao();

        try {
            return userDAO.signIn(login, password);
        }
        catch (DAOException e) {
            throw new ServiceException("Error while signing in", e);
        }
    }

    @Override
    public boolean signUp(String login, byte[] password, String name, String lastname, String email, int roleId) throws ServiceException {

        if(login.equals("") || password.equals("") || name.equals("") || lastname.equals("") || email.equals(""))
            return false;

        DAOFactory daoFactory = DAOFactory.getInstance();
        UserDAO userDAO = daoFactory.getUserDao();

        try {
            userDAO.signUp(login, password, name, lastname, email, roleId);
        }
        catch (DAOUserAlreadyExistsException e) {
            throw new ServiceUserAlreadyExistsException("User with such login already exists", e);
        }
        catch (DAOException e) {
            throw new ServiceException("Error while singing up", e);
        }
        return true;
    }
}
