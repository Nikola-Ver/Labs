package org.leatherclub.testingSystem.dao.impl.connection;

import java.sql.*;
import java.util.Queue;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;

public final class ConnectionPool {

    private static final int POOL_SIZE = 5;
    private BlockingQueue<Connection> connectionQueue;
    private BlockingQueue<Connection> givenAwayConQueue;

    private String driverName;
    private String url;
    private String user;
    private String password;
    private int poolSize;

    private static final ConnectionPool instance = new ConnectionPool();

    private ConnectionPool() {
        DBResourceManager dbResourceManager = DBResourceManager.getInstance();
        this.driverName = dbResourceManager.getValue(DBParameter.DB_DRIVER);
        this.url = dbResourceManager.getValue(DBParameter.DB_URL);
        this.user = dbResourceManager.getValue(DBParameter.DB_USER);
        this.password = dbResourceManager.getValue(DBParameter.DB_PASSWORD);

        try {
            this.poolSize = Integer.parseInt(dbResourceManager.getValue(DBParameter.DB_POOL_SIZE));
        }
        catch (NumberFormatException e) {
            poolSize = POOL_SIZE;
        }
    }

    public static ConnectionPool getInstance() {
        return instance;
    }

    public void InitPoolData() throws ConnectionPoolException {

        try {
            Class.forName(driverName).newInstance();
            givenAwayConQueue = new ArrayBlockingQueue<Connection>(poolSize);
            connectionQueue = new ArrayBlockingQueue<Connection>(poolSize);

            for (int i = 0; i < poolSize; i++) {
                Connection connection = DriverManager.getConnection(url, user, password);
                connection.setAutoCommit(true);
                connectionQueue.add(connection);
            }
        } catch (SQLException e) {
            throw new ConnectionPoolException("SQL Exception in connection pool", e);
        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException e) {
            throw new ConnectionPoolException("Can't find database driver class", e);
        }
    }

    public Connection takeConnection() throws ConnectionPoolException {
        Connection connection = null;
        try {
            connection = connectionQueue.take();
            givenAwayConQueue.add(connection);
        }
        catch (InterruptedException e) {
            throw new ConnectionPoolException("Error connecting to datasource", e);
        }
        return connection;
    }

    public void returnConnection(Connection connection) {
        if(givenAwayConQueue.remove(connection))
            connectionQueue.add(connection);
    }

    public void dispose() {
        try {
            closeConnectionQueue(givenAwayConQueue);
            closeConnectionQueue(connectionQueue);
        }
        catch (SQLException e) {
            //log
        }
    }

    private void closeConnectionQueue(Queue<Connection> queue) throws SQLException {
        Connection connection;
        while((connection = connectionQueue.poll()) != null) {
            if(!connection.getAutoCommit())
                connection.commit();
            connection.close();
        }
    }
}
