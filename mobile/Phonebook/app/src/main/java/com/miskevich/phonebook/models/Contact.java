package com.miskevich.phonebook.models;

import org.jetbrains.annotations.NotNull;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;

public class Contact implements Serializable {
    public String id;
    public String firstName;
    public String secondName;
    public String patronymic;
    public String phone;
    public Date birthday;
    public String latitude;
    public String longitude;
    public ArrayList<String> images;
    public String videoUrl;

    public Contact(String id, String firstName, String secondName, String patronymic, String phone, Date birthday, String latitude, String longitude, ArrayList<String> images, String videoUrl) {
        this.id = id;
        this.firstName = firstName;
        this.secondName = secondName;
        this.patronymic = patronymic;
        this.phone = phone;
        this.birthday = birthday;
        this.latitude = latitude;
        this.longitude = longitude;
        this.images = images;
        this.videoUrl = videoUrl;
    }

    public Contact() {}

    @NotNull
    @Override
    public String toString() {
        return id;
    }
}
