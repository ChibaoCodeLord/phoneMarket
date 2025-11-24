package com.phonemarket.controller.auth;

import com.phonemarket.model.bo.authBO;
import com.phonemarket.model.bean.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class RegisterController extends HttpServlet {
    private final authBO authBO = new authBO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("jsp/auth/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy parameters (null-safe)
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String fullName = req.getParameter("fullName");

        // LOGGING: In ra console để debug
        System.out.println("DEBUG - Username: '" + username + "'");
        System.out.println("DEBUG - FullName: '" + fullName + "'");
        System.out.println("DEBUG - All params: " + req.getParameterMap());

        // Trim và check null/empty (bắt buộc cho username, password, email, fullName)
        if (username == null || username.trim().isEmpty()) {
            req.setAttribute("error", "Username không được để trống!");
            doGet(req, resp);
            return;
        }
        if (password == null || password.trim().isEmpty()) {
            req.setAttribute("error", "Password không được để trống!");
            doGet(req, resp);
            return;
        }
        if (email == null || email.trim().isEmpty()) {
            req.setAttribute("error", "Email không được để trống!");
            doGet(req, resp);
            return;
        }
        if (fullName == null || fullName.trim().isEmpty()) {
            req.setAttribute("error", "Họ tên không được để trống!");
            doGet(req, resp);
            return;
        }

        // Tạo User với trim (phone/address optional)
        Users user = new Users(username.trim(), password.trim(), email.trim(),
                phone != null ? phone.trim() : null,
                address != null ? address.trim() : null, fullName.trim());

        // LOGGING: Check User object trước gọi BO
        System.out.println("DEBUG - User.getUsername(): '" + user.getUsername() + "'");
        System.out.println("DEBUG - User.fullname: '" + user.getFullName() + "'");  // Kiểm tra constructor

        try {
            boolean success = authBO.register(user);
            if (success) {
                // Thành công: Redirect đến login
                resp.sendRedirect(req.getContextPath() + "jsp/auth/login.jsp");
            } else {
                req.setAttribute("error", "Đăng ký thất bại! (Kiểm tra username/email đã tồn tại)");
                doGet(req, resp);
            }
        } catch (Exception e) {
            // Catch lỗi từ BO/DAO
            System.out.println("DEBUG - Register error: " + e.getMessage());
            req.setAttribute("error", "Lỗi: " + e.getMessage());
            doGet(req, resp);
        }
    }
}