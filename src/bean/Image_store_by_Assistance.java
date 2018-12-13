package bean;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
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
 * Servlet implementation class Image_store_by_Assistance
 */
public class Image_store_by_Assistance extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Image_store_by_Assistance() {
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
		response.getWriter().append("Served at: ").append(request.getContextPath());
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		Integer memo_id = null;

		Connection con = ConnectionProvider.getCon();
		Statement stmt = null;
		PreparedStatement stmt1 = null;
		HttpSession session = request.getSession();
		Part part = (Part) session.getAttribute("part");
		InputStream is = null;

		if (part == null) {

		}
		try {

			is = part.getInputStream();

		} catch (Exception e) {

			e.printStackTrace();

			System.out.println(e.getMessage());

		}
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

			System.out.println("MEMO ID : " + memo_id);
			session.setAttribute("memo_id", memo_id);

		} catch (Exception e) {

			e.printStackTrace();

			System.out.println(e.getMessage());

		}

		try {

			String sql_imagent = "INSERT INTO ememo.image(img) VALUES (?)";

			stmt1 = con.prepareStatement(sql_imagent);

			try {

				System.out.println("getInputStream");
				stmt1.setBinaryStream(1, is);
			} catch (Exception e) {

				e.printStackTrace();

				System.out.println(e.getMessage());

			}

			stmt1.executeUpdate();
			System.out.println("22222222222222222222");

			System.out.println("Table PAyment Record Inserted successfully");

		} catch (Exception e) {

			e.printStackTrace();

			System.out.println(e.getMessage());

		}

	}

}
