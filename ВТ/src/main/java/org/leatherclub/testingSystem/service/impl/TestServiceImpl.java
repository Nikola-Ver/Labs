package org.leatherclub.testingSystem.service.impl;

import org.leatherclub.testingSystem.bean.Test;
import org.leatherclub.testingSystem.dao.SubjectDAO;
import org.leatherclub.testingSystem.dao.TestDAO;
import org.leatherclub.testingSystem.dao.exception.DAOException;
import org.leatherclub.testingSystem.dao.factory.DAOFactory;
import org.leatherclub.testingSystem.service.TestService;
import org.leatherclub.testingSystem.service.exception.ServiceException;

import java.util.List;

public class TestServiceImpl implements TestService {
    @Override
    public List<Test> getTests(int subjectId) throws ServiceException {

        if(subjectId == 0)
            return null;

        DAOFactory daoFactory = DAOFactory.getInstance();
        TestDAO testDAO = daoFactory.getTestDao();

        try {
            return testDAO.getTests(subjectId);
        }
        catch (DAOException e) {
            throw new ServiceException("Error while getting tests", e);
        }
    }

    @Override
    public boolean addTest(int subjectId, String title) throws ServiceException {

        if(title.equals("") || subjectId == 0)
            return false;

        DAOFactory daoFactory = DAOFactory.getInstance();
        TestDAO testDAO = daoFactory.getTestDao();

        try {
            testDAO.addTest(subjectId, title);
        }
        catch (DAOException e) {
            throw new ServiceException("Error while adding test", e);
        }
        return true;
    }

    @Override
    public boolean editTest(int testId, String title) throws ServiceException {

        if(title.equals("") || testId == 0)
            return false;

        DAOFactory daoFactory = DAOFactory.getInstance();
        TestDAO testDAO = daoFactory.getTestDao();

        try {
            testDAO.editTest(testId, title);
        }
        catch (DAOException e) {
            throw new ServiceException("Error while editing test", e);
        }
        return true;
    }

    @Override
    public boolean deleteTest(int testId) throws ServiceException {

        if(testId == 0)
            return false;

        DAOFactory daoFactory = DAOFactory.getInstance();
        TestDAO testDAO = daoFactory.getTestDao();

        try {
            testDAO.deleteTest(testId);
        }
        catch (DAOException e) {
            throw new ServiceException("Error while deleting test", e);
        }
        return true;
    }
}
