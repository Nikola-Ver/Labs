package org.leatherclub.testingSystem.dao.impl;

import org.leatherclub.testingSystem.bean.User;
import org.leatherclub.testingSystem.dao.UserDAO;
import org.leatherclub.testingSystem.dao.exception.DAOException;
import org.leatherclub.testingSystem.dao.exception.DAOUserAlreadyExistsException;
import org.leatherclub.testingSystem.dao.impl.connection.ConnectionPool;
import org.leatherclub.testingSystem.dao.impl.connection.ConnectionPoolException;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;

public class UserDAOImpl implements UserDAO {

    private static final String DB_COLUMN_NAME = "name";
    private static final String DB_COLUMN_LASTNAME = "lastname";
    private static final String DB_COLUMN_LOGIN = "login";
    private static final String DB_COLUMN_EMAIL = "email";
    private static final String DB_COLUMN_ROLE = "roleName";
    private static final String DB_COLUMN_ID = "id";

    private static final ConnectionPool connectionPool = ConnectionPool.getInstance();

    private static final String INSERT_USER_SQL = "INSERT testsdb.users(login, pass_hash, `name`, lastname, email, `role`) VALUES (?,?,?,?,?,?)";
    private static final String SIGN_IN_SQL = "SELECT u.*, r.name as roleName FROM testsdb.users u INNER JOIN testsdb.roles r ON u.role = r.id where u.login = ? and u.pass_hash = ?";

    public UserDAOImpl() {}

    private static String getMD5Hash(byte[] password) throws NoSuchAlgorithmException {
        String generatedPassword = null;

        MessageDigest md = MessageDigest.getInstance("MD5");
        md.update(password);
        byte[] bytes = md.digest();
        StringBuilder sb = new StringBuilder();
        for (byte aByte : bytes) {
            sb.append(Integer.toString((aByte & 0xff) + 0x100, 16).substring(1));
        }
        generatedPassword = sb.toString();
        return generatedPassword;
    }

    @Override
    public User signIn(String login, byte[] password) throws DAOException {
        PreparedStatement ps = null;
        Connection connection = null;
        ResultSet rs = null;

        try {
            connection = connectionPool.takeConnection();
            ps = connection.prepareStatement(SIGN_IN_SQL, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            ps.setString(1, login);
            ps.setString(2, getMD5Hash(password));

            rs = ps.executeQuery();
            if(rs == null)
                return null;

            rs.last();
            if(rs.getRow() == 1) {
                User user = new User(rs.getInt(DB_COLUMN_ID), rs.getString(DB_COLUMN_LOGIN), rs.getString(DB_COLUMN_NAME), rs.getString(DB_COLUMN_LASTNAME), rs.getString(DB_COLUMN_EMAIL), rs.getString(DB_COLUMN_ROLE));
                ps.close();
                rs.close();
                return user;
            }
        }
        catch (ConnectionPoolException e) {
            throw new DAOException("Error in connection pool while authorizing user", e);
        }
        catch (SQLException e) {
            throw new DAOException("Error while authorizing user", e);
        }
        catch (NoSuchAlgorithmException e) {
            throw new DAOException("Password hashing error", e);
        }
        finally {
            connectionPool.returnConnection(connection);
        }
        return null;
    }

    @Override
    public void signUp(String login, byte[] password, String name, String lastname, String email, int roleId) throws DAOException {

        PreparedStatement ps = null;
        Connection connection = null;

        try {
            connection = connectionPool.takeConnection();
            ps = connection.prepareStatement(INSERT_USER_SQL);
            ps.setString(1, login);
            ps.setString(2, getMD5Hash(password));
            ps.setString(3, name);
            ps.setString(4, lastname);
            ps.setString(5, email);
            ps.setInt(6, roleId);

            ps.executeUpdate();
            ps.close();
        }
        catch (ConnectionPoolException e) {
            throw new DAOException("Error in connection pool while registering a new user", e);
        }
        catch (SQLIntegrityConstraintViolationException e) {
            throw new DAOUserAlreadyExistsException("Login already exists", e);
        }
        catch (SQLException e) {
            throw new DAOException("Error while registering a new user", e);
        }
        catch (NoSuchAlgorithmException e) {
            throw new DAOException("Password hashing error", e);
        }
        finally {
            connectionPool.returnConnection(connection);
        }
    }
}
