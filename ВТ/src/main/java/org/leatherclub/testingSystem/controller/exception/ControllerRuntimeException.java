package org.leatherclub.testingSystem.controller.exception;

public class ControllerRuntimeException extends RuntimeException {
    public ControllerRuntimeException() {
        super();
    }

    public ControllerRuntimeException(String message) {
        super(message);
    }

    public ControllerRuntimeException(String message, Throwable cause) {
        super(message, cause);
    }

    public ControllerRuntimeException(Throwable cause) {
        super(cause);
    }
}