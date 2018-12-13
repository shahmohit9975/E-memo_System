package bean;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Payment_Generate_by_Ass
 */
public class Payment_Generate_by_police extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Payment_Generate_by_police() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Serve d at: ").append(request.getContextPath());
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		PrintWriter out = response.getWriter();
		Integer memo_id = null;

		Statement stmt = null;
		PreparedStatement stmt1 = null;
		HttpSession session = request.getSession();
		Integer rules_id_1 = (Integer) session.getAttribute("rules_id_1");
		Integer rules_id_2 = (Integer) session.getAttribute("rules_id_2");
		Integer rules_id_3 = (Integer) session.getAttribute("rules_id_3");

		// ALL 1 2 3
		if (rules_id_1 != null && rules_id_2 != null && rules_id_3 != null) {
			try {

				String memo_filled_by_police = (String) session.getAttribute("memo_filled_by_police");
				String rules_break_state = (String) session.getAttribute("rules_break_state");
				String rules_break_city = (String) session.getAttribute("rules_break_city");
				String rules_break_place = (String) session.getAttribute("rules_break_place");
				Integer total_panelty = (Integer) (session.getAttribute("panelty"));
				Integer vehicle_id = (Integer) session.getAttribute("vehicle_id");

				Timestamp ourJavaTimestampObject = (Timestamp) session.getAttribute("ourJavaTimestampObject");

				Integer memo_filled_by_id_police = (Integer) session.getAttribute("memo_filled_by_id_police");

				Connection con = ConnectionProvider.getCon();
				stmt = con.createStatement();

				ResultSet rs = stmt.executeQuery(" Select memo_id from ememo.memo where memo_filled_by_id="
						+ memo_filled_by_id_police + " and memo_filled_by='" + memo_filled_by_police
						+ "' and rules_break_id_1=" + rules_id_1 + " and rules_break_id_2= " + rules_id_2
						+ " and rules_break_id_3= " + rules_id_3 + " and vehicle_id=" + vehicle_id
						+ " and amount::numeric=" + total_panelty + " and memo_date='" + ourJavaTimestampObject
						+ "' and rules_break_state='" + rules_break_state + "' and rules_break_city='"
						+ rules_break_city + "' and rules_break_place='" + rules_break_place + "'");

				while (rs.next()) {

					memo_id = rs.getInt("memo_id");
				}

				System.out.println("MEMO ID : " + memo_id);
				session.setAttribute("memo_id", memo_id);

			} catch (Exception e) {

				e.printStackTrace();

				System.out.println(e.getMessage());

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
			}

			try {
				Connection con1 = ConnectionProvider.getCon();
				String sql_payment = "INSERT INTO ememo.payment(memo_id) VALUES (?)";
				stmt1 = con1.prepareStatement(sql_payment);
				System.out.println("PPPPAAAAYYYYMMMMEEENNNNNTTT");

				con1.setAutoCommit(false);
				stmt1.setInt(1, memo_id);

				stmt1.executeUpdate();
				con1.setAutoCommit(true);
				stmt1.close();

				System.out.println("Table PAyment Record Inserted successfully");
				request.getRequestDispatcher("PDF_GERERATE_by_police.jsp").forward(request, response);
				session.removeAttribute("rules_break_state");
				session.removeAttribute("rules_break_city");
				session.removeAttribute("rules_break_place");
				session.removeAttribute("panelty");
				session.removeAttribute("rules_id_1");
				session.removeAttribute("rules_id_2");
				session.removeAttribute("rules_id_3");
				session.removeAttribute("vehicle_id");

				session.removeAttribute("ourJavaTimestampObject");

				out.println("Success...");

			} catch (Exception e) {

				e.printStackTrace();

				System.out.println(e.getMessage());

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
			}

		}
		// ONLY 1
		else if (rules_id_1 != null && rules_id_2 == null && rules_id_3 == null) {

			try {

				String memo_filled_by_police = (String) session.getAttribute("memo_filled_by_police");
				String rules_break_state = (String) session.getAttribute("rules_break_state");
				String rules_break_city = (String) session.getAttribute("rules_break_city");
				String rules_break_place = (String) session.getAttribute("rules_break_place");
				Integer total_panelty = (Integer) (session.getAttribute("panelty"));
				Integer vehicle_id = (Integer) session.getAttribute("vehicle_id");

				Timestamp ourJavaTimestampObject = (Timestamp) session.getAttribute("ourJavaTimestampObject");

				Integer memo_filled_by_id_police = (Integer) session.getAttribute("memo_filled_by_id_police");

				Connection con = ConnectionProvider.getCon();
				stmt = con.createStatement();

				ResultSet rs = stmt.executeQuery(" Select memo_id from ememo.memo where memo_filled_by_id="
						+ memo_filled_by_id_police + " and memo_filled_by='" + memo_filled_by_police
						+ "' and rules_break_id_1=" + rules_id_1 + " and vehicle_id=" + vehicle_id
						+ " and amount::numeric=" + total_panelty + " and memo_date='" + ourJavaTimestampObject
						+ "' and rules_break_state='" + rules_break_state + "' and rules_break_city='"
						+ rules_break_city + "' and rules_break_place='" + rules_break_place + "'");

				while (rs.next()) {

					memo_id = rs.getInt("memo_id");
				}

				System.out.println("MEMO ID : " + memo_id);
				session.setAttribute("memo_id", memo_id);

			} catch (Exception e) {

				e.printStackTrace();

				System.out.println(e.getMessage());

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
			}

			try {
				Connection con1 = ConnectionProvider.getCon();
				String sql_payment = "INSERT INTO ememo.payment(memo_id) VALUES (?)";
				stmt1 = con1.prepareStatement(sql_payment);

				con1.setAutoCommit(false);
				stmt1.setInt(1, memo_id);

				stmt1.executeUpdate();
				con1.setAutoCommit(true);
				stmt1.close();

				request.getRequestDispatcher("PDF_GERERATE_by_police.jsp").forward(request, response);
				session.removeAttribute("rules_break_state");
				session.removeAttribute("rules_break_city");
				session.removeAttribute("rules_break_place");
				session.removeAttribute("panelty");
				session.removeAttribute("rules_id_1");
				session.removeAttribute("rules_id_2");
				session.removeAttribute("rules_id_3");
				session.removeAttribute("vehicle_id");

				session.removeAttribute("ourJavaTimestampObject");
				out.println("Success...");

			} catch (Exception e) {

				e.printStackTrace();

				System.out.println(e.getMessage());

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
			}

		}
		// ONLY 2
		else if (rules_id_1 == null && rules_id_2 != null && rules_id_3 == null) {

			try {

				String memo_filled_by_police = (String) session.getAttribute("memo_filled_by_police");
				String rules_break_state = (String) session.getAttribute("rules_break_state");
				String rules_break_city = (String) session.getAttribute("rules_break_city");
				String rules_break_place = (String) session.getAttribute("rules_break_place");
				Integer total_panelty = (Integer) (session.getAttribute("panelty"));
				Integer vehicle_id = (Integer) session.getAttribute("vehicle_id");

				Timestamp ourJavaTimestampObject = (Timestamp) session.getAttribute("ourJavaTimestampObject");

				Integer memo_filled_by_id_police = (Integer) session.getAttribute("memo_filled_by_id_police");

				Connection con = ConnectionProvider.getCon();
				stmt = con.createStatement();

				ResultSet rs = stmt.executeQuery(" Select memo_id from ememo.memo where memo_filled_by_id="
						+ memo_filled_by_id_police + " and memo_filled_by='" + memo_filled_by_police
						+ "' and rules_break_id_2= " + rules_id_2 + " and vehicle_id=" + vehicle_id
						+ " and amount::numeric=" + total_panelty + " and memo_date='" + ourJavaTimestampObject
						+ "' and rules_break_state='" + rules_break_state + "' and rules_break_city='"
						+ rules_break_city + "' and rules_break_place='" + rules_break_place + "'");

				while (rs.next()) {

					memo_id = rs.getInt("memo_id");
				}

				System.out.println("MEMO ID : " + memo_id);
				session.setAttribute("memo_id", memo_id);

			} catch (Exception e) {

				e.printStackTrace();

				System.out.println(e.getMessage());

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
			}

			try {
				Connection con1 = ConnectionProvider.getCon();
				String sql_payment = "INSERT INTO ememo.payment(memo_id) VALUES (?)";
				stmt1 = con1.prepareStatement(sql_payment);
				System.out.println("PPPPAAAAYYYYMMMMEEENNNNNTTT");

				con1.setAutoCommit(false);
				stmt1.setInt(1, memo_id);

				stmt1.executeUpdate();
				con1.setAutoCommit(true);
				stmt1.close();

				System.out.println("Table PAyment Record Inserted successfully");
				request.getRequestDispatcher("PDF_GERERATE_by_police.jsp").forward(request, response);
				session.removeAttribute("rules_break_state");
				session.removeAttribute("rules_break_city");
				session.removeAttribute("rules_break_place");
				session.removeAttribute("panelty");
				session.removeAttribute("rules_id_1");
				session.removeAttribute("rules_id_2");
				session.removeAttribute("rules_id_3");
				session.removeAttribute("vehicle_id");

				session.removeAttribute("ourJavaTimestampObject");
				out.println("Success...");

			} catch (Exception e) {

				e.printStackTrace();

				System.out.println(e.getMessage());

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
			}

		}
		// ONLY 3
		else if (rules_id_1 == null && rules_id_2 == null && rules_id_3 != null) {

			try {

				String memo_filled_by_police = (String) session.getAttribute("memo_filled_by_police");
				String rules_break_state = (String) session.getAttribute("rules_break_state");
				String rules_break_city = (String) session.getAttribute("rules_break_city");
				String rules_break_place = (String) session.getAttribute("rules_break_place");
				Integer total_panelty = (Integer) (session.getAttribute("panelty"));
				Integer vehicle_id = (Integer) session.getAttribute("vehicle_id");

				Timestamp ourJavaTimestampObject = (Timestamp) session.getAttribute("ourJavaTimestampObject");

				Integer memo_filled_by_id_police = (Integer) session.getAttribute("memo_filled_by_id_police");

				Connection con = ConnectionProvider.getCon();
				stmt = con.createStatement();

				ResultSet rs = stmt.executeQuery(" Select memo_id from ememo.memo where memo_filled_by_id="
						+ memo_filled_by_id_police + " and memo_filled_by='" + memo_filled_by_police
						+ "' and rules_break_id_3= " + rules_id_3 + " and vehicle_id=" + vehicle_id
						+ " and amount::numeric=" + total_panelty + " and memo_date='" + ourJavaTimestampObject
						+ "' and rules_break_state='" + rules_break_state + "' and rules_break_city='"
						+ rules_break_city + "' and rules_break_place='" + rules_break_place + "'");

				while (rs.next()) {

					memo_id = rs.getInt("memo_id");
				}

				System.out.println("MEMO ID : " + memo_id);
				session.setAttribute("memo_id", memo_id);

			} catch (Exception e) {

				e.printStackTrace();

				System.out.println(e.getMessage());

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
			}

			try {
				Connection con1 = ConnectionProvider.getCon();
				String sql_payment = "INSERT INTO ememo.payment(memo_id) VALUES (?)";
				stmt1 = con1.prepareStatement(sql_payment);
				System.out.println("PPPPAAAAYYYYMMMMEEENNNNNTTT");

				con1.setAutoCommit(false);
				stmt1.setInt(1, memo_id);

				stmt1.executeUpdate();
				con1.setAutoCommit(true);
				stmt1.close();

				System.out.println("Table PAyment Record Inserted successfully");
				request.getRequestDispatcher("PDF_GERERATE_by_police.jsp").forward(request, response);
				session.removeAttribute("rules_break_state");
				session.removeAttribute("rules_break_city");
				session.removeAttribute("rules_break_place");
				session.removeAttribute("panelty");
				session.removeAttribute("rules_id_1");
				session.removeAttribute("rules_id_2");
				session.removeAttribute("rules_id_3");
				session.removeAttribute("vehicle_id");

				session.removeAttribute("ourJavaTimestampObject");
				out.println("Success...");

			} catch (Exception e) {

				e.printStackTrace();

				System.out.println(e.getMessage());

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
			}

		}
		// BOTH 1 & 2 RULES ID ARE NOT NULL
		else if (rules_id_1 != null && rules_id_2 != null && rules_id_3 == null) {

			try {

				String memo_filled_by_police = (String) session.getAttribute("memo_filled_by_police");
				String rules_break_state = (String) session.getAttribute("rules_break_state");
				String rules_break_city = (String) session.getAttribute("rules_break_city");
				String rules_break_place = (String) session.getAttribute("rules_break_place");
				Integer total_panelty = (Integer) (session.getAttribute("panelty"));
				Integer vehicle_id = (Integer) session.getAttribute("vehicle_id");

				Timestamp ourJavaTimestampObject = (Timestamp) session.getAttribute("ourJavaTimestampObject");

				Integer memo_filled_by_id_police = (Integer) session.getAttribute("memo_filled_by_id_police");

				Connection con = ConnectionProvider.getCon();
				stmt = con.createStatement();

				ResultSet rs = stmt.executeQuery(
						" Select memo_id from ememo.memo where memo_filled_by_id=" + memo_filled_by_id_police
								+ " and memo_filled_by='" + memo_filled_by_police + "' and rules_break_id_1="
								+ rules_id_1 + " and rules_break_id_2= " + rules_id_2 + " and vehicle_id=" + vehicle_id
								+ " and amount::numeric=" + total_panelty + " and memo_date='" + ourJavaTimestampObject
								+ "' and rules_break_state='" + rules_break_state + "' and rules_break_city='"
								+ rules_break_city + "' and rules_break_place='" + rules_break_place + "'");

				while (rs.next()) {

					memo_id = rs.getInt("memo_id");
				}

				System.out.println("MEMO ID : " + memo_id);
				session.setAttribute("memo_id", memo_id);

			} catch (Exception e) {

				e.printStackTrace();

				System.out.println(e.getMessage());

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
			}

			try {
				Connection con1 = ConnectionProvider.getCon();
				String sql_payment = "INSERT INTO ememo.payment(memo_id) VALUES (?)";
				stmt1 = con1.prepareStatement(sql_payment);
				System.out.println("PPPPAAAAYYYYMMMMEEENNNNNTTT");

				con1.setAutoCommit(false);
				stmt1.setInt(1, memo_id);

				stmt1.executeUpdate();
				con1.setAutoCommit(true);
				stmt1.close();

				System.out.println("Table PAyment Record Inserted successfully");
				request.getRequestDispatcher("PDF_GERERATE_by_police.jsp").forward(request, response);
				session.removeAttribute("rules_break_state");
				session.removeAttribute("rules_break_city");
				session.removeAttribute("rules_break_place");
				session.removeAttribute("panelty");
				session.removeAttribute("rules_id_1");
				session.removeAttribute("rules_id_2");
				session.removeAttribute("rules_id_3");
				session.removeAttribute("vehicle_id");

				session.removeAttribute("ourJavaTimestampObject");
				out.println("Success...");

			} catch (Exception e) {

				e.printStackTrace();

				System.out.println(e.getMessage());

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
			}

		}
		// BOTH 1 & 3 RULES ID ARE NOT NULL
		else if (rules_id_1 != null && rules_id_2 == null && rules_id_3 != null) {

			try {

				String memo_filled_by_police = (String) session.getAttribute("memo_filled_by_police");
				String rules_break_state = (String) session.getAttribute("rules_break_state");
				String rules_break_city = (String) session.getAttribute("rules_break_city");
				String rules_break_place = (String) session.getAttribute("rules_break_place");
				Integer total_panelty = (Integer) (session.getAttribute("panelty"));
				Integer vehicle_id = (Integer) session.getAttribute("vehicle_id");

				Timestamp ourJavaTimestampObject = (Timestamp) session.getAttribute("ourJavaTimestampObject");

				Integer memo_filled_by_id_police = (Integer) session.getAttribute("memo_filled_by_id_police");

				Connection con = ConnectionProvider.getCon();
				stmt = con.createStatement();

				ResultSet rs = stmt.executeQuery(
						" Select memo_id from ememo.memo where memo_filled_by_id=" + memo_filled_by_id_police
								+ " and memo_filled_by='" + memo_filled_by_police + "' and rules_break_id_1="
								+ rules_id_1 + " and rules_break_id_3= " + rules_id_3 + " and vehicle_id=" + vehicle_id
								+ " and amount::numeric=" + total_panelty + " and memo_date='" + ourJavaTimestampObject
								+ "' and rules_break_state='" + rules_break_state + "' and rules_break_city='"
								+ rules_break_city + "' and rules_break_place='" + rules_break_place + "'");

				while (rs.next()) {

					memo_id = rs.getInt("memo_id");
				}

				System.out.println("MEMO ID : " + memo_id);
				session.setAttribute("memo_id", memo_id);

			} catch (Exception e) {

				e.printStackTrace();

				System.out.println(e.getMessage());

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
			}

			try {
				Connection con1 = ConnectionProvider.getCon();
				String sql_payment = "INSERT INTO ememo.payment(memo_id) VALUES (?)";
				stmt1 = con1.prepareStatement(sql_payment);
				System.out.println("PPPPAAAAYYYYMMMMEEENNNNNTTT");

				con1.setAutoCommit(false);
				stmt1.setInt(1, memo_id);

				stmt1.executeUpdate();
				con1.setAutoCommit(true);
				stmt1.close();

				System.out.println("Table PAyment Record Inserted successfully");
				request.getRequestDispatcher("PDF_GERERATE_by_police.jsp").forward(request, response);
				session.removeAttribute("rules_break_state");
				session.removeAttribute("rules_break_city");
				session.removeAttribute("rules_break_place");
				session.removeAttribute("panelty");
				session.removeAttribute("rules_id_1");
				session.removeAttribute("rules_id_2");
				session.removeAttribute("rules_id_3");
				session.removeAttribute("vehicle_id");

				session.removeAttribute("ourJavaTimestampObject");
				out.println("Success...");

			} catch (Exception e) {

				e.printStackTrace();

				System.out.println(e.getMessage());

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
			}

		}

		// BOTH 2 & 3 RULES ID ARE NOT NULL

		else if (rules_id_1 == null && rules_id_2 != null && rules_id_3 != null) {

			try {

				String memo_filled_by_police = (String) session.getAttribute("memo_filled_by_police");
				String rules_break_state = (String) session.getAttribute("rules_break_state");
				String rules_break_city = (String) session.getAttribute("rules_break_city");
				String rules_break_place = (String) session.getAttribute("rules_break_place");
				Integer total_panelty = (Integer) (session.getAttribute("panelty"));
				Integer vehicle_id = (Integer) session.getAttribute("vehicle_id");

				Timestamp ourJavaTimestampObject = (Timestamp) session.getAttribute("ourJavaTimestampObject");

				Integer memo_filled_by_id_police = (Integer) session.getAttribute("memo_filled_by_id_police");

				Connection con = ConnectionProvider.getCon();
				stmt = con.createStatement();

				ResultSet rs = stmt.executeQuery(
						" Select memo_id from ememo.memo where memo_filled_by_id=" + memo_filled_by_id_police
								+ " and memo_filled_by='" + memo_filled_by_police + "' and rules_break_id_2= "
								+ rules_id_2 + " and rules_break_id_3= " + rules_id_3 + " and vehicle_id=" + vehicle_id
								+ " and amount::numeric=" + total_panelty + " and memo_date='" + ourJavaTimestampObject
								+ "' and rules_break_state='" + rules_break_state + "' and rules_break_city='"
								+ rules_break_city + "' and rules_break_place='" + rules_break_place + "'");

				while (rs.next()) {

					memo_id = rs.getInt("memo_id");
				}

				System.out.println("MEMO ID : " + memo_id);
				session.setAttribute("memo_id", memo_id);

			} catch (Exception e) {

				e.printStackTrace();

				System.out.println(e.getMessage());

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
			}

			try {
				Connection con1 = ConnectionProvider.getCon();
				String sql_payment = "INSERT INTO ememo.payment(memo_id) VALUES (?)";
				stmt1 = con1.prepareStatement(sql_payment);
				System.out.println("PPPPAAAAYYYYMMMMEEENNNNNTTT");

				con1.setAutoCommit(false);
				stmt1.setInt(1, memo_id);

				stmt1.executeUpdate();
				con1.setAutoCommit(true);
				stmt1.close();

				System.out.println("Table PAyment Record Inserted successfully");
				request.getRequestDispatcher("PDF_GERERATE_by_police.jsp").forward(request, response);
				session.removeAttribute("rules_break_state");
				session.removeAttribute("rules_break_city");
				session.removeAttribute("rules_break_place");
				session.removeAttribute("panelty");
				session.removeAttribute("rules_id_1");
				session.removeAttribute("rules_id_2");
				session.removeAttribute("rules_id_3");
				session.removeAttribute("vehicle_id");

				session.removeAttribute("ourJavaTimestampObject");
				out.println("Success...");

			} catch (Exception e) {

				e.printStackTrace();

				System.out.println(e.getMessage());

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
			}
		}

		// ALL RULES ID ARE NULLLLLL
		else {

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
			System.out.println("ERROR IN PAYMENT..........");

		}

		session.removeAttribute("rules_break_state");
		session.removeAttribute("rules_break_city");
		session.removeAttribute("rules_break_place");
		session.removeAttribute("panelty");
		session.removeAttribute("rules_id_1");
		session.removeAttribute("rules_id_2");
		session.removeAttribute("rules_id_3");
		session.removeAttribute("vehicle_id");

		session.removeAttribute("ourJavaTimestampObject");
	}

}
