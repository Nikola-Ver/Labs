package org.leatherclub.testingSystem.dao;

import org.leatherclub.testingSystem.bean.User;
import org.leatherclub.testingSystem.dao.exception.DAOException;

public interface UserDAO {
    User signIn(String login, byte[] password) throws DAOException;
    void signUp(String login, byte[] password, String name, String lastname, String email, int roleId) throws DAOException;
}
