package com.isen.projetisenapi.models;

public class UserInfo {

    private String name;
    private String uid;
    private String email;
    private Boolean disabled;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Boolean getDisabled() {
        return disabled;
    }

    public void setDisabled(Boolean disabled) {
        this.disabled = disabled;
    }

    public UserInfo(String name, String uid, String email, Boolean disabled) {
        this.name = name;
        this.uid = uid;
        this.email = email;
        this.disabled = disabled;
    }

    @Override
    public String toString() {
        return "UserInfo{" +
                "name='" + name + '\'' +
                ", uid='" + uid + '\'' +
                ", email='" + email + '\'' +
                ", disabled=" + disabled +
                '}';
    }
}
