
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ page import="java.net.InetAddress"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Assistance Login Page</title>

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

.btn_login {
	transform: translate(-50%, -50%);
	-ms-transform: translate(-50%, -50%);
	background-color: rgb(163, 163, 117);
	color: black;
	font-size: 16px;
	padding: 10px 10px;
	cursor: pointer;
	border-radius: 10px;
	text-align: center;
	border: none;
	float: left;
	font-weight: bold;
	width: 50%;
}

.container .btn_login:hover {
	background-color: green;
	color: white;
	border: none;
}

.btn_back {
	transform: translate(-50%, -50%);
	-ms-transform: translate(-50%, -50%);
	background-color: rgb(163, 163, 117);
	color: black;
	font-size: 16px;
	padding: 10px 10px;
	cursor: pointer;
	border-radius: 10px;
	text-align: center;
	border: none;
	float: left;
	font-weight: bold;
	width: 50%;
}

.container .btn_back:hover {
	background-color: red;
	color: white;
	border: none;
}

input[type=text] {
	width: 50%;
	box-sizing: border-box;
	border: 2px solid #ccc;
	border-radius: 4px;
	font-size: 16px;
	background-color: white;
	padding: 6px 10px 6px 10px;
	-webkit-transition: width 0.4s ease-in-out;
	transition: width 0.4s ease-in-out;
}

input[type=text]:focus {
	width: 70%;
}

input[type=password] {
	width: 50%;
	box-sizing: border-box;
	border: 2px solid #ccc;
	border-radius: 4px;
	font-size: 16px;
	background-color: white;
	padding: 6px 10px 6px 10px;
	-webkit-transition: width 0.4s ease-in-out;
	transition: width 0.4s ease-in-out;
}

input[type=password]:focus {
	width: 70%;
}
</style>
</head>


<body>
	<div class="bg"></div>
	<form action="loginprocess.jsp" method="post" class="container">

		<div align="center">
			<br> <br> <br> <br> <br> <br> <br>
			<br> <br> <br> <br> <br> <br>
			<table>

				<tr>
					<td><input type="hidden" value="assistance" name="user">
						<b>ID</b></td>
					<td><input type="text" placeholder="Enter Your id" name="id"
						required></td>

				</tr>
				<tr>
					<td><br> <b> Password</b></td>
					<td><br> <input type="password"
						placeholder="Enter Password" name="password" required></td>

				</tr>
				<tr>
					<td><br></td>
					<td><br> <br> <br> <input type="submit"
						class="btn_back" style="margin-left: -20px;" value="Back" /> <input
						type="submit" class="btn_login" style="margin-left: 10px;"
						value="login" /></td>
				</tr>

			</table>
			<br>
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
	</form>
</body>
</html>
