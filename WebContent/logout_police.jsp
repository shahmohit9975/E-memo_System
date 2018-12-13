<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>


<% 


session.removeAttribute("memo_filled_by_id_police");
session.removeAttribute("memo_filled_by_police");
session.removeAttribute("rules_break_state");
session.removeAttribute("rules_break_city");
session.removeAttribute("rules_break_place");
session.removeAttribute("panelty");
session.removeAttribute("rules_id_1");
session.removeAttribute("rules_id_2");
session.removeAttribute("rules_id_3");
session.removeAttribute("vehicle_id");
session.removeAttribute("memo_id");
session.removeAttribute("ourJavaTimestampObject");








%>
<jsp:include page="Login_Police.jsp"/>

</body>
</html>