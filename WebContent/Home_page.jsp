<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
  <%@ page import="java.net.InetAddress"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<a href="Login_Admin.jsp">Admin</a>
<a href="Login_Police.jsp">Police</a>
<a href="Login_Assistance.jsp">Assistance</a>
<br>
<br>
<br>
<br>
<%

InetAddress ipAddr = InetAddress.getLocalHost();
System.out.println("My IP ADDRESS : ==========> " + ipAddr.getHostAddress());

String addr = request.getRemoteAddr();
System.out.println(" IP ADDRESS ==========> " + addr);


String host = request.getRemoteHost();
System.out.println("host : " + host);

int port = request.getRemotePort();
System.out.println("port : " + port);

%>
</body>
</html>