<%@page import="bean.LoginDao_for_assistance"%>
<%@page import="bean.LoginDao_for_police"%>
<%@page import="bean.LoginDao_for_admin"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="bean.LoginDao_for_admin"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<jsp:useBean id="obj" class="bean.LoginBean" />
	<%
		Integer id = Integer.parseInt(request.getParameter("id"));
		String password = request.getParameter("password");
		obj.setId(id);
		obj.setPassword(password);
	%>
	<%-- 	<jsp:setProperty property="*" name="obj" /> --%>

	<%
		String user = request.getParameter("user");
		if (user.equals("admin")) {

			boolean status = LoginDao_for_admin.validate(obj);
			if (status) {
				out.println("You r successfully logged in");
				session.setAttribute("session", "TRUE");
			} else {
				RequestDispatcher rd = request.getRequestDispatcher("Login_Admin.jsp");
				rd.include(request, response);
				out.print("Sorry, Id or Password Incorrect");
				
			}

		} else if (user.equals("police")) {

			boolean status = LoginDao_for_police.validate(obj);
			if (status) {
				out.println("You r successfully logged in");
				session.setAttribute("memo_filled_by_police", "p");
				session.setAttribute("memo_filled_by_id_police", id);
				session.setAttribute("session", "TRUE");
				response.sendRedirect("Police_home_page.jsp");
			} else {

				out.print("Sorry, Id or Password Incorrect");

				RequestDispatcher rd = request.getRequestDispatcher("Login_Police.jsp");
				rd.include(request, response);
			}
		} else if (user.equals("assistance")) {
			boolean status = LoginDao_for_assistance.validate(obj);
			if (status) {
				out.println("You r successfully logged in");
				session.setAttribute("memo_filled_by_ass", "a");
				session.setAttribute("memo_filled_by_id_ass", id);
				response.sendRedirect("Assistance_Home_page.jsp");
			} else {
				out.print("Sorry, Id or Password Incorrect");

				RequestDispatcher rd = request.getRequestDispatcher("Login_Assistance.jsp");
				rd.include(request, response);

			}

		}
	%>

</body>
</html>