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
session.removeAttribute("license_number");
%>
<form action="check_vehicle_number.jsp" method="post">
Enter Vehicle Number : <input type="text" name="vehicle_number" maxlength="10" required="required" placeholder="GJ01SA2339" >

<br >
<br >


<input type="submit" value="Check">
</form>

</body>
</html>