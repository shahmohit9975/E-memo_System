package bean;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 * Servlet implementation class Get_data_from_assistance
 */
@MultipartConfig
public class Get_data_from_police extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Get_data_from_police() {
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
		// response.getWriter().append("Served at: ").append(request.getContextPath());
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
		System.out.println("IN Get_data_from_police");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		String rules_name_1 = (String) session.getAttribute("rules_name_1");
		String rules_name_2 = (String) session.getAttribute("rules_name_2");
		String rules_name_3 = (String) session.getAttribute("rules_name_3");
		String vehicle_number = (String) session.getAttribute("vehicle_number");

		int total_number_of_rules_breaks = 0;
		Integer panelty = null;
		Part part = request.getPart("file");

		session.setAttribute("part", request.getPart("file"));
		// COUNTS HOW MANY RULES ARE BREAK
		/*
		 * 
		 * 1
		 * 
		 * 2
		 * 
		 * 7
		 * 
		 * 1->1 2->2 7->3 3->1,2 8->1,3 9->2,3 10->1,2,3
		 * 
		 * 
		 */
		if (rules_name_1.equals("-------")) {

			if (rules_name_2.equals("-------")) {

				if (rules_name_3.equals("-------")) {

					total_number_of_rules_breaks = 0;
					response.sendRedirect("wrong_details.jsp");

				}
			}
		}
		if (!rules_name_1.equals("-------")) {

			if (!rules_name_2.equals("-------")) {

				if (!rules_name_3.equals("-------")) {

					total_number_of_rules_breaks = 10;
					// response.sendRedirect("wrong_details.jsp");

				}
			}
		}

		if (!rules_name_1.equals("-------")) {

			if (rules_name_2.equals("-------")) {

				if (rules_name_3.equals("-------")) {

					total_number_of_rules_breaks = 1;

				}
			}

		}
		if (!rules_name_2.equals("-------")) {

			if (rules_name_1.equals("-------")) {

				if (rules_name_3.equals("-------")) {

					total_number_of_rules_breaks = 2;

				}
			}

		}
		if (!rules_name_3.equals("-------")) {

			if (rules_name_1.equals("-------")) {

				if (rules_name_2.equals("-------")) {

					total_number_of_rules_breaks = 7;

				}
			}

		}
		if (!rules_name_1.equals("-------")) {

			if (!rules_name_2.equals("-------")) {

				if (rules_name_3.equals("-------")) {

					total_number_of_rules_breaks = 3;

				}
			}

		}
		if (!rules_name_1.equals("-------")) {

			if (!rules_name_3.equals("-------")) {

				if (rules_name_2.equals("-------")) {

					total_number_of_rules_breaks = 8;

				}
			}

		}
		if (!rules_name_2.equals("-------")) {

			if (!rules_name_3.equals("-------")) {

				if (rules_name_1.equals("-------")) {

					total_number_of_rules_breaks = 9;

				}
			}

		}

		// FOR IMAGE

		// HttpSession session = request.getSession();
		// Part part = request.getPart("image");

		if (part == null) {

		} else {

		}

		session.setAttribute("part", part);

