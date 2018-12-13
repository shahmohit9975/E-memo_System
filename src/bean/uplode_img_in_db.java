package bean;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 * Servlet implementation class uplode_img_in_db
 */
public class uplode_img_in_db extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public uplode_img_in_db() {
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
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		String tmp = (String) session.getAttribute("memo_filled_by_police");
		Part part = (Part) session.getAttribute("part");

		int result = 0;
		if (part == null) {

		} else {

			// int result = 0;

			try {
				System.out.println("img in");

				int memo_id = (int) session.getAttribute("memo_id");
				System.out.println("1");
				Connection con = DB.getConnection();
				System.out.println("2");
				PreparedStatement ps = con.prepareStatement("insert into data(id,image) values(?, ?)");
				System.out.println("3");
				InputStream is = part.getInputStream();
				System.out.println("4");
				ps.setInt(1, memo_id);
				System.out.println("5");
				ps.setBlob(2, is);
				System.out.println("6");
				result = ps.executeUpdate();
				System.out.println("7");
				con.close();
				System.out.println("8");
				if (result > 0) {

				} else {

				}
			} catch (Exception e) {
				out.println(e);

				e.printStackTrace();

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

			if (tmp != null)
				request.getRequestDispatcher("again_call_police_home_page.jsp").include(request, response);
			else
				request.getRequestDispatcher("again_call_ass_home_page.jsp").include(request, response);

		}

	}
}
