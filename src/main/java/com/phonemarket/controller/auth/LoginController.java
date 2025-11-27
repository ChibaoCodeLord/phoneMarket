package com.phonemarket.controller.auth;
import com.phonemarket.model.bo.authBO;
import com.phonemarket.model.bean.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    private final authBO authBO = new authBO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/jsp/auth/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        try {
            Users user = authBO.login(username, password);
            HttpSession session = req.getSession();
            session.setAttribute("currentUser", user);  // Lưu đối tượng Users vào session
            session.setAttribute("user", user.getUsername());  // Lưu vào session
            System.out.println("DEBUG: Logged in user ID: " + user.getUserId());
            System.out.println("DEBUG: Logged in fullName: " + user.getFullName());
            if(user.isRole()){
                resp.sendRedirect(req.getContextPath() + "/admin/products");
            }else {
                resp.sendRedirect(req.getContextPath() + "/products");
            }// Thành công
        } catch (Exception e) {  // Catch BusinessException hoặc Exception
            req.setAttribute("error", e.getMessage());
            doGet(req, resp);  // Lỗi: Forward lại form
        }
    }
}