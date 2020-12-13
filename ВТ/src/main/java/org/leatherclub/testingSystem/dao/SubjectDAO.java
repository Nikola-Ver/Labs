package org.leatherclub.testingSystem.dao;

import org.leatherclub.testingSystem.bean.Subject;
import org.leatherclub.testingSystem.dao.exception.DAOException;

import java.util.List;

public interface SubjectDAO {
    List<Subject> getSubjects() throws DAOException;
    void addSubject(String name) throws DAOException;
    void editSubject(int id, String name) throws DAOException;
    void deleteSubject(int id) throws DAOException;
}
