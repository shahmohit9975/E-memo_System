<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
  <%@ page import="java.net.InetAddress"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home Page</title>

<style type="text/css">
body, html {
  height: 100%;
  margin: 0;
}
.container {

  height: 100%; 
 background-image: url("Home_page.png");

  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
   
 
}

.container img {
  width: 100%;
   height: 100%; 

}

.container .btn {
 
  transform: translate(-50%, -50%);
  -ms-transform: translate(-50%, -50%);
  background-color:rgb(163, 163, 117);
  color: black;
  font-size: 16px;
  padding: 16px 30px;
  cursor: pointer;
  border-radius: 30px;
  text-align: center;
  border: none;
  margin-left: 45%;
  width: 13%;
  font-weight: bold;
 
}

.container .btn:hover {
  background-color: black;
  color: white;
  border: none;
}
button:active {
outline: none;
border: none;
}

button:focus {outline:0;}
</style>

</head>

<body>
<div class="bg">

</div>

<div class="container" >
  
<a href="Login_Admin.jsp" ><button class="btn" style="margin-top: 18%;">Admin</button></a>

<a href="Login_Police.jsp"><button class="btn" style="margin-top: 1%;">Police</button></a>

<a href="Login_Assistance.jsp"><button class="btn" style="margin-top: 1%;">Assistance</button></a>
 
</div>
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
