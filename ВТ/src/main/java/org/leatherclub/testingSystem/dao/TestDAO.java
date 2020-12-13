package org.leatherclub.testingSystem.dao;

import org.leatherclub.testingSystem.bean.Test;
import org.leatherclub.testingSystem.dao.exception.DAOException;

import java.util.List;

public interface TestDAO {
    List<Test> getTests(int subjectId) throws DAOException;
    void addTest(int subjectId, String title) throws DAOException;
    void editTest(int testId, String title) throws DAOException;
    void deleteTest(int testId) throws DAOException;
}
