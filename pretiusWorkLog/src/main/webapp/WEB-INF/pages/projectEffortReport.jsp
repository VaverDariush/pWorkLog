<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page session="true"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Project effort report</title>
</head>
<body>
    <table>
    <tr><th>
    Nazwa klienta
    </th><th>
	Nazwa projektu
    </th><th>
	Ilość godzin w miesiącu
    </th><th>
	Miesiąc z rokiem
    </th></tr> 
        <c:forEach var="reportRow" items="${projectEffortReport}">
            <tr>
                <td>${reportRow.clientName}</td>
                <td>${reportRow.projectName}</td>
                <td>${reportRow.amountHours}</td>
                <td>${reportRow.workDate}</td>   
            </tr>
        </c:forEach>
    </table>

</body>
</html>
