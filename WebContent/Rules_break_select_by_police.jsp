<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="bean.Provider.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>


<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script>
	
</script>
<title>Drop Downlist</title>
</head>
<body>

	<form action="#" name="rules_break" enctype="multipart/form-data" method="post">
		<%!String state_q = "SELECT * FROM ememo.rules_break_state";
	String city_q = "SELECT * FROM ememo.rules_break_city";
	String place_q = "SELECT * FROM ememo.rules_break_place";
	String rules_q = "select rules_name from ememo.rules";
	String vehicle_q = "SELECT upper(concat(vehicle_state,vehicle_city,vehicle_number)) as v FROM ememo.vehicle";%>
		<%
			PreparedStatement ps = null;
			PreparedStatement ps1 = null;
			PreparedStatement ps2 = null;
			PreparedStatement ps3 = null;
			PreparedStatement ps3_1 = null;
			PreparedStatement ps3_2 = null;
			PreparedStatement ps4 = null;
			try {
				Class.forName(bean.Provider.DRIVER);

				Connection con = DriverManager.getConnection(bean.Provider.CONNECTION_URL, bean.Provider.USERNAME,
						bean.Provider.PASSWORD);
				//state_q = "SELECT * FROM ememo.rules_break_state";
				ps = con.prepareStatement(state_q);
				ps1 = con.prepareStatement(city_q);
				ps2 = con.prepareStatement(place_q);
				ps3 = con.prepareStatement(rules_q);
				ps3_1 = con.prepareStatement(rules_q);
				ps3_2 = con.prepareStatement(rules_q);
				ps4 = con.prepareStatement(vehicle_q);
				ResultSet rs = ps.executeQuery();
				ResultSet rs1 = ps1.executeQuery();
				ResultSet rs2 = ps2.executeQuery();
				ResultSet rs3 = ps3.executeQuery();
				ResultSet rs3_1 = ps3_1.executeQuery();
				ResultSet rs3_2 = ps3_2.executeQuery();
				ResultSet rs4 = ps4.executeQuery();
		%>
		<p>
		
		<br>
			<br>
			<br> 
			Select Rules 1 : <select onchange="hello()"
				name="rules_name_1">
				<option value="-------">-------</option>
				<%
					while (rs3.next()) {
							String fname = rs3.getString("rules_name");
				%>
				<option value="<%=fname%>" name="rules_name_1"><%=fname%></option>
				<%
					}
				%>
			</select>
			<br>
			<br>
			<br> 
			Select Rules 2 : <select onchange="hello()"
				name="rules_name_2">
				<option value="-------">-------</option>
				<%
					while (rs3_1.next()) {
							String fname = rs3_1.getString("rules_name");
				%>
				<option value="<%=fname%>" name="rules_name_2"><%=fname%></option>
				<%
					}
				%>
			</select>
			<br>
			<br>
			<br> 
			Select Rules 3 : <select onchange="hello()"
				name="rules_name_3">
				<option value="-------">-------</option>
				<%
					while (rs3_2.next()) {
							String fname = rs3_2.getString("rules_name");
				%>
				<option value="<%=fname%>" name="rules_name_3"><%=fname%></option>
				<%
					}
				%>
			</select>
			<!-- 	*********************************************************		 -->
			<br>
			<br>
			<br> 
			Select Vehicle Number : <select onchange="hello()"
				name="vehicle_number">
				<option value="-------">-------</option>
				<%
					while (rs4.next()) {
							String fname = rs4.getString("v");
				%>
				<option value="<%=fname%>" name="vehicle_no"><%=fname%></option>
				<%
					}
				%>
			</select>
			
		
		<!-- 	*********************************************************		 -->
			<br>
			<br>
		
		
		
		
			Select State : <select onchange="hello()" name="rules_break_state">
				<option value="-------">-------</option>
				<%
					while (rs.next()) {

							String fname = rs.getString("state");
				%>
				<option value="<%=fname%>" name="state"><%=fname%></option>
				<%
					}
				%>
			</select>
			<!-- 	*********************************************************		 -->
			<br>
			<br>
			<br> Select City : <select onchange="hello()"
				name="rules_break_city">
				<option value="-------">-------</option>
				<%
					while (rs1.next()) {
							String fname = rs1.getString("city");
				%>
				<option value="<%=fname%>" name="city"><%=fname%></option>
				<%
					}
				%>
			</select>
			<!-- 	*********************************************************		 -->
			<br>
			<br>
			<br> Select Place : <select onchange="hello()"
				name="rules_break_place">
				<option value="-------">-------</option>
				<%
					while (rs2.next()) {
							String fname = rs2.getString("place");
				%>
				<option value="<%=fname%>" name="place"><%=fname%></option>
				<%
					}
				%>
			</select>
		</p>
		<%
			} catch (SQLException sqe) {
				out.println(sqe);
			}
		%>

	</form>
</body>
</html>