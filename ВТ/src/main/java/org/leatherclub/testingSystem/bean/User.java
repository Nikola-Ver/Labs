package org.leatherclub.testingSystem.bean;

import java.io.Serializable;
import java.util.Objects;

public class User implements Serializable {

    private int userId;
    private String login;
    private String name;
    private String lastname;
    private String email;
    private String roleName;

    public User(int userId, String login, String name, String lastname, String email, String roleName) {
        this.userId = userId;
        this.login = login;
        this.name = name;
        this.lastname = lastname;
        this.email = email;
        this.roleName = roleName;
    }

    public int getUserId() {
        return userId;
    }

    public String getLogin() {
        return login;
    }

    public String getName() {
        return name;
    }

    public String getLastname() {
        return lastname;
    }

    public String getEmail() {
        return email;
    }

    public String getRoleName() {
        return roleName;
    }

    @Override
    public boolean equals(Object obj) {
        if(this == obj) return true;
        if(obj == null || getClass() != obj.getClass()) return false;
        User that = (User)obj;
        return Objects.equals(name, that.name) &&
                Objects.equals(login, that.login) &&
                Objects.equals(lastname, that.lastname) &&
                Objects.equals(email, that.email) &&
                Objects.equals(roleName, that.roleName);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userId, login, name, lastname, email, roleName);
    }

    @Override
    public String toString() {
        return "User{" +
                "login='" + login + '\'' +
                ", name='" + name + '\'' +
                ", lastname='" + lastname + '\'' +
                ", email='" + email + '\'' +
                ", roleName='" + roleName + '\'' +
                '}';
    }
}
