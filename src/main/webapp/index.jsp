<%@ page import="java.util.List" %>
<%@ page import="beans.ResponseBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8"%>

<html>
<head>
    <meta charset="UTF-8">
    <title>lab2</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<header>
    <div class="header">
        <p>Лунева Арина Алексеевна</p>
        <p>Группа P3231</p>
        <p>Вариант 3851</p>
    </div>
</header>
    <svg height="400" width="400" xmlns="http://www.w3.org/2000/svg" id="graph">
        <line stroke="black" x1="0" x2="400" y1="200" y2="200"></line>
        <line stroke="black" x1="200" x2="200" y1="0" y2="400"></line>
        <polygon fill="black" stroke="black" points="200,0 195,10 205,10"></polygon>
        <polygon fill="black" stroke="black" points="400,200 390,195 390,205"></polygon>
        <polygon fill="#ba6fc7" points="200,200, 200,350 350,350 350,200" stroke="black"></polygon>
        <polygon fill="#ba6fc7" points="125,200 200,50 200,200" stroke="black"></polygon>
        <path d="M 200,50 A 150, 150  90 0,1 350,200 L 200,200 Z" fill="#ba6fc7" stroke="black"></path>
        <text fill="black" x="40" y="190">-R</text>
        <text fill="black" x="110" y="190">-R/2</text>
        <text fill="black" x="265" y="190">R/2</text>
        <text fill="black" x="345" y="190">R</text>
        <text fill="black" x="210" y="54">R</text>
        <text fill="black" x="210" y="128">R/2</text>
        <text fill="black" x="210" y="278">-R/2</text>
        <text fill="black" x="210" y="353">-R</text>
        <text fill="black" x="387" y="190">X</text>
        <text fill="black" x="210" y="10">Y</text>
        <line stroke="black" x1="50" x2="50" y1="195" y2="205" stroke-width="2"></line>
        <line stroke="black" x1="125" x2="125" y1="195" y2="205" stroke-width="2"></line>
        <line stroke="black" x1="275" x2="275" y1="195" y2="205" stroke-width="2"></line>
        <line stroke="black" x1="350" x2="350" y1="195" y2="205" stroke-width="2"></line>
        <line stroke="black" x1="195" x2="205" y1="50" y2="50" stroke-width="2"></line>
        <line stroke="black" x1="195" x2="205" y1="125" y2="125" stroke-width="2"></line>
        <line stroke="black" x1="195" x2="205" y1="275" y2="275" stroke-width="2"></line>
        <line stroke="black" x1="195" x2="205" y1="350" y2="350" stroke-width="2"></line>
        <%
            Object responses = session.getAttribute("responses");
            List<ResponseBean> history;
            if (responses instanceof List && !((List<?>) responses).isEmpty()
                    && ((List<?>) responses).get(0) instanceof ResponseBean) {
                history = (List<ResponseBean>) responses;
            } else {
                out.println("Таблица с результатами предыдущих проверок не найдена");
                history = new ArrayList<>();
            }
            if (!history.isEmpty()) {
                for (ResponseBean data : history) {
                    double cx = 200 + 150 / data.getR() * data.getX();
                    double cy = 200 - 150 / data.getR() * data.getY();
                    String color;
                    if (data.getResult().equals("Да")) {
                        color = "green";
                    } else color = "red";
                    out.println("<circle fill=\"" + (color) + "\" color=\"" +
                            color + "\" r=\"3\"" + "\" cx=\"" + cx + "\" cy=\"" + cy + "\"></circle>");
                }
            }
        %>
    </svg>
<form id="main-form" method="post">
    <div id="parameter">
        <div id="x" class="elements">
            Значение X:
            <select id="x-select">
                <option hidden disabled selected>&nbsp Select &nbsp</option>
                <option value="-5">-5</option>
                <option value="-4">-4</option>
                <option value="-3">-3</option>
                <option value="-2">-2</option>
                <option value="-1">-1</option>
                <option value="0">0</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
            </select>
        </div>
        <div id="y" class=elements>
            Значение Y:
            <input type="text" size=24 name="Y" placeholder="Значение из интервала (-3, 5)" id="y-text" maxlength="17" autocomplete="off">
        </div>
        <p>
        <div id="r" class="elements">
            Значение R:
            <input type="button" name="R" value="1">
            <input type="button" name="R" value="1.5">
            <input type="button" name="R" value="2">
            <input type="button" name="R" value="2.5">
            <input type="button" name="R" value="3">
        </div>
        <p>
        <div class="elements">
            <input type="submit">
            <input type="reset" id="reset">
        </div>
        <p>
        <div id="errors"></div>
    </div>
</form>
    <div id="results">
        <table id="result-table">
            <tr>
                <th>X</th>
                <th>Y</th>
                <th>R</th>
                <th>Текущее время</th>
                <th>Время работы скрипта</th>
                <th>Результат</th>
            </tr>
            <tbody id="responses">
            <%
                responses = session.getAttribute("responses");
                if (responses instanceof List && !((List) responses).isEmpty() &&
                        ((List) responses).get(0) instanceof ResponseBean) {
                    history = (List<ResponseBean>) responses;
                    for (ResponseBean data : history) {
                        out.println("<tr>");
                        out.println("<td>" + data.getX() + "</td>");
                        out.println("<td>" + data.getY() + "</td>");
                        out.println("<td>" + data.getR() + "</td>");
                        out.println("<td>" + data.getCurrentTime() + "</td>");
                        out.println("<td>" + data.getExecutionTime() + "</td>");
                        out.println("<td>" + data.getResult() + "</td>");
                        out.println("</tr>");
                    }
                }
            %>
            </tbody>
        </table>
    </div>
</body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="js/buttonSwitch.js"></script>
<script src="js/script.js"></script>
<script src="js/clickEvent.js"></script>
<script src="js/markPoint.js"></script>
<script>
    $(document).on('click', 'svg', function (event) {
        clickEvent(event);
    });
</script>
</html>
