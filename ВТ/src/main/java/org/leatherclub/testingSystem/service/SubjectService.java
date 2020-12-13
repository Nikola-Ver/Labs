package org.leatherclub.testingSystem.service;

import org.leatherclub.testingSystem.bean.Subject;
import org.leatherclub.testingSystem.service.exception.ServiceException;

import java.util.List;

public interface SubjectService {
    List<Subject> getSubjects() throws ServiceException;
    boolean addSubject(String name) throws ServiceException;
    boolean editSubject(int id, String name) throws ServiceException;
    boolean deleteSubject(int id) throws ServiceException;
}
