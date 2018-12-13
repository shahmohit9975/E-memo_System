<%@ page import="java.sql.*"%>
<%@ page import="bean.Provider.*"%>
<%
	String name = request.getParameter("val");
	if (name == null || name.trim().equals("")) {
		out.print("<p>Please enter rules name!</p>");
	} else {

		try {
			Class.forName(bean.Provider.DRIVER);
			String s = name.toLowerCase();
			//out.println("-------------> "+s);
			Connection con = DriverManager.getConnection(bean.Provider.CONNECTION_URL, bean.Provider.USERNAME,
					bean.Provider.PASSWORD);
			PreparedStatement ps = con.prepareStatement(
					"select rules_id,lower(rules_name) from ememo.rules where lower(rules_name) like '%"
							+ s.toLowerCase() + "%'");

			ResultSet rs = ps.executeQuery();

			if (!rs.isBeforeFirst()) {
				out.println("<p>No Record Found!!!!</p>");
			} else {
				out.print("<table border='3'  width='80%'>");
				out.print("<tr><th>RULES ID'S...</th><th>RULES NAMES...</th></tr>");
				while (rs.next()) {
					out.print("<tr><td>" + rs.getInt(1) + "</td><td>" + rs.getString(2) + "</td></tr>");
				}
				out.print("</table>");
			} //end of else for rs.isBeforeFirst  
			con.close();
		} catch (Exception e) {
			out.print(e);
		}
	} //end of else
%>
