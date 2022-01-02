package servlets;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/controller")
public class ControllerServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String strX = request.getParameter("X");
        String strY = request.getParameter("Y");
        String strR = request.getParameter("R");
        boolean dataIsValid = true;
        if (strX == null) {
            out.println("Значение X не выбрано");
            dataIsValid = false;
        } else {
            try {
                Float.parseFloat(strX);
            } catch (NumberFormatException ex) {
                out.println("Значение X должно быть числом");
                dataIsValid = false;
            }
        }
        if (strY == null) {
            out.println("Значение Y не введено");
            dataIsValid = false;
        } else {
            try {
                Float.parseFloat(strY);
            } catch (NumberFormatException ex) {
                out.println("Значение Y должно быть числом");
                dataIsValid = false;
            }
        }
        if (strR == null) {
            out.println("Значение Y не введено");
            dataIsValid = false;
        } else {
            try {
                float r = Float.parseFloat(strR);
                if (r != 1 && r != 1.5 && r != 2 && r != 2.5 && r != 3) {
                    out.println("Неверное значение R");
                    dataIsValid = false;
                }
            } catch (NumberFormatException ex) {
                out.println("Значение Y должно быть числом");
                dataIsValid = false;
            }
        }
        RequestDispatcher requestDispatcher;
        if (dataIsValid) {
            requestDispatcher = request.getRequestDispatcher("/areaCheck");
        } else {
            requestDispatcher = request.getRequestDispatcher("./index.jsp");
        }
        requestDispatcher.forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("./index.jsp");
        requestDispatcher.forward(request, response);
    }
}

