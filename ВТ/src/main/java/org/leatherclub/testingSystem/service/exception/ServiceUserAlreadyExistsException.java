package org.leatherclub.testingSystem.service.exception;

public class ServiceUserAlreadyExistsException extends ServiceException {
    public ServiceUserAlreadyExistsException() {
        super();
    }

    public ServiceUserAlreadyExistsException(String message) {
        super(message);
    }

    public ServiceUserAlreadyExistsException(String message, Throwable cause) {
        super(message, (Exception) cause);
    }

    public ServiceUserAlreadyExistsException(Throwable cause) {
        super(cause);
    }
}
