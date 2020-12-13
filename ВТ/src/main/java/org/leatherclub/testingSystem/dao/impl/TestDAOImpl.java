package org.leatherclub.testingSystem.dao.impl;

import org.leatherclub.testingSystem.bean.Subject;
import org.leatherclub.testingSystem.bean.Test;
import org.leatherclub.testingSystem.dao.TestDAO;
import org.leatherclub.testingSystem.dao.exception.DAOException;
import org.leatherclub.testingSystem.dao.impl.connection.ConnectionPool;
import org.leatherclub.testingSystem.dao.impl.connection.ConnectionPoolException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TestDAOImpl implements TestDAO {

    private static final String DB_COLUMN_TITLE = "title";
    private static final String DB_COLUMN_ID = "id";
    private static final String DB_COLUMN_SUBJECT = "subject";

    private static final ConnectionPool connectionPool = ConnectionPool.getInstance();

    private static final String INSERT_TEST_SQL = "INSERT testsdb.tests(`subject`, `title`) VALUES (?,?)";
    private static final String DELETE_TEST_SQL = "DELETE FROM testsdb.tests WHERE testsdb.tests.id = ?";
    private static final String UPDATE_TEST_SQL = "UPDATE testsdb.tests SET testsdb.tests.title = ? WHERE testsdb.tests.id = ?";
    private static final String SELECT_TEST_SQL = "SELECT * FROM testsdb.tests WHERE testsdb.tests.subject = ?";

    @Override
    public List<Test> getTests(int subjectId) throws DAOException {
        PreparedStatement ps = null;
        Connection connection = null;
        ResultSet rs = null;

        try {
            connection = connectionPool.takeConnection();
            ps = connection.prepareStatement(SELECT_TEST_SQL);
            ps.setInt(1, subjectId);

            rs = ps.executeQuery();
            if(rs == null)
                return null;

            List<Test> tests = new ArrayList<Test>();
            while(rs.next()) {
                tests.add(new Test(rs.getInt(DB_COLUMN_ID), rs.getInt(DB_COLUMN_SUBJECT), rs.getString(DB_COLUMN_TITLE)));
            }
            ps.close();
            rs.close();
            return tests;
        }
        catch (ConnectionPoolException e) {
            throw new DAOException("Error in connection pool while getting tests", e);
        }
        catch (SQLException e) {
            throw new DAOException("Error while getting tests", e);
        }
        finally {
            connectionPool.returnConnection(connection);
        }
    }

    @Override
    public void addTest(int subjectId, String title) throws DAOException {
        PreparedStatement ps = null;
        Connection connection = null;

        try {
            connection = connectionPool.takeConnection();
            ps = connection.prepareStatement(INSERT_TEST_SQL);
            ps.setInt(1, subjectId);
            ps.setString(2, title);

            ps.executeUpdate();
            ps.close();
        }
        catch (ConnectionPoolException e) {
            throw new DAOException("Error in connection pool while inserting test", e);
        }
        catch (SQLException e) {
            throw new DAOException("Error while inserting test", e);
        }
        finally {
            connectionPool.returnConnection(connection);
        }
    }

    @Override
    public void editTest(int testId, String title) throws DAOException {
        PreparedStatement ps = null;
        Connection connection = null;

        try {
            connection = connectionPool.takeConnection();
            ps = connection.prepareStatement(UPDATE_TEST_SQL);
            ps.setString(1, title);
            ps.setInt(2, testId);

            ps.executeUpdate();
            ps.close();
        }
        catch (ConnectionPoolException e) {
            throw new DAOException("Error in connection pool while updating test", e);
        }
        catch (SQLException e) {
            throw new DAOException("Error while updating test", e);
        }
        finally {
            connectionPool.returnConnection(connection);
        }
    }

    @Override
    public void deleteTest(int testId) throws DAOException {
        PreparedStatement ps = null;
        Connection connection = null;

        try {
            connection = connectionPool.takeConnection();
            ps = connection.prepareStatement(DELETE_TEST_SQL);
            ps.setInt(1, testId);

            ps.executeUpdate();
            ps.close();
        }
        catch (ConnectionPoolException e) {
            throw new DAOException("Error in connection pool while deleting test", e);
        }
        catch (SQLException e) {
            throw new DAOException("Error while deleting test", e);
        }
        finally {
            connectionPool.returnConnection(connection);
        }
    }
}
