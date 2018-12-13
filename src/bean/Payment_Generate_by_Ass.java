package bean;

import java.io.IOException;
import java.io.InputStream;
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
import javax.servlet.http.Part;

/**
 * Servlet implementation class Payment_Generate_by_Ass
 */
public class Payment_Generate_by_Ass extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Payment_Generate_by_Ass() {
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
		try {

			String memo_filled_by_ass = (String) session.getAttribute("memo_filled_by_ass");
			String rules_break_state = (String) session.getAttribute("rules_break_state");
			String rules_break_city = (String) session.getAttribute("rules_break_city");
			String rules_break_place = (String) session.getAttribute("rules_break_place");
			BigDecimal total_panelty = (BigDecimal) (session.getAttribute("panelty"));
			Integer rules_id = (Integer) session.getAttribute("rules_id");
			Integer vehicle_id = (Integer) session.getAttribute("vehicle_id");
			Integer memo_filled_by_id_ass = (Integer) session.getAttribute("memo_filled_by_id_ass");
			Timestamp ourJavaTimestampObject = (Timestamp) session.getAttribute("ourJavaTimestampObject");

			Connection con = ConnectionProvider.getCon();
			stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(" Select memo_id from ememo.memo where memo_filled_by_id="
					+ memo_filled_by_id_ass + " and memo_filled_by='" + memo_filled_by_ass + "' and rules_break_id_1="
					+ rules_id + "  and vehicle_id=" + vehicle_id + " and amount::numeric=" + total_panelty
					+ " and memo_date='" + ourJavaTimestampObject + "' and rules_break_state='" + rules_break_state
					+ "' and rules_break_city='" + rules_break_city + "' and rules_break_place='" + rules_break_place
					+ "'");

			while (rs.next()) {

				memo_id = rs.getInt("memo_id");
			}
			stmt.close();

			System.out.println("MEMO ID : " + memo_id);
			session.setAttribute("memo_id", memo_id);

		} catch (Exception e) {

			e.printStackTrace();

			System.out.println(e.getMessage());

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

			request.getRequestDispatcher("PDF_GERERATE.jsp").forward(request, response);

		} catch (Exception e) {

			e.printStackTrace();

			System.out.println(e.getMessage());

		}

	}

}
