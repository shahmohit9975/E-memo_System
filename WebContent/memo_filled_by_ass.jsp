<%@page import="java.math.BigDecimal"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.Month"%>
<%@ page import="java.time.ZoneId"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.sql.*"%>
<%@ page import="bean.Provider.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		
	%>
	<%
		String memo_filled_by_ass = (String) session.getAttribute("memo_filled_by_ass");
		String rules_break_state = (String) session.getAttribute("rules_break_state");
		String rules_break_city = (String) session.getAttribute("rules_break_city");
		String rules_break_place = (String) session.getAttribute("rules_break_place");
		BigDecimal total_panelty = (BigDecimal) (session.getAttribute("panelty"));
		Integer rules_id = (Integer) session.getAttribute("rules_id");
		Integer vehicle_id = (Integer) session.getAttribute("vehicle_id");
		Integer memo_filled_by_id_ass = (Integer) session.getAttribute("memo_filled_by_id_ass");

		System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
		System.out.println("1.vehicle_id------> " + vehicle_id);
		System.out.println("2.panelty-------> " + total_panelty);
		System.out.println("3.rules_break_state-------> " + rules_break_state);
		System.out.println("4.rules_break_city-------> " + rules_break_city);
		System.out.println("5.rules_break_place-------> " + rules_break_place);
		System.out.println("6.rules_id------> " + rules_id);
		System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");

		Calendar calendar = Calendar.getInstance();
		java.sql.Timestamp ourJavaTimestampObject = new java.sql.Timestamp(calendar.getTime().getTime());

		session.setAttribute("ourJavaTimestampObject", ourJavaTimestampObject);
	%>

	<%
		Class.forName(bean.Provider.DRIVER);

		Connection con = DriverManager.getConnection(bean.Provider.CONNECTION_URL, bean.Provider.USERNAME,
				bean.Provider.PASSWORD);
		PreparedStatement stmt = null;
		String sql = "INSERT INTO ememo.memo(memo_filled_by_id,memo_filled_by,rules_break_id_1,vehicle_id,amount,memo_date,rules_break_state,rules_break_city,rules_break_place) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

		try {
			con.setAutoCommit(false);

			stmt = con.prepareStatement(sql);
			stmt.setInt(1, memo_filled_by_id_ass);
			stmt.setString(2, "a");
			stmt.setInt(3, rules_id);
			stmt.setInt(4, vehicle_id);
			stmt.setBigDecimal(5, total_panelty);
			stmt.setTimestamp(6, ourJavaTimestampObject);
			stmt.setString(7, rules_break_state);
			stmt.setString(8, rules_break_city);
			stmt.setString(9, rules_break_place);

			stmt.executeUpdate();

			con.setAutoCommit(true);

			stmt.close();
			System.out.println("Table Records Inserted successfully");
			request.getRequestDispatcher("Payment_Generate_by_Ass").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			System.err.println(e.getClass().getName() + ": " + e.getMessage());
			System.exit(0);
		}
	%>

</body>
</html>