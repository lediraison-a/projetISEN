package com.isen.projetisenapi.api;

import com.isen.projetisenapi.api.models.User;
import com.isen.projetisenapi.service.AdminService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;

import java.util.List;

@Controller
public class AdminApiImpl extends AbstractApi implements AdminApi {

    private final AdminService adminService;

    public AdminApiImpl(AdminService adminService) {
        this.adminService = adminService;
    }

    @Override
    public ResponseEntity<List<String>> adminAdminsGet() {
        return ResponseEntity.ok(adminService.getAdmins());
    }

    @Override
    public ResponseEntity<Void> adminAdminsPut(List<String> requestBody) {
        adminService.setAdmins(requestBody, getPrincipal().getName());
        return ResponseEntity.ok().build();
    }

    @Override
    public ResponseEntity<Void> adminDeactivateUidPost(String uid) {
        adminService.disableUser(uid);
        return ResponseEntity.ok().build();
    }

    @Override
    public ResponseEntity<Void> adminReactivateUidPost(String uid) {
        adminService.activateUser(uid);
        return ResponseEntity.ok().build();
    }

    @Override
    public ResponseEntity<List<User>> adminUsersGet() {
        var userInfos = adminService.listUsers();
        return ResponseEntity.ok(userInfos.stream().map(userInfo -> {
            var u = new User();
            u.setMail(userInfo.getEmail());
            u.setDisabled(userInfo.getDisabled());
            u.setUid(userInfo.getUid());
            u.setName(userInfo.getName());
            return u;
        }).toList());
    }
}
