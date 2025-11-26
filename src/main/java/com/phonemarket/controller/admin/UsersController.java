package com.phonemarket.controller.admin;

import com.phonemarket.model.bean.Users;
import com.phonemarket.model.bo.UsersBO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/users/*")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class UsersController extends HttpServlet {

    private UsersBO usersBO;

    @Override
    public void init() {
        usersBO = new UsersBO(); // init BO
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getPathInfo();
        System.out.println("DEBUG UsersController doGet - Action: " + action);

        // ========== LOAD LIST USERS ==========
        if (action == null || "/".equals(action)) {
            List<Users> usersList = null;

            try {
                usersList = usersBO.getAllUsers();
                System.out.println("DEBUG Controller - Loaded "
                        + (usersList != null ? usersList.size() : 0)
                        + " users from BO");
            } catch (SQLException e) {
                System.out.println("DEBUG Controller - SQL Error: " + e.getMessage());
                req.setAttribute("error", "Lỗi tải danh sách khách hàng: " + e.getMessage());
            }

            req.setAttribute("usersList", usersList);

            // Forward tới trang JSP hiển thị User
            req.getRequestDispatcher("/jsp/admin/users/admin-users.jsp")
                    .forward(req, resp);
        }else if ("/detail".equals(action)) {
            try {
                int userId = Integer.parseInt(req.getParameter("id"));
                Users user = usersBO.getUserById(userId);
                if (user != null) {
                    req.setAttribute("user", user);
                    // Forward tới trang detailUser.jsp
                    req.getRequestDispatcher("/jsp/admin/users/detailUser.jsp").forward(req, resp);
                } else {
                    resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                }
            } catch (Exception e) {
                e.printStackTrace();
                req.setAttribute("error", "Lỗi tải chi tiết user: " + e.getMessage());
                req.getRequestDispatcher("/jsp/admin/users/admin-users.jsp").forward(req, resp);
            }
        }

        else if ("/edit".equals(action)) {
            int userId = Integer.parseInt(req.getParameter("id"));

            try {
                Users user = usersBO.getUserById(userId);
                if (user != null) {
                    req.setAttribute("user", user);
                    req.getRequestDispatcher("/jsp/admin/users/updateUser.jsp").forward(req, resp);
                } else {
                    resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                }
            } catch (SQLException e) {
                System.out.println("DEBUG Controller - Error getProductById: " + e.getMessage());  // Log
                e.printStackTrace();
            }
        }
        else if ("/delete".equals(action)) {
            try {
                int userId = Integer.parseInt(req.getParameter("id"));
                boolean deleted = usersBO.deleteUser(userId); // gọi BO để xóa
                if (deleted) {
                    resp.sendRedirect(req.getContextPath() + "/admin/users/");
                } else {
                    req.setAttribute("error", "Xóa người dùng thất bại!");
                    req.getRequestDispatcher("/jsp/admin/users/admin-users.jsp").forward(req, resp);
                }
            } catch (Exception e) {
                e.printStackTrace();
                req.setAttribute("error", "Lỗi xóa người dùng: " + e.getMessage());
                req.getRequestDispatcher("/jsp/admin/users/admin-users.jsp").forward(req, resp);
            }
        }
        else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy trang");
        }
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getPathInfo();
        System.out.println("DEBUG UsersController doPost - Action: " + action);

        if ("/update".equals(action)) {
            try {
                // 1. Lấy dữ liệu từ form
                int userId = Integer.parseInt(req.getParameter("id"));
                String fullName = req.getParameter("full_name");
                String email = req.getParameter("email");
                String phone = req.getParameter("phone_number");
                String address = req.getParameter("address");
                boolean role = Boolean.parseBoolean(req.getParameter("role")); // true = admin, false = user

                // 2. Lấy đối tượng Users hiện tại từ DB
                Users user = usersBO.getUserById(userId);
                if (user == null) {
                    resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Người dùng không tồn tại");
                    return;
                }

                // 3. Cập nhật các trường
                user.setFullName(fullName);
                user.setEmail(email);
                user.setPhone(phone);
                user.setAddress(address);
                user.setRole(role);

//                // 4. Xử lý upload avatar (nếu có)
//                if (req.getPart("avatarFile") != null && req.getPart("avatarFile").getSize() > 0) {
//                    String fileName = Path.of(req.getPart("avatarFile").getSubmittedFileName()).getFileName().toString();
//                    String uploadDir = req.getServletContext().getRealPath("/uploads/users/");
//                    java.nio.file.Files.createDirectories(java.nio.file.Paths.get(uploadDir));
//                    req.getPart("avatarFile").write(uploadDir + fileName);
//
//                    // Cập nhật đường dẫn avatar trong object
//                    user.setAvatar("/uploads/users/" + fileName);
//                }

                // 5. Gọi BO để update DB
                boolean updated = usersBO.updateUser(user);
                if (updated) {
                    resp.sendRedirect(req.getContextPath() + "/admin/users/");
                } else {
                    req.setAttribute("error", "Cập nhật người dùng thất bại!");
                    req.setAttribute("user", user);
                    req.getRequestDispatcher("/jsp/admin/users/updateUser.jsp").forward(req, resp);
                }

            } catch (Exception e) {
                e.printStackTrace();
                req.setAttribute("error", "Lỗi server: " + e.getMessage());
                req.getRequestDispatcher("/jsp/admin/users/updateUser.jsp").forward(req, resp);
            }
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}
