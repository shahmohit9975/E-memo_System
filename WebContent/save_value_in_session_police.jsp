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
String rules_name_1=request.getParameter("rules_name_1");
String rules_name_2=request.getParameter("rules_name_2");
String rules_name_3=request.getParameter("rules_name_3");
String vehicle_number=request.getParameter("vehicle_number");
String rules_break_state=request.getParameter("rules_break_state");
String rules_break_city=request.getParameter("rules_break_city");
String rules_break_place=request.getParameter("rules_break_place");

System.out.println("******************************************************* ");
System.out.println("1.rules_name_1------> "+rules_name_1);
System.out.println("2.rules_name_2------> "+rules_name_2);
System.out.println("3.rules_name_3------> "+rules_name_3);
System.out.println("4.vehicle_id_no-------> "+vehicle_number);
System.out.println("5.rules_break_state-------> "+rules_break_state);
System.out.println("6.rules_break_city-------> "+rules_break_city);
System.out.println("7.rules_break_place-------> "+rules_break_place);


session.setAttribute("rules_name_1", rules_name_1);
session.setAttribute("rules_name_2", rules_name_2);
session.setAttribute("rules_name_3", rules_name_3);
session.setAttribute("vehicle_number", vehicle_number);
session.setAttribute("rules_break_state", rules_break_state);
session.setAttribute("rules_break_city", rules_break_city);
session.setAttribute("rules_break_place", rules_break_place);

%>
</body>
</html>