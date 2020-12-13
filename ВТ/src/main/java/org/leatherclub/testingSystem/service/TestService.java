package org.leatherclub.testingSystem.service;

import org.leatherclub.testingSystem.bean.Test;
import org.leatherclub.testingSystem.service.exception.ServiceException;

import java.util.List;

public interface TestService {
    List<Test> getTests(int subjectId) throws ServiceException;
    boolean addTest(int subjectId, String title) throws ServiceException;
    boolean editTest(int testId, String title) throws ServiceException;
    boolean deleteTest(int testId) throws ServiceException;
}
