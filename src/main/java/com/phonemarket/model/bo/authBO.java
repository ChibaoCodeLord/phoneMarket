package com.phonemarket.model.bo;

import com.phonemarket.model.dao.authDAO;
import com.phonemarket.model.bean.Users;

public class authBO {
    authDAO authDao = new authDAO();



    public boolean register(Users user) {
        return authDao.register(user);
    }

    public Users login(String username, String password) throws Exception {
        // Business validation
        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            throw new Exception("Tên đăng nhập và mật khẩu không được để trống!");
        }
        Users user = authDao.findByUsernameAndPassword(username.trim(), password.trim());
        if (user == null) {
            throw new Exception("Tài khoản không tồn tại hoặc mật khẩu sai!");
        }
        return user;
    }
}
