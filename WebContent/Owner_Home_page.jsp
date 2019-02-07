<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Owner Home Page</title>
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
	margin-left: 25%;
	font-weight: bold;
	width: 50%;
}

.container .btn_login:hover {
	background-color: green;
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

	<%
		session.removeAttribute("license_number");
	%>
	<form action="check_vehicle_number.jsp" method="post" class="container">
		<div align="center">
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<table>
				<tr>
					<td><br> <b> Enter Vehicle Number :</b></td>
					<td><br> <input type="text" name="vehicle_number"
						maxlength="10" required="required" placeholder="GJ01SA2339">
					</td>

				</tr>
				<tr>
					<td><br></td>
					<td><br>
					<br> <input type="submit" value="Check" class="btn_login">


					</td>
				</tr>

			</table>
		</div>
	</form>

</body>
</html>
