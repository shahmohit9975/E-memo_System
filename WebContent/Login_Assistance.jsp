<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="Home_page.jsp"%>
	<h3>Login Form</h3>
	<form action="loginprocess.jsp" method="post">
	<input type="hidden" value="assistance" name="user">
		Your Id:<input type="text" name="id" /><br />
		<br /> Password:<input type="password" name="password" /><br />
		<br /> <input type="submit" value="login" />
	</form>
</body>
</html>