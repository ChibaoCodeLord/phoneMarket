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

        String action = req.getPathInfo(); // "/", "/view", "/delete", ...
        if (action == null) action = "/";

        try {


            if ("/".equals(action)) {
                List<Orders> orders = ordersBO.getAllOrders();
                req.setAttribute("ordersList", orders);
                req.getRequestDispatcher("/jsp/admin/orders/list_orders.jsp")
                        .forward(req, resp);
                return;
            }


            if ("/view".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));

                Orders order = ordersBO.getOrderDetails(id);
                List<OrderDetailItem> items = ordersBO.getOrderDetailItems(id);

                // 🟦 DEBUG: IN ORDER
                System.out.println("===== DEBUG ORDER =====");
                System.out.println("Order ID: " + order.getOrderId());
                System.out.println("Customer: " + order.getCustomerName());
                System.out.println("Total: " + order.getTotalAmount());
                System.out.println("Status: " + order.getStatus());
                System.out.println("=======================");

                // 🟩 DEBUG: IN DANH SÁCH CHI TIẾT
                System.out.println("===== DEBUG ORDER ITEMS =====");
                if (items == null) {
                    System.out.println("items = NULL");
                } else if (items.isEmpty()) {
                    System.out.println("items = EMPTY");
                } else {
                    for (OrderDetailItem item : items) {
                        System.out.println(
                                "Product: " + item.getProductName() +
                                        " | Qty: " + item.getQuantity() +
                                        " | Price: " + item.getPriceAtPurchase() +
                                        " | Image: " + item.getProductImage()
                        );
                    }
                }
                System.out.println("============================");

                req.setAttribute("order", order);
                req.setAttribute("orderItems", items);

                req.getRequestDispatcher("/jsp/admin/orders/order_detail.jsp")
                        .forward(req, resp);
                return;
            }



            if ("/delete".equals(action)) {
                String idStr = req.getParameter("id");
                System.out.println("ID param: " + idStr);

                if (idStr != null) {
                    try {
                        int id = Integer.parseInt(idStr);

                        if (ordersBO != null) {
                            boolean success = ordersBO.cancelOrder(id);
                            System.out.println("Cancel order result: " + success);
                        } else {
                            System.out.println("Error: ordersBO is null!");
                        }

                    } catch (NumberFormatException e) {
                        System.out.println("Error: ID is not a valid number - " + idStr);
                    }
                } else {
                    System.out.println("Error: ID parameter is missing!");
                }

                // Redirect về trang danh sách đơn hàng
                String redirectUrl = req.getContextPath() + "/admin/orders/";
                System.out.println("Redirecting to: " + redirectUrl);
                resp.sendRedirect(redirectUrl);
                return;
            }

            if ("/hardDelete".equals(action)) {
                String idsParam = req.getParameter("ids"); // ví dụ: "1,2,3"
                if (idsParam != null && !idsParam.isEmpty()) {
                    String[] idArray = idsParam.split(",");
                    for (String idStr : idArray) {
                        try {
                            int id = Integer.parseInt(idStr.trim());
                            ordersBO.hardDeleteOrder(id); // Xóa cứng trong DB
                        } catch (NumberFormatException e) {
                            System.out.println("Invalid order ID: " + idStr);
                        } catch (SQLException e) {
                            System.out.println("Error deleting order ID: " + idStr);
                            e.printStackTrace();
                        }
                    }
                }
                resp.sendRedirect(req.getContextPath() + "/admin/orders/");
            }

            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Action không hợp lệ");

        }






        catch (SQLException e) {
            req.setAttribute("error", "Database error: " + e.getMessage());
            req.getRequestDispatcher("/jsp/admin/orders/list_orders.jsp")
                    .forward(req, resp);
            e.printStackTrace();

        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID không hợp lệ");
        }
    }
}
