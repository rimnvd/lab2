package servlets;

import beans.ResponseBean;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

@WebServlet("areaCheck")
public class AreaCheckServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        float x, y, r;
        long start = System.nanoTime();
        x = Float.parseFloat(request.getParameter("X"));
        y = Float.parseFloat(request.getParameter("Y"));
        r = Float.parseFloat(request.getParameter("R"));
        ResponseBean responseBean = createResponse(x, y, r, start);
        addResponse(session, responseBean);
        RequestDispatcher dispatcher = request.getRequestDispatcher("./index.jsp");
        dispatcher.forward(request, response);
    }

    public ResponseBean createResponse(float x, float y, float r, long start) {
        String execution = Long.toString((System.nanoTime()- start)/1000);
        String currentTime = new SimpleDateFormat("HH:mm:ss dd.MM.yyyy").format(Calendar.getInstance().getTime());
        String result = checkArea(x, y, r) ? "Да" : "Нет";
        return new ResponseBean(x, y, r, currentTime, execution, result);

    }

    @SuppressWarnings("unchecked")
    public void addResponse(HttpSession session, ResponseBean responseBean) {
        ArrayList<ResponseBean> responses;
        if (!(session.getAttribute("responses") instanceof ArrayList)) {
            responses = new ArrayList<>();
        } else {
            responses = (ArrayList<ResponseBean>) session.getAttribute("responses");
        }
        responses.add(responseBean);
        session.setAttribute("responses", responses);
    }

    public boolean checkTriangle(float x, float y, float r) {
        return x <= 0 && y >= 0 && y <= 2 * x + r;
    }

    public boolean checkRectangle(float x, float y, float r) {
        return x >= 0 && x <= r && y <= 0 && y >= -r;
    }
    public boolean checkSector (float x, float y, float r) {
        return x >= 0 && y >= 0 && Math.sqrt(x * x + y * y) <= r;
    }

    public boolean checkArea(float x, float y, float r) {
        return checkTriangle(x, y, r) || checkRectangle(x, y, r) || checkSector(x, y, r);
    }

}
