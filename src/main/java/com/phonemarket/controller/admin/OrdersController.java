package com.phonemarket.controller.admin;

import com.phonemarket.model.bean.OrderDetailItem;
import com.phonemarket.model.bean.Orders;
import com.phonemarket.model.bo.OrdersBO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/orders/*")
public class OrdersController extends HttpServlet {

    private OrdersBO ordersBO = new OrdersBO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getPathInfo();
        if (action == null) action = "/";

        try {
            switch(action) {
                case "/":
                    List<Orders> orders = ordersBO.getAllOrders();
                    req.setAttribute("ordersList", orders);
                    req.getRequestDispatcher("/jsp/admin/orders/list_orders.jsp")
                            .forward(req, resp);
                    break;

                case "/view":
                    int viewId = Integer.parseInt(req.getParameter("id"));
                    Orders order = ordersBO.getOrderDetails(viewId);
                    List<OrderDetailItem> items = ordersBO.getOrderDetailItems(viewId);
                    req.setAttribute("order", order);
                    req.setAttribute("orderItems", items);
                    req.getRequestDispatcher("/jsp/admin/orders/order_detail.jsp")
                            .forward(req, resp);
                    break;

                case "/edit":
                    int editId = Integer.parseInt(req.getParameter("id"));
                    Orders editOrder = ordersBO.getOrderDetails(editId);
                    List<OrderDetailItem> editItems = ordersBO.getOrderDetailItems(editId);
                    req.setAttribute("order", editOrder);
                    req.setAttribute("orderItems", editItems);
                    req.getRequestDispatcher("/jsp/admin/orders/update_order.jsp")
                            .forward(req, resp);
                    break;



                case "/delete":
                    int deleteId = Integer.parseInt(req.getParameter("id"));
                    boolean canceled = ordersBO.cancelOrder(deleteId);
                    resp.sendRedirect(req.getContextPath() + "/admin/orders/");
                    break;

                case "/hardDelete":
                    String idsParam = req.getParameter("ids");
                    if (idsParam != null && !idsParam.isEmpty()) {
                        for (String s : idsParam.split(",")) {
                            int id = Integer.parseInt(s.trim());
                            ordersBO.hardDeleteOrder(id);
                        }
                    }
                    resp.sendRedirect(req.getContextPath() + "/admin/orders/");
                    break;

                default:
                    // Forward tới trang lỗi thay vì sendError
                    req.setAttribute("errorMessage", "Action không hợp lệ: " + action);
                    req.getRequestDispatcher("/jsp/admin/error.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            req.setAttribute("errorMessage", "Database error: " + e.getMessage());
            req.getRequestDispatcher("/jsp/admin/error.jsp").forward(req, resp);
            e.printStackTrace();
        } catch (NumberFormatException e) {
            req.setAttribute("errorMessage", "ID không hợp lệ");
            req.getRequestDispatcher("/jsp/admin/error.jsp").forward(req, resp);
        }
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getPathInfo();
        if (action == null) action = "/";

        try {
            if ("/edit".equals(action)) {
                int orderId = Integer.parseInt(req.getParameter("orderId"));
                int userId = Integer.parseInt(req.getParameter("userId"));
                java.util.Date orderDate = new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm")
                        .parse(req.getParameter("orderDate"));
                double totalAmount = Double.parseDouble(req.getParameter("totalAmount"));
                String shippingAddress = req.getParameter("shippingAddress");
                String status = req.getParameter("status");

                Orders order = new Orders(orderId, userId, orderDate, totalAmount, shippingAddress, status);

                boolean success = ordersBO.updateOrder(order);
                if (success) {
                    resp.sendRedirect(req.getContextPath() + "/admin/orders/");
                } else {
                    req.setAttribute("errorMessage", "Cập nhật đơn hàng thất bại!");
                    req.getRequestDispatcher("/jsp/admin/orders/edit_order.jsp")
                            .forward(req, resp);
                }
                return;
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", e.getMessage());
            req.getRequestDispatcher("/jsp/admin/error.jsp").forward(req, resp);
        }
    }

}
