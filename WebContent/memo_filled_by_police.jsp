<%@page import="com.itextpdf.text.log.SysoCounter"%>
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
		System.out.println("IN&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
	%>
	<%
		// 		String rules_name = (String) session.getAttribute("rules_name");
		// 		String vehicle_number = (String) session.getAttribute("vehicle_number");

		String memo_filled_by_ass = (String) session.getAttribute("memo_filled_by_police");
		String rules_break_state = (String) session.getAttribute("rules_break_state");
		String rules_break_city = (String) session.getAttribute("rules_break_city");
		String rules_break_place = (String) session.getAttribute("rules_break_place");
		Integer total_panelty = (Integer) (session.getAttribute("panelty"));
		Integer rules_id_1 = (Integer) session.getAttribute("rules_id_1");
		Integer rules_id_2 = (Integer) session.getAttribute("rules_id_2");
		Integer rules_id_3 = (Integer) session.getAttribute("rules_id_3");

		Integer vehicle_id = (Integer) session.getAttribute("vehicle_id");
		Integer memo_filled_by_id_police = (Integer) session.getAttribute("memo_filled_by_id_police");

		System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
		System.out.println("1.vehicle_id------> " + vehicle_id);
		System.out.println("2.panelty-------> " + total_panelty);
		System.out.println("3.rules_break_state-------> " + rules_break_state);
		System.out.println("4.rules_break_city-------> " + rules_break_city);
		System.out.println("5.rules_break_place-------> " + rules_break_place);
		System.out.println("6.rules_id_1------> " + rules_id_1);
		System.out.println("7.rules_id_2------> " + rules_id_2);
		System.out.println("8.rules_id_3------> " + rules_id_3);
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

		// ALL 1 2 3
		if (rules_id_1 != null && rules_id_2 != null && rules_id_3 != null) {

			System.out.print("ALL 1 2 3\n\n");
			System.out.print(memo_filled_by_id_police + " -> " + ourJavaTimestampObject);
			System.out.print("ALL 1 2 3\n\n");

			String sql = "INSERT INTO ememo.memo(memo_filled_by_id,memo_filled_by,rules_break_id_1,rules_break_id_2,rules_break_id_3,vehicle_id,amount,memo_date,rules_break_state,rules_break_city,rules_break_place) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

			try {
				con.setAutoCommit(false);
				System.out.println("1111111111111111111111111111111");
				stmt = con.prepareStatement(sql);
				System.out.println("1111111111111111111111111111111");
				stmt.setInt(1, memo_filled_by_id_police);
				System.out.println("1111111111111111111111111111111");
				stmt.setString(2, "p");
				System.out.println("1111111111111111111111111111111");
				stmt.setInt(3, rules_id_1);
				stmt.setInt(4, rules_id_2);
				stmt.setInt(5, rules_id_3);
				stmt.setInt(6, vehicle_id);
				stmt.setInt(7, total_panelty);
				stmt.setTimestamp(8, ourJavaTimestampObject);
				stmt.setString(9, rules_break_state);
				stmt.setString(10, rules_break_city);
				stmt.setString(11, rules_break_place);

				stmt.executeUpdate();

				con.setAutoCommit(true);

				stmt.close();
				System.out.println("Table Records Inserted successfully");
				request.getRequestDispatcher("Payment_Generate_by_police").forward(request, response);

			} catch (Exception e) {
				session.removeAttribute("memo_filled_by_id_police");
				session.removeAttribute("memo_filled_by_police");
				session.removeAttribute("rules_break_state");
				session.removeAttribute("rules_break_city");
				session.removeAttribute("rules_break_place");
				session.removeAttribute("panelty");
				session.removeAttribute("rules_id_1");
				session.removeAttribute("rules_id_2");
				session.removeAttribute("rules_id_3");
				session.removeAttribute("vehicle_id");
				session.removeAttribute("memo_id");
				session.removeAttribute("ourJavaTimestampObject");
				e.printStackTrace();
				System.err.println(e.getClass().getName() + ": " + e.getMessage());
				System.exit(0);
			}
		}
		//ONLY 1
		else if (rules_id_1 != null && rules_id_2 == null && rules_id_3 == null) {
			System.out.print("ONLY 1");

			String sql = "INSERT INTO ememo.memo(memo_filled_by_id,memo_filled_by,rules_break_id_1,vehicle_id,amount,memo_date,rules_break_state,rules_break_city,rules_break_place) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

			try {
				con.setAutoCommit(false);

				stmt = con.prepareStatement(sql);
				stmt.setInt(1, memo_filled_by_id_police);
				stmt.setString(2, "p");
				stmt.setInt(3, rules_id_1);
				stmt.setInt(4, vehicle_id);
				stmt.setInt(5, total_panelty);
				stmt.setTimestamp(6, ourJavaTimestampObject);
				stmt.setString(7, rules_break_state);
				stmt.setString(8, rules_break_city);
				stmt.setString(9, rules_break_place);

				stmt.executeUpdate();

				con.setAutoCommit(true);

				stmt.close();
				System.out.println("Table Records Inserted successfully");
				request.getRequestDispatcher("Payment_Generate_by_police").forward(request, response);

			} catch (Exception e) {
				session.removeAttribute("memo_filled_by_id_police");
				session.removeAttribute("memo_filled_by_police");
				session.removeAttribute("rules_break_state");
				session.removeAttribute("rules_break_city");
				session.removeAttribute("rules_break_place");
				session.removeAttribute("panelty");
				session.removeAttribute("rules_id_1");
				session.removeAttribute("rules_id_2");
				session.removeAttribute("rules_id_3");
				session.removeAttribute("vehicle_id");
				session.removeAttribute("memo_id");
				session.removeAttribute("ourJavaTimestampObject");
				e.printStackTrace();
				System.err.println(e.getClass().getName() + ": " + e.getMessage());
				System.exit(0);
			}

		}
		//ONLY 2
		else if (rules_id_1 == null && rules_id_2 != null && rules_id_3 == null) {

			System.out.print("ONLY 2");
			String sql = "INSERT INTO ememo.memo(memo_filled_by_id,memo_filled_by,rules_break_id_2,vehicle_id,amount,memo_date,rules_break_state,rules_break_city,rules_break_place) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

			try {
				con.setAutoCommit(false);

				stmt = con.prepareStatement(sql);
				stmt.setInt(1, memo_filled_by_id_police);
				stmt.setString(2, "p");
				stmt.setInt(3, rules_id_2);
				stmt.setInt(4, vehicle_id);
				stmt.setInt(5, total_panelty);
				stmt.setTimestamp(6, ourJavaTimestampObject);
				stmt.setString(7, rules_break_state);
				stmt.setString(8, rules_break_city);
				stmt.setString(9, rules_break_place);

				stmt.executeUpdate();

				con.setAutoCommit(true);

				stmt.close();
				System.out.println("Table Records Inserted successfully");
				request.getRequestDispatcher("Payment_Generate_by_police").forward(request, response);

			} catch (Exception e) {
				session.removeAttribute("memo_filled_by_id_police");
				session.removeAttribute("memo_filled_by_police");
				session.removeAttribute("rules_break_state");
				session.removeAttribute("rules_break_city");
				session.removeAttribute("rules_break_place");
				session.removeAttribute("panelty");
				session.removeAttribute("rules_id_1");
				session.removeAttribute("rules_id_2");
				session.removeAttribute("rules_id_3");
				session.removeAttribute("vehicle_id");
				session.removeAttribute("memo_id");
				session.removeAttribute("ourJavaTimestampObject");
				e.printStackTrace();
				System.err.println(e.getClass().getName() + ": " + e.getMessage());
				System.exit(0);
			}

		}
		//ONLY 3
		else if (rules_id_1 == null && rules_id_2 == null && rules_id_3 != null) {
			System.out.print("ONLY 3");

			String sql = "INSERT INTO ememo.memo(memo_filled_by_id,memo_filled_by,rules_break_id_3,vehicle_id,amount,memo_date,rules_break_state,rules_break_city,rules_break_place) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

			try {
				con.setAutoCommit(false);

				stmt = con.prepareStatement(sql);
				stmt.setInt(1, memo_filled_by_id_police);
				stmt.setString(2, "p");
				stmt.setInt(3, rules_id_3);
				stmt.setInt(4, vehicle_id);
				stmt.setInt(5, total_panelty);
				stmt.setTimestamp(6, ourJavaTimestampObject);
				stmt.setString(7, rules_break_state);
				stmt.setString(8, rules_break_city);
				stmt.setString(9, rules_break_place);

				stmt.executeUpdate();

				con.setAutoCommit(true);

				stmt.close();
				System.out.println("Table Records Inserted successfully");
				request.getRequestDispatcher("Payment_Generate_by_police").forward(request, response);

			} catch (Exception e) {
				session.removeAttribute("memo_filled_by_id_police");
				session.removeAttribute("memo_filled_by_police");
				session.removeAttribute("rules_break_state");
				session.removeAttribute("rules_break_city");
				session.removeAttribute("rules_break_place");
				session.removeAttribute("panelty");
				session.removeAttribute("rules_id_1");
				session.removeAttribute("rules_id_2");
				session.removeAttribute("rules_id_3");
				session.removeAttribute("vehicle_id");
				session.removeAttribute("memo_id");
				session.removeAttribute("ourJavaTimestampObject");
				e.printStackTrace();
				System.err.println(e.getClass().getName() + ": " + e.getMessage());
				System.exit(0);
			}

		}
		//BOTH 1 & 2 RULES ID  ARE NOT NULL
		else if (rules_id_1 != null && rules_id_2 != null && rules_id_3 == null) {

			System.out.print("both 1 2");

			String sql = "INSERT INTO ememo.memo(memo_filled_by_id,memo_filled_by,rules_break_id_1,rules_break_id_2,vehicle_id,amount,memo_date,rules_break_state,rules_break_city,rules_break_place) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

			try {
				con.setAutoCommit(false);

				stmt = con.prepareStatement(sql);
				stmt.setInt(1, memo_filled_by_id_police);
				stmt.setString(2, "p");
				stmt.setInt(3, rules_id_1);
				stmt.setInt(4, rules_id_2);
				stmt.setInt(5, vehicle_id);
				stmt.setInt(6, total_panelty);
				stmt.setTimestamp(7, ourJavaTimestampObject);
				stmt.setString(8, rules_break_state);
				stmt.setString(9, rules_break_city);
				stmt.setString(10, rules_break_place);

				stmt.executeUpdate();

				con.setAutoCommit(true);

				stmt.close();
				System.out.println("Table Records Inserted successfully");
				request.getRequestDispatcher("Payment_Generate_by_police").forward(request, response);

			} catch (Exception e) {
				session.removeAttribute("memo_filled_by_id_police");
				session.removeAttribute("memo_filled_by_police");
				session.removeAttribute("rules_break_state");
				session.removeAttribute("rules_break_city");
				session.removeAttribute("rules_break_place");
				session.removeAttribute("panelty");
				session.removeAttribute("rules_id_1");
				session.removeAttribute("rules_id_2");
				session.removeAttribute("rules_id_3");
				session.removeAttribute("vehicle_id");
				session.removeAttribute("memo_id");
				session.removeAttribute("ourJavaTimestampObject");
				e.printStackTrace();
				System.err.println(e.getClass().getName() + ": " + e.getMessage());
				System.exit(0);
			}

		}
		//BOTH 1 & 3 RULES ID  ARE NOT NULL
		else if (rules_id_1 != null && rules_id_2 == null && rules_id_3 != null) {

			System.out.print("both 1 3");
			String sql = "INSERT INTO ememo.memo(memo_filled_by_id,memo_filled_by,rules_break_id_1,rules_break_id_3,vehicle_id,amount,memo_date,rules_break_state,rules_break_city,rules_break_place) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

			try {
				con.setAutoCommit(false);

				stmt = con.prepareStatement(sql);
				stmt.setInt(1, memo_filled_by_id_police);
				stmt.setString(2, "p");
				stmt.setInt(3, rules_id_1);
				stmt.setInt(4, rules_id_3);
				stmt.setInt(5, vehicle_id);
				stmt.setInt(6, total_panelty);
				stmt.setTimestamp(7, ourJavaTimestampObject);
				stmt.setString(8, rules_break_state);
				stmt.setString(9, rules_break_city);
				stmt.setString(10, rules_break_place);

				stmt.executeUpdate();

				con.setAutoCommit(true);

				stmt.close();
				System.out.println("Table Records Inserted successfully");
				request.getRequestDispatcher("Payment_Generate_by_police").forward(request, response);

			} catch (Exception e) {
				session.removeAttribute("memo_filled_by_id_police");
				session.removeAttribute("memo_filled_by_police");
				session.removeAttribute("rules_break_state");
				session.removeAttribute("rules_break_city");
				session.removeAttribute("rules_break_place");
				session.removeAttribute("panelty");
				session.removeAttribute("rules_id_1");
				session.removeAttribute("rules_id_2");
				session.removeAttribute("rules_id_3");
				session.removeAttribute("vehicle_id");
				session.removeAttribute("memo_id");
				session.removeAttribute("ourJavaTimestampObject");
				e.printStackTrace();
				System.err.println(e.getClass().getName() + ": " + e.getMessage());
				System.exit(0);
			}

		}

		//BOTH 2 & 3 RULES ID  ARE NOT NULL

		else if (rules_id_1 == null && rules_id_2 != null && rules_id_3 != null) {
			System.out.print("both 2 3");

			String sql = "INSERT INTO ememo.memo(memo_filled_by_id,memo_filled_by,rules_break_id_2,rules_break_id_3,vehicle_id,amount,memo_date,rules_break_state,rules_break_city,rules_break_place) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

			try {
				con.setAutoCommit(false);

				stmt = con.prepareStatement(sql);
				stmt.setInt(1, memo_filled_by_id_police);
				stmt.setString(2, "p");
				stmt.setInt(3, rules_id_2);
				stmt.setInt(4, rules_id_3);
				stmt.setInt(5, vehicle_id);
				stmt.setInt(6, total_panelty);
				stmt.setTimestamp(7, ourJavaTimestampObject);
				stmt.setString(8, rules_break_state);
				stmt.setString(9, rules_break_city);
				stmt.setString(10, rules_break_place);

				stmt.executeUpdate();

				con.setAutoCommit(true);

				stmt.close();
				System.out.println("Table Records Inserted successfully");
				request.getRequestDispatcher("Payment_Generate_by_police").forward(request, response);

			} catch (Exception e) {
				session.removeAttribute("memo_filled_by_id_police");
				session.removeAttribute("memo_filled_by_police");
				session.removeAttribute("rules_break_state");
				session.removeAttribute("rules_break_city");
				session.removeAttribute("rules_break_place");
				session.removeAttribute("panelty");
				session.removeAttribute("rules_id_1");
				session.removeAttribute("rules_id_2");
				session.removeAttribute("rules_id_3");
				session.removeAttribute("vehicle_id");
				session.removeAttribute("memo_id");
				session.removeAttribute("ourJavaTimestampObject");
				e.printStackTrace();
				System.err.println(e.getClass().getName() + ": " + e.getMessage());
				System.exit(0);
			}

		}

		// ALL RULES ID ARE NULLLLLL
		else {

			System.out.print("allllllll");
			session.removeAttribute("rules_break_state");
			session.removeAttribute("rules_break_city");
			session.removeAttribute("rules_break_place");
			session.removeAttribute("panelty");
			session.removeAttribute("rules_id_1");
			session.removeAttribute("rules_id_2");
			session.removeAttribute("rules_id_3");
			session.removeAttribute("vehicle_id");
			//session.removeAttribute("memo_id");
			session.removeAttribute("ourJavaTimestampObject");
			out.println("PLEASE SELECT AT LEAST ONE RULE......");
			request.getRequestDispatcher("Police_home_page.jsp").forward(request, response);

		}
	%>

</body>
</html>