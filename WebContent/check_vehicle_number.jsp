<%@ page import="java.sql.*"%>
<%@ page import="bean.Provider.*"%>
<%
	String vehicle_number = request.getParameter("vehicle_number");
	if (vehicle_number == null) {

		vehicle_number = (String) session.getAttribute("vehicle_number");
		//out.print(vehicle_number);

	} else {

		out.println(vehicle_number);
		session.setAttribute("vehicle_number", vehicle_number);

	}
	String strNew;
	Integer total_number_of_memo = 0;
	if (vehicle_number.charAt(2) == '0') {

		strNew = vehicle_number.replaceFirst("0", "");
		vehicle_number = strNew;

	}

	if (vehicle_number == null || vehicle_number.trim().equals("")) {
		out.print("<p>Please enter Proper Vehicle Number !!!!</p>");
	} else {

		try {
			Class.forName(bean.Provider.DRIVER);
			String s = vehicle_number.toLowerCase();
			//out.println("-------------> "+s);
			Connection con = DriverManager.getConnection(bean.Provider.CONNECTION_URL, bean.Provider.USERNAME,
					bean.Provider.PASSWORD);
			PreparedStatement ps = con.prepareStatement(
					"select count(pp.payment_id) from ememo.vehicle as vv join ememo.memo as mm on(vv.vehicle_id=mm.vehicle_id) join ememo.payment as pp on(mm.memo_id=pp.memo_id) where upper(concat(vehicle_state,vehicle_city,vehicle_number))='"
							+ vehicle_number.toUpperCase() + "' and pp.payment_status='n' ;");

			ResultSet rs = ps.executeQuery();

			if (!rs.isBeforeFirst()) {
				out.println("<p>No Record Found!!!!</p>");
			} else {
				out.print("<table border='2' align='center' width='15%'>");
				out.print("<tr><th>TOTAL MEMO...</th></tr>");
				while (rs.next()) {
					total_number_of_memo = rs.getInt(1);
					out.print("<tr><td align='center'>" + rs.getInt(1) + "</td></tr>");
				}
				out.print("</table>");
			}
			if (total_number_of_memo > 0) {

				out.println(
						"<br><form action='license_check.jsp' method='post'><table border='1' align='center' width='30%'><tr><td>Enter Your License Number : </td><td><input type='text' name='license_number' maxlength='6' value='");
%>${sessionScope.license_number}<%
	out.print(
						"'</td></tr><tr><td></td><td align='center'><input type='submit' value='Check'></td></tr></table></form>");

			}
			ps.close();

		} catch (Exception e) {
			out.print(e);
		}
	} //end of else
%>
