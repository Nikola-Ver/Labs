package org.leatherclub.testingSystem.dao.impl;

import org.leatherclub.testingSystem.bean.Subject;
import org.leatherclub.testingSystem.dao.SubjectDAO;
import org.leatherclub.testingSystem.dao.exception.DAOException;
import org.leatherclub.testingSystem.dao.impl.connection.ConnectionPool;
import org.leatherclub.testingSystem.dao.impl.connection.ConnectionPoolException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SubjectDAOImpl implements SubjectDAO {

    private static final String DB_COLUMN_NAME = "name";
    private static final String DB_COLUMN_ID = "id";

    private static final ConnectionPool connectionPool = ConnectionPool.getInstance();

    private static final String INSERT_SUBJECT_SQL = "INSERT testsdb.subjects(`name`) VALUES (?)";
    private static final String DELETE_SUBJECT_SQL = "DELETE FROM testsdb.subjects WHERE testsdb.subjects.id = ?";
    private static final String UPDATE_SUBJECT_SQL = "UPDATE testsdb.subjects SET testsdb.subjects.name = ? WHERE testsdb.subjects.id = ?";
    private static final String SELECT_SUBJECT_SQL = "SELECT * FROM testsdb.subjects";

    @Override
    public List<Subject> getSubjects() throws DAOException {
        PreparedStatement ps = null;
        Connection connection = null;
        ResultSet rs = null;

        try {
            connection = connectionPool.takeConnection();
            ps = connection.prepareStatement(SELECT_SUBJECT_SQL);

            rs = ps.executeQuery();
            if(rs == null)
                return null;

            List<Subject> subjects = new ArrayList<Subject>();
            while(rs.next()) {
                subjects.add(new Subject(rs.getInt(DB_COLUMN_ID), rs.getString(DB_COLUMN_NAME)));
            }
            ps.close();
            rs.close();
            return subjects;
        }
        catch (ConnectionPoolException e) {
            throw new DAOException("Error in connection pool while getting subjects", e);
        }
        catch (SQLException e) {
            throw new DAOException("Error while getting subjects", e);
        }
        finally {
            connectionPool.returnConnection(connection);
        }
    }

    @Override
    public void addSubject(String name) throws DAOException {
        PreparedStatement ps = null;
        Connection connection = null;

        try {
            connection = connectionPool.takeConnection();
            ps = connection.prepareStatement(INSERT_SUBJECT_SQL);
            ps.setString(1, name);

            ps.executeUpdate();
            ps.close();
        }
        catch (ConnectionPoolException e) {
            throw new DAOException("Error in connection pool while inserting subject", e);
        }
        catch (SQLException e) {
            throw new DAOException("Error while inserting subject", e);
        }
        finally {
            connectionPool.returnConnection(connection);
        }
    }

    @Override
    public void editSubject(int id, String name) throws DAOException {
        PreparedStatement ps = null;
        Connection connection = null;

        try {
            connection = connectionPool.takeConnection();
            ps = connection.prepareStatement(UPDATE_SUBJECT_SQL);
            ps.setString(1, name);
            ps.setInt(2, id);

            ps.executeUpdate();
            ps.close();
        }
        catch (ConnectionPoolException e) {
            throw new DAOException("Error in connection pool while updating subject", e);
        }
        catch (SQLException e) {
            throw new DAOException("Error while updating subject", e);
        }
        finally {
            connectionPool.returnConnection(connection);
        }
    }

    @Override
    public void deleteSubject(int id) throws DAOException {
        PreparedStatement ps = null;
        Connection connection = null;

        try {
            connection = connectionPool.takeConnection();
            ps = connection.prepareStatement(DELETE_SUBJECT_SQL);
            ps.setInt(1, id);

            ps.executeUpdate();
            ps.close();
        }
        catch (ConnectionPoolException e) {
            throw new DAOException("Error in connection pool while deleting subject", e);
        }
        catch (SQLException e) {
            throw new DAOException("Error while deleting subject", e);
        }
        finally {
            connectionPool.returnConnection(connection);
        }
    }
}
