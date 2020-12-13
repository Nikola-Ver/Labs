package org.leatherclub.testingSystem.service.impl;

import org.leatherclub.testingSystem.bean.Subject;
import org.leatherclub.testingSystem.dao.SubjectDAO;
import org.leatherclub.testingSystem.dao.exception.DAOException;
import org.leatherclub.testingSystem.dao.factory.DAOFactory;
import org.leatherclub.testingSystem.service.SubjectService;
import org.leatherclub.testingSystem.service.exception.ServiceException;

import java.util.List;

public class SubjectServiceImpl implements SubjectService {

    @Override
    public List<Subject> getSubjects() throws ServiceException {

        DAOFactory daoFactory = DAOFactory.getInstance();
        SubjectDAO subjectDAO = daoFactory.getSubjectDao();

        try {
            return subjectDAO.getSubjects();
        }
        catch (DAOException e) {
            throw new ServiceException("Error while getting subjects", e);
        }
    }

    @Override
    public boolean addSubject(String name) throws ServiceException {

        if(name.equals(""))
            return false;

        DAOFactory daoFactory = DAOFactory.getInstance();
        SubjectDAO subjectDAO = daoFactory.getSubjectDao();

        try {
            subjectDAO.addSubject(name);
        }
        catch (DAOException e) {
            throw new ServiceException("Error while adding subject", e);
        }
        return true;
    }

    @Override
    public boolean editSubject(int id, String name) throws ServiceException {

        if(name.equals("") || id == 0)
            return false;

        DAOFactory daoFactory = DAOFactory.getInstance();
        SubjectDAO subjectDAO = daoFactory.getSubjectDao();

        try {
            subjectDAO.editSubject(id, name);
        }
        catch (DAOException e) {
            throw new ServiceException("Error while editing subject", e);
        }
        return true;
    }

    @Override
    public boolean deleteSubject(int id) throws ServiceException {

        if(id == 0)
            return false;

        DAOFactory daoFactory = DAOFactory.getInstance();
        SubjectDAO subjectDAO = daoFactory.getSubjectDao();

        try {
            subjectDAO.deleteSubject(id);
        }
        catch (DAOException e) {
            throw new ServiceException("Error while deleting subject", e);
        }
        return true;
    }
}
