package org.leatherclub.testingSystem.dao.impl;

import org.leatherclub.testingSystem.bean.Answer;
import org.leatherclub.testingSystem.bean.Question;
import org.leatherclub.testingSystem.dao.QuestionDAO;
import org.leatherclub.testingSystem.dao.exception.DAOException;
import org.leatherclub.testingSystem.dao.impl.connection.ConnectionPool;
import org.leatherclub.testingSystem.dao.impl.connection.ConnectionPoolException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class QuestionDAOImpl implements QuestionDAO {

    private static final String DB_COLUMN_QUESTION = "question";
    private static final String DB_COLUMN_ID = "id";
    private static final String DB_COLUMN_TEST = "test";

    private static final ConnectionPool connectionPool = ConnectionPool.getInstance();

    private static final String INSERT_QUESTION_SQL = "INSERT testsdb.questions(`test`, `question`) VALUES (?,?)";
    private static final String DELETE_QUESTION_SQL = "DELETE FROM testsdb.questions WHERE testsdb.questions.id = ?";
    private static final String UPDATE_QUESTION_SQL = "UPDATE testsdb.questions SET testsdb.questions.question = ? WHERE testsdb.questions.id = ?";
    private static final String SELECT_QUESTION_SQL = "SELECT * FROM testsdb.questions WHERE testsdb.questions.test = ?";

    @Override
    public List<Question> getQuestions(int testId) throws DAOException {

        PreparedStatement ps = null;
        Connection connection = null;
        ResultSet rs = null;

        try {
            connection = connectionPool.takeConnection();
            ps = connection.prepareStatement(SELECT_QUESTION_SQL);
            ps.setInt(1, testId);

            rs = ps.executeQuery();
            if(rs == null)
                return null;

            List<Question> questions = new ArrayList<Question>();
            while(rs.next()) {
                questions.add(new Question(rs.getInt(DB_COLUMN_ID), rs.getInt(DB_COLUMN_TEST), rs.getString(DB_COLUMN_QUESTION), new ArrayList<Answer>()));
            }
            ps.close();
            rs.close();
            return questions;
        }
        catch (ConnectionPoolException e) {
            throw new DAOException("Error in connection pool while getting questions", e);
        }
        catch (SQLException e) {
            throw new DAOException("Error while getting questions", e);
        }
        finally {
            connectionPool.returnConnection(connection);
        }
    }

    @Override
    public void addQuestion(int testId, String question) throws DAOException {
        PreparedStatement ps = null;
        Connection connection = null;

        try {
            connection = connectionPool.takeConnection();
            ps = connection.prepareStatement(INSERT_QUESTION_SQL);
            ps.setInt(1, testId);
            ps.setString(2, question);

            ps.executeUpdate();
            ps.close();
        }
        catch (ConnectionPoolException e) {
            throw new DAOException("Error in connection pool while inserting question", e);
        }
        catch (SQLException e) {
            throw new DAOException("Error while inserting question", e);
        }
        finally {
            connectionPool.returnConnection(connection);
        }
    }

    @Override
    public void editQuestion(int questionId, String question) throws DAOException {
        PreparedStatement ps = null;
        Connection connection = null;

        try {
            connection = connectionPool.takeConnection();
            ps = connection.prepareStatement(UPDATE_QUESTION_SQL);
            ps.setString(1, question);
            ps.setInt(2, questionId);

            ps.executeUpdate();
            ps.close();
        }
        catch (ConnectionPoolException e) {
            throw new DAOException("Error in connection pool while updating question", e);
        }
        catch (SQLException e) {
            throw new DAOException("Error while updating question", e);
        }
        finally {
            connectionPool.returnConnection(connection);
        }
    }

    @Override
    public void deleteQuestion(int questionId) throws DAOException {
        PreparedStatement ps = null;
        Connection connection = null;

        try {
            connection = connectionPool.takeConnection();
            ps = connection.prepareStatement(DELETE_QUESTION_SQL);
            ps.setInt(1, questionId);

            ps.executeUpdate();
            ps.close();
        }
        catch (ConnectionPoolException e) {
            throw new DAOException("Error in connection pool while deleting question", e);
        }
        catch (SQLException e) {
            throw new DAOException("Error while deleting question", e);
        }
        finally {
            connectionPool.returnConnection(connection);
        }
    }
}
