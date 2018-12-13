<%@page import="java.math.BigDecimal"%>
<%@ page import="java.sql.*"%>
<%@ page import="bean.Provider.*"%>
<%!static int total_panelty_count;
	static int temp;%>
<%
	String license_number = request.getParameter("license_number");

	session.setAttribute("license_number", license_number);
	String strNew;
	Integer total_number_of_memo = 0;

	if (license_number == null || license_number.trim().equals("")) {
		out.print("<p>Please enter Proper Vehicle Number !!!!</p>");
	} else {

		try {
			Class.forName(bean.Provider.DRIVER);
			String s = license_number.toUpperCase();
			//out.println("-------------> "+s);
			Connection con = DriverManager.getConnection(bean.Provider.CONNECTION_URL, bean.Provider.USERNAME,
					bean.Provider.PASSWORD);
			PreparedStatement ps = con
					.prepareStatement("select * from ememo.owner as oo where upper(oo.owner_license)='"
							+ license_number.toUpperCase() + "'");
			//PreparedStatement ps = con.prepareStatement("select rules_name from ememo.rules where rules_name like '" + name + "%'");
			ResultSet rs = ps.executeQuery();
			Boolean status = rs.next();

			if (status) {
				PreparedStatement ps1 = con.prepareStatement(
						"select upper(concat(vehicle_state,vehicle_city,vehicle_number)) as vehicle_number,rs.rules_name,mm.rules_break_state,mm.rules_break_city,mm.rules_break_place,mm.amount::numeric from ememo.owner as own join ememo.vehicle as veh on(veh.owner_id=own.owner_id)  join ememo.memo as mm on(veh.vehicle_id=mm.vehicle_id)  join ememo.rules as rs on (mm.rules_break_id_1=rs.rules_id) join ememo.payment as pay on(mm.memo_id=pay.memo_id)  where upper(own.owner_license)='"
								+ license_number.toUpperCase() + "' and pay.payment_status='n';");
				ResultSet rs1 = ps1.executeQuery();
				session.setAttribute("rs1", rs1);

				out.println("<br><br><br><table align='center' border='1'>");
				out.println(
						"<tr><td align='center'>Vehicle Number</td><td align='center'>Rules Name</td><td align='center'>Rules Break State</td><td align='center'> Rules break City</td><td align='center'>Ruless Break Place</td><td align='center'>Panelty</td></tr>");

				while (rs1.next()) {

					out.println("<tr><td align='center'>" + rs1.getString(1) + "</td><td align='center'>"
							+ rs1.getString(2) + "</td><td align='center'>" + rs1.getString(3)
							+ "</td><td align='center'>" + rs1.getString(4) + "</td><td align='center'>"
							+ rs1.getString(5) + "</td><td align='center'> " + rs1.getInt(6) + "</td></tr>");

					total_panelty_count += rs1.getInt(6);

					//total_panelty_count = temp +  total_panelty_count;

				}
				out.println("<tr ><td colspan=5 align='center' >TOTAL PANELTY </td><td align='center'><b>"
						+ total_panelty_count + "</b></td></tr>");
				out.println("</table>");
				total_panelty_count = 0;
%>
<BR>
<BR>
<table align="center">
	<tr>
		<td><b>
				<form action="Make_Payment_By_Owner.jsp" method="post">
					<input type="radio" name="payment_type" value="Paytm" checked>
					Paytm<br> <input type="radio" name="payment_type"
						value="Online Banking"> Online Banking<br> <br>
					<input type="submit" value="MAKE PAYMENT">
				</form></td>
	</tr>
</table>
<%
	out.println("<br><a href='check_vehicle_number.jsp'>back.....</a>");

			} else {

				out.println("<b>Wrong License Number.......</b>");
				request.getRequestDispatcher("check_vehicle_number.jsp").include(request, response);

			}

			con.close();
		} catch (Exception e) {
			out.print(e);
		}
	} //end of else
%>

