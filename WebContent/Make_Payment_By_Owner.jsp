<%@page import="java.math.BigDecimal"%>
<%@ page import="java.sql.*"%>
<%@ page import="bean.Provider.*"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.Month"%>
<%@ page import="java.time.ZoneId"%>
<%@ page import="java.util.Calendar"%>
<%!static int total_panelty_count;
	static int temp;%>
<%
	String license_number = (String) session.getAttribute("license_number");

	String payment_type = (String) request.getParameter("payment_type");
	//##########################################################	
	//session.setAttribute("license_number", license_number);
	String strNew;
	Integer total_number_of_memo = 0;
	Calendar calendar = Calendar.getInstance();
	java.sql.Timestamp time = new java.sql.Timestamp(calendar.getTime().getTime());

	if (license_number == null || license_number.trim().equals("")) {
		out.print("<p>Please enter Proper Vehicle Number !!!!</p>");
	} else {

		try {
			Class.forName(bean.Provider.DRIVER);

			Connection con = DriverManager.getConnection(bean.Provider.CONNECTION_URL, bean.Provider.USERNAME,
					bean.Provider.PASSWORD);

			if (true) {
				PreparedStatement ps1 = con.prepareStatement(
						"select pay.memo_id , pay.payment_id from ememo.owner as own join ememo.vehicle as veh on(veh.owner_id=own.owner_id)  join ememo.memo as mm on(veh.vehicle_id=mm.vehicle_id)  join ememo.rules as rs on (mm.rules_break_id_1=rs.rules_id) join ememo.payment as pay on(mm.memo_id=pay.memo_id)  where upper(own.owner_license)='"
								+ license_number.toUpperCase() + "' and pay.payment_status='n';");
				ResultSet rs1 = ps1.executeQuery();

				while (rs1.next()) {

					PreparedStatement ps2 = con.prepareStatement(
							"UPDATE ememo.payment SET payment_status='y',payment_mode='" + payment_type
									+ "' ,payment_time='" + time + "' WHERE memo_id=" + rs1.getInt(1));
					ps2.executeUpdate();

				}

			}

			session.removeAttribute("license_number");
			session.removeAttribute("vehicle_number");

			out.println("<h1 align='center'>YOUR PAYMENT IS DONE....</h1>");
			con.close();
		} catch (Exception e) {
			out.print(e);
		}
	} //end of else
%>

