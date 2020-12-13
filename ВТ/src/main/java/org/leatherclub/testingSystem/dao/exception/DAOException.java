package org.leatherclub.testingSystem.dao.exception;

public class DAOException extends Exception {
    public DAOException(String message, Exception e) {
        super(message, e);
    }

    public DAOException() {
        super();
    }

    public DAOException(String message) {
        super(message);
    }

    public DAOException(Throwable cause) {
        super(cause);
    }

    public DAOException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
