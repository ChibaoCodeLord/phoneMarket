package com.phonemarket.controller.admin.profile;

import com.phonemarket.model.bean.Users;
import com.phonemarket.model.bo.UsersBO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

@WebServlet("/admin/profile/*")
public class profileController extends HttpServlet {
    @Override
    protected void doGet(jakarta.servlet.http.HttpServletRequest req, jakarta.servlet.http.HttpServletResponse resp)
            throws jakarta.servlet.ServletException, java.io.IOException {
        String action = req.getPathInfo();
        if(action == null || "/".equals(action)) {
            Users user = (Users) req.getSession().getAttribute("currentUser");
            System.out.println("Current User ID: " + user.getUserId()); // Debug line to check the user ID
            req.getRequestDispatcher("/jsp/admin/profile/profile.jsp").forward(req, resp);
        } else if ("/edit".equals(action)) {
            Users user = (Users) req.getSession().getAttribute("currentUser");
            System.out.println("Current User ID: " + user.getUserId()); // Debug line to check the user ID
            req.getRequestDispatcher("/jsp/admin/profile/editProfile.jsp").forward(req, resp);
            
        } else if ("/changePassword".equals(action)) {
            req.getRequestDispatcher("/jsp/admin/profile/changePassword.jsp").forward(req, resp);
        } else {
            resp.sendError(jakarta.servlet.http.HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(jakarta.servlet.http.HttpServletRequest req, jakarta.servlet.http.HttpServletResponse resp)
            throws jakarta.servlet.ServletException, java.io.IOException {
        String action = req.getPathInfo();
        if ("/edit".equals(action)) {
            Users user = (Users) req.getSession().getAttribute("currentUser");
            UsersBO usersBO = new UsersBO();

            // Lấy dữ liệu từ form
            String username = req.getParameter("username");
            String fullName = req.getParameter("fullName");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone_number");
            String address = req.getParameter("address");

            // Cập nhật thông tin người dùng
            user.setFullName(fullName);
            user.setEmail(email);
            user.setPhone(phone);
            user.setAddress(address);

            if(usersBO.updateUser(user)) { // Cập nhật vào DB
                req.getSession().setAttribute("success", "Profile updated successfully.");
                req.getSession().setAttribute("currentUser", user); // Cập nhật session
            } else {
                req.getSession().setAttribute("error", "Failed to update profile.");
            }
            resp.sendRedirect(req.getContextPath() + "/admin/profile"); // Chuyển hướng về trang profile
        } else if ("/changePassword".equals(action)) {
            String currentPassword = req.getParameter("currentPassword");
            String newPassword = req.getParameter("newPassword");
            Users user = (Users) req.getSession().getAttribute("currentUser");
            UsersBO usersBO = new UsersBO();
            if (usersBO.checkPassword(user.getUserId(), currentPassword)) {
                usersBO.updatePassword(user.getUserId(), newPassword);
                req.getSession().setAttribute("success", "Password updated successfully.");
                resp.sendRedirect(req.getContextPath() + "/admin/profile");
            } else {
                req.getSession().setAttribute("error", "Current password is incorrect.");
                resp.sendRedirect(req.getContextPath() + "/admin/profile");
            }
        }
    }
}
