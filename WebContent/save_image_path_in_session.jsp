<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>mohit</title>
</head>
<body>


	<%
		System.out.println("******************************************************* ");
		String img_path = request.getParameter("img_path");

		System.out.println("******************************************************* ");
		System.out.println("-------> " + img_path);

		String new_path = img_path.replace(",", "/");
		System.out.println("-------> " + new_path);

		int index = new_path.indexOf('/', 0);
		char[] img_path_char = new_path.toCharArray();
		img_path_char[index] = '%';
		img_path = String.valueOf(img_path_char);

		System.out.println("1 NEW img_path " + img_path);
		img_path = img_path.replace("%", "//");
		System.out.println("2 NEW img_path " + img_path);

		StringBuffer sb = new StringBuffer(img_path);

		System.out.println(sb.length());//prints Hlo
		sb.delete(sb.length() - 1, sb.length());

		System.out.println(sb);//prints Hlo 
		//img_path=sb;
		session.setAttribute("img_path", sb);
	%>
</body>
</html>