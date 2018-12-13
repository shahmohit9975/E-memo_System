package bean;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.itextpdf.text.log.SysoCounter;

/**
 * Servlet implementation class Get_data_from_assistance
 */
// @MultipartConfig(location="/tmp",
// fileSizeThreshold=1024*1024,maxFileSize=1024*1024*5,
// maxRequestSize=1024*1024*5*5)
@MultipartConfig(maxFileSize = 1024 * 1024 * 5)
public class Get_data_from_assistance extends HttpServlet {
	private static final long serialVersionUID = 1L;
	PrintWriter out;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Get_data_from_assistance() {
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
		response.setContentType("text/html;charset=UTF-8");
		HttpSession session = request.getSession();
		String rules_name = (String) session.getAttribute("rules_name");
		String vehicle_number = (String) session.getAttribute("vehicle_number");

		// FOR IMAGE
		Part part = request.getPart("file");

		session.setAttribute("part", request.getPart("file"));

		Statement stmt = null;
		try {

			Connection con = ConnectionProvider.getCon();
			stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("select rules_id from ememo.rules where rules_name='" + rules_name + "'");

			Integer rules_id = null;

			while (rs.next()) {

				rules_id = rs.getInt("rules_id");
			}
			System.out.println("RULES ID: " + rules_id);
			session.setAttribute("rules_id", rules_id);
			ResultSet rs1 = stmt.executeQuery(
					"select vehicle_id from ememo.vehicle where upper(concat(vehicle_state,vehicle_city,vehicle_number))='"
							+ vehicle_number + "'");
			Integer vehicle_id = null;

			while (rs1.next()) {

				vehicle_id = rs1.getInt("vehicle_id");
			}
			System.out.println("VEHICLE ID: " + vehicle_id);
			session.setAttribute("vehicle_id", vehicle_id);
			session.setAttribute("vehicle_number", vehicle_number);

			// COUNT TOTAL NUMBERS OF MEMO IN MEMO TABLES

			ResultSet rs2 = stmt
					.executeQuery("SELECT count(vehicle_id) as c FROM ememo.memo where vehicle_id=" + vehicle_id);

			Integer total_number_memo_for_vehicle_id = null;
			while (rs2.next()) {

				total_number_memo_for_vehicle_id = rs2.getInt("c");
			}
			System.out.println("total_number_memo_for_vehicle_id: " + total_number_memo_for_vehicle_id);
			BigDecimal panelty = null;
			System.out.println("DOUBLE : " + panelty);
			if (total_number_memo_for_vehicle_id == 0) {

				ResultSet rs3 = stmt
						.executeQuery("select first_panelty::numeric from ememo.rules where rules_id=" + rules_id);

				while (rs3.next()) {

					panelty = rs3.getBigDecimal("first_panelty");
				}

			} else if (total_number_memo_for_vehicle_id == 1)

			{
				ResultSet rs3 = stmt
						.executeQuery("select second_panelty::numeric from ememo.rules where rules_id=" + rules_id);
				while (rs3.next()) {

					panelty = rs3.getBigDecimal("second_panelty");
				}

			} else {
				ResultSet rs3 = stmt
						.executeQuery("select third_panelty::numeric from ememo.rules where rules_id=" + rules_id);
				while (rs3.next()) {

					panelty = rs3.getBigDecimal("third_panelty");
				}
			}
			System.out.println("panelty: " + panelty);
			session.setAttribute("panelty", panelty);
			stmt.close();

		} catch (Exception e) {
		}

		request.getRequestDispatcher("memo_filled_by_ass.jsp").forward(request, response);

	}

}
