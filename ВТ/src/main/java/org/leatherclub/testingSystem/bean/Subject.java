package org.leatherclub.testingSystem.bean;

import java.io.Serializable;
import java.util.Objects;

public class Subject implements Serializable {
    private int subjectId;
    private String name;

    public Subject(int subjectId, String name) {
        this.subjectId = subjectId;
        this.name = name;
    }

    public int getSubjectId() {
        return subjectId;
    }

    public String getName() {
        return name;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        Subject that = (Subject)obj;
        return Objects.equals(subjectId, that.subjectId) &&
                Objects.equals(name, that.name);
    }

    @Override
    public int hashCode() {
        return Objects.hash(subjectId, name);
    }

    @Override
    public String toString() {
        return "Subject{" +
                "name='" + name + '\'' + '}';
    }
}
