package org.leatherclub.testingSystem.service.exception;

public class ServiceException extends Exception {
    public ServiceException(String message, Exception e) {
        super(message, e);
    }

    public ServiceException() {
        super();
    }

    public ServiceException(String message) {
        super(message);
    }

    public ServiceException(Throwable cause) {
        super(cause);
    }

    public ServiceException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