		Statement stmt = null;
		try {

			Connection con = ConnectionProvider.getCon();
			try {

				stmt = con.createStatement();

			} catch (Exception e) {

				e.printStackTrace();
				System.out.println(e.getMessage());
			}

			Integer rules_id_1 = null;
			Integer rules_id_2 = null;
			Integer rules_id_3 = null;
			// ################################################# RULES ID 1
			// ###############################################
			System.out.println("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
			if (!rules_name_1.equals("-------")) {

				ResultSet rs = stmt
						.executeQuery("select rules_id from ememo.rules where rules_name='" + rules_name_1 + "'");

				while (rs.next()) {

					rules_id_1 = rs.getInt("rules_id");
				}
				System.out.println("RULES ID 1: " + rules_id_1);
				session.setAttribute("rules_id_1", rules_id_1);
			}
			// ################################################# RULES ID 2
			// ###############################################
			if (!rules_name_2.equals("-------")) {

				ResultSet rs_11 = stmt
						.executeQuery("select rules_id from ememo.rules where rules_name='" + rules_name_2 + "'");
				while (rs_11.next()) {

					rules_id_2 = rs_11.getInt("rules_id");
				}
				System.out.println("RULES ID 2: " + rules_id_2);
				session.setAttribute("rules_id_2", rules_id_2);
			}

			// ################################################# RULES ID 3
			// ###############################################
			if (!rules_name_3.equals("-------")) {

				ResultSet rs_22 = stmt
						.executeQuery("select rules_id from ememo.rules where rules_name='" + rules_name_3 + "'");
				while (rs_22.next()) {

					rules_id_3 = rs_22.getInt("rules_id");
				}
				System.out.println("RULES ID 3: " + rules_id_3);
				session.setAttribute("rules_id_3", rules_id_3);

			}
			// ################################################# VEHICLE ID
			// ###############################################

			ResultSet rs1 = stmt.executeQuery(
					"select vehicle_id from ememo.vehicle where upper(concat(vehicle_state,vehicle_city,vehicle_number))='"
							+ vehicle_number + "'");
			Integer vehicle_id = null;

			while (rs1.next()) {

				vehicle_id = rs1.getInt("vehicle_id");
			}
			System.out.println("VEHICLE ID: " + vehicle_id);
			session.setAttribute("vehicle_id", vehicle_id);

			// ################################################# COUNT TOTAL NUMBERS OF MEMO
			// IN MEMO TABLES #################################################

			ResultSet rs2 = stmt
					.executeQuery("SELECT count(vehicle_id) as c FROM ememo.memo where vehicle_id=" + vehicle_id);

			Integer total_number_memo_for_vehicle_id = null;
			while (rs2.next()) {

				total_number_memo_for_vehicle_id = rs2.getInt("c");
			}
			System.out.println("total_number_memo_for_vehicle_id: " + total_number_memo_for_vehicle_id);
			System.out.println("DOUBLE : " + panelty);
			if (total_number_memo_for_vehicle_id == 0) {

				if (total_number_of_rules_breaks == 1) {

					ResultSet rs3 = stmt.executeQuery(
							"select first_panelty::numeric from ememo.rules where rules_id=" + rules_id_1);

					while (rs3.next()) {

						
						panelty = rs3.getInt("first_panelty");
					}
				} else if (total_number_of_rules_breaks == 2) {

					ResultSet rs3 = stmt.executeQuery(
							"select first_panelty::numeric from ememo.rules where rules_id=" + rules_id_2);

					while (rs3.next()) {

						
						panelty = rs3.getInt("first_panelty");
					}
				} else if (total_number_of_rules_breaks == 3) {

					ResultSet rs3 = stmt.executeQuery(
							"select first_panelty::numeric from ememo.rules where rules_id=" + rules_id_1);

					while (rs3.next()) {

						
						panelty = rs3.getInt("first_panelty");
					}
					ResultSet rs4 = stmt.executeQuery(
							"select first_panelty::numeric from ememo.rules where rules_id=" + rules_id_2);

					while (rs4.next()) {

						
						panelty += rs4.getInt("first_panelty");
					}
				} else if (total_number_of_rules_breaks == 7) {
					ResultSet rs3 = stmt.executeQuery(
							"select first_panelty::numeric from ememo.rules where rules_id=" + rules_id_3);

					while (rs3.next()) {

						
						panelty = rs3.getInt("first_panelty");
					}

				} else if (total_number_of_rules_breaks == 8) {
					ResultSet rs3 = stmt.executeQuery(
							"select first_panelty::numeric from ememo.rules where rules_id=" + rules_id_1);

					while (rs3.next()) {

						
						panelty = rs3.getInt("first_panelty");
					}
					ResultSet rs4 = stmt.executeQuery(
							"select first_panelty::numeric from ememo.rules where rules_id=" + rules_id_3);

					while (rs4.next()) {

						
						panelty += rs4.getInt("first_panelty");
					}

				} else if (total_number_of_rules_breaks == 9) {

					ResultSet rs3 = stmt.executeQuery(
							"select first_panelty::numeric from ememo.rules where rules_id=" + rules_id_2);

					while (rs3.next()) {

						
						panelty = rs3.getInt("first_panelty");
					}
					ResultSet rs4 = stmt.executeQuery(
							"select first_panelty::numeric from ememo.rules where rules_id=" + rules_id_3);

					while (rs4.next()) {

						
						panelty += rs4.getInt("first_panelty");
					}

				} else if (total_number_of_rules_breaks == 10) {

					ResultSet rs3 = stmt.executeQuery(
							"select first_panelty::numeric from ememo.rules where rules_id=" + rules_id_1);

					while (rs3.next()) {

						
						panelty = rs3.getInt("first_panelty");
					}
					ResultSet rs4 = stmt.executeQuery(
							"select first_panelty::numeric from ememo.rules where rules_id=" + rules_id_2);

					while (rs4.next()) {

						
						panelty += rs4.getInt("first_panelty");
					}
					ResultSet rs5 = stmt.executeQuery(
							"select first_panelty::numeric from ememo.rules where rules_id=" + rules_id_3);

					while (rs5.next()) {

						
						panelty += rs5.getInt("first_panelty");
					}

				} else {

				}

			} else if (total_number_memo_for_vehicle_id == 1)

			{
				if (total_number_of_rules_breaks == 1) {

					ResultSet rs3 = stmt.executeQuery(
							"select second_panelty::numeric from ememo.rules where rules_id=" + rules_id_1);

					while (rs3.next()) {

						
						panelty = rs3.getInt("second_panelty");
					}
				} else if (total_number_of_rules_breaks == 2) {

					ResultSet rs3 = stmt.executeQuery(
							"select second_panelty::numeric from ememo.rules where rules_id=" + rules_id_2);

					while (rs3.next()) {

						
						panelty = rs3.getInt("second_panelty");
					}
				} else if (total_number_of_rules_breaks == 3) {

					ResultSet rs3 = stmt.executeQuery(
							"select second_panelty::numeric from ememo.rules where rules_id=" + rules_id_1);

					while (rs3.next()) {

						
						panelty = rs3.getInt("second_panelty");
					}
					ResultSet rs4 = stmt.executeQuery(
							"select second_panelty::numeric from ememo.rules where rules_id=" + rules_id_2);

					while (rs4.next()) {

						
						panelty += rs4.getInt("second_panelty");
					}
				} else if (total_number_of_rules_breaks == 7) {
					ResultSet rs3 = stmt.executeQuery(
							"select second_panelty::numeric from ememo.rules where rules_id=" + rules_id_3);

					while (rs3.next()) {

						
						panelty = rs3.getInt("second_panelty");
					}

				} else if (total_number_of_rules_breaks == 8) {
					ResultSet rs3 = stmt.executeQuery(
							"select second_panelty::numeric from ememo.rules where rules_id=" + rules_id_1);

					while (rs3.next()) {

						
						panelty = rs3.getInt("second_panelty");
					}
					ResultSet rs4 = stmt.executeQuery(
							"select second_panelty::numeric from ememo.rules where rules_id=" + rules_id_3);

					while (rs4.next()) {

						
						panelty += rs4.getInt("second_panelty");
					}

				} else if (total_number_of_rules_breaks == 9) {

					ResultSet rs3 = stmt.executeQuery(
							"select second_panelty::numeric from ememo.rules where rules_id=" + rules_id_2);

					while (rs3.next()) {

						
						panelty = rs3.getInt("second_panelty");
					}
					ResultSet rs4 = stmt.executeQuery(
							"select second_panelty::numeric from ememo.rules where rules_id=" + rules_id_3);

					while (rs4.next()) {

						
						panelty += rs4.getInt("second_panelty");
					}

				} else if (total_number_of_rules_breaks == 10) {

					ResultSet rs3 = stmt.executeQuery(
							"select second_panelty::numeric from ememo.rules where rules_id=" + rules_id_1);

					while (rs3.next()) {

						
						panelty = rs3.getInt("second_panelty");
					}
					ResultSet rs4 = stmt.executeQuery(
							"select second_panelty::numeric from ememo.rules where rules_id=" + rules_id_2);

					while (rs4.next()) {

						
						panelty += rs4.getInt("second_panelty");
					}
					ResultSet rs5 = stmt.executeQuery(
							"select second_panelty::numeric from ememo.rules where rules_id=" + rules_id_3);

					while (rs5.next()) {

						
						panelty += rs5.getInt("second_panelty");
					}

				} else {

				}

			} else {
				if (total_number_of_rules_breaks == 1) {

					ResultSet rs3 = stmt.executeQuery(
							"select third_panelty::numeric from ememo.rules where rules_id=" + rules_id_1);

					while (rs3.next()) {

						
						panelty = rs3.getInt("third_panelty");
					}
				} else if (total_number_of_rules_breaks == 2) {

					ResultSet rs3 = stmt.executeQuery(
							"select third_panelty::numeric from ememo.rules where rules_id=" + rules_id_2);

					while (rs3.next()) {

						
						panelty = rs3.getInt("third_panelty");
					}
				} else if (total_number_of_rules_breaks == 3) {

					ResultSet rs3 = stmt.executeQuery(
							"select third_panelty::numeric from ememo.rules where rules_id=" + rules_id_1);

					while (rs3.next()) {

						
						panelty = rs3.getInt("third_panelty");
					}
					ResultSet rs4 = stmt.executeQuery(
							"select third_panelty::numeric from ememo.rules where rules_id=" + rules_id_2);

					while (rs4.next()) {

						
						panelty += rs4.getInt("third_panelty");
					}
				} else if (total_number_of_rules_breaks == 7) {
					ResultSet rs3 = stmt.executeQuery(
							"select third_panelty::numeric from ememo.rules where rules_id=" + rules_id_3);

					while (rs3.next()) {

						
						panelty = rs3.getInt("third_panelty");
					}

				} else if (total_number_of_rules_breaks == 8) {
					ResultSet rs3 = stmt.executeQuery(
							"select third_panelty::numeric from ememo.rules where rules_id=" + rules_id_1);

					while (rs3.next()) {

						
						panelty = rs3.getInt("third_panelty");
					}
					ResultSet rs4 = stmt.executeQuery(
							"select third_panelty::numeric from ememo.rules where rules_id=" + rules_id_3);

					while (rs4.next()) {

						
						panelty += rs4.getInt("third_panelty");
					}

				} else if (total_number_of_rules_breaks == 9) {

					ResultSet rs3 = stmt.executeQuery(
							"select third_panelty::numeric from ememo.rules where rules_id=" + rules_id_2);

					while (rs3.next()) {

						
						panelty = rs3.getInt("third_panelty");
					}
					ResultSet rs4 = stmt.executeQuery(
							"select third_panelty::numeric from ememo.rules where rules_id=" + rules_id_3);

					while (rs4.next()) {

						
						panelty += rs4.getInt("third_panelty");
					}

				} else if (total_number_of_rules_breaks == 10) {

					ResultSet rs3 = stmt.executeQuery(
							"select third_panelty::numeric from ememo.rules where rules_id=" + rules_id_1);

					while (rs3.next()) {

						
						panelty = rs3.getInt("third_panelty");
					}
					ResultSet rs4 = stmt.executeQuery(
							"select third_panelty::numeric from ememo.rules where rules_id=" + rules_id_2);

					while (rs4.next()) {

						
						panelty += rs4.getInt("third_panelty");
					}
					ResultSet rs5 = stmt.executeQuery(
							"select third_panelty::numeric from ememo.rules where rules_id=" + rules_id_3);

					while (rs5.next()) {

						
						panelty += rs5.getInt("third_panelty");
					}

				} else {

				}
			}
			System.out.println("panelty: " + panelty);
			session.setAttribute("panelty", panelty);

			// stmt.close();

		} catch (Exception e) {
		}
		request.getRequestDispatcher("memo_filled_by_police.jsp").forward(request, response);

	}

}
