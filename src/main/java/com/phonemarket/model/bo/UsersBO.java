package com.phonemarket.model.bo;

import com.phonemarket.model.bean.Users;
import com.phonemarket.model.dao.UsersDAO;

import java.sql.SQLException;
import java.util.List;

public class UsersBO {

    private final UsersDAO usersDAO;

    public UsersBO() {
        this.usersDAO = new UsersDAO();   // đúng DAO
    }

    // Lấy tất cả Users
    public List<Users> getAllUsers() throws SQLException {
        System.out.println("DEBUG BO - Calling UsersDAO.findAll()");
        List<Users> list = usersDAO.findAll();
        System.out.println("DEBUG BO - DAO returned " + (list != null ? list.size() : 0) + " users");
        return list;
    }

    // Lấy user theo full name
    public Users getUserByFullName(String fullName) throws SQLException {
        return usersDAO.findByName(fullName);
    }

    // Lấy user theo ID
    public Users getUserById(int id) throws SQLException {
        return usersDAO.findById(id);
    }

    // Xóa user
    public boolean deleteUser(int userId) throws SQLException {
        if (userId <= 0) return false;
        return usersDAO.delete(userId);
    }

    public boolean updateUser(Users user) {
        if (user == null || user.getUserId() <= 0) {
            return false;
        }
        return usersDAO.update(user);
    }

    public boolean checkPassword(int userId, String oldPassword) {
        if (userId <= 0 || oldPassword == null) {
            return false;
        }
        return usersDAO.checkPassword(userId, oldPassword);
    }

    public boolean updatePassword(int userId, String newPassword) {
        if (userId <= 0 || newPassword == null) {
            return false;
        }
        return usersDAO.updatePassword(userId, newPassword);
    }
}
