<%@page import="com.itextpdf.text.log.SysoCounter"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.itextpdf.text.Element"%>
<%@page import="com.itextpdf.text.Phrase"%>
<%@page import="com.itextpdf.text.pdf.fonts.otf.TableHeader"%>
<%@ page import="java.sql.*"%>
<%@ page import="bean.Provider.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ page import="java.sql.*"%>



<%@ page
	import="java.io.FileOutputStream, 
java.io.IOException,
java.nio.file.Path,
java.nio.file.Paths,
 javax.servlet.ServletException,
 javax.servlet.annotation.MultipartConfig,
 javax.servlet.annotation.WebServlet,
 javax.servlet.http.HttpServlet,
 javax.servlet.http.HttpServletRequest,
 javax.servlet.http.HttpServletResponse,
 javax.servlet.http.HttpSession,
 javax.servlet.http.Part,
 com.itextpdf.text.BaseColor,
 com.itextpdf.text.Chunk,
 com.itextpdf.text.Document,
 com.itextpdf.text.DocumentException,
 com.itextpdf.text.Font,
 com.itextpdf.text.FontFactory,
 com.itextpdf.text.Image,
 com.itextpdf.text.Paragraph,
 com.itextpdf.text.pdf.PdfPCell,
 com.itextpdf.text.pdf.PdfPTable,
 com.itextpdf.text.pdf.PdfTemplate,
 com.itextpdf.text.pdf.PdfWriter,
 com.itextpdf.text.pdf.codec.Base64.InputStream"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>



	<%
		try {
			Class.forName(bean.Provider.DRIVER);
			Statement stmt = null;
			PreparedStatement stmt1 = null;

			String memo_filled_by_ass = (String) session.getAttribute("memo_filled_by_ass");
			String rules_break_state = (String) session.getAttribute("rules_break_state");
			String rules_break_city = (String) session.getAttribute("rules_break_city");
			String rules_break_place = (String) session.getAttribute("rules_break_place");
			BigDecimal total_panelty = (BigDecimal) (session.getAttribute("panelty"));
			Integer rules_id = (Integer) session.getAttribute("rules_id");
			Integer vehicle_id = (Integer) session.getAttribute("vehicle_id");
			String vehicle_number = (String) session.getAttribute("vehicle_number");
			Integer memo_filled_by_id_ass = (Integer) session.getAttribute("memo_filled_by_id_ass");
			Timestamp ourJavaTimestampObject = (Timestamp) session.getAttribute("ourJavaTimestampObject");
			int memo_id = (int) session.getAttribute("memo_id");

			//Float penalty=Float.parseFloat(total_panelty);

			String date = null;
			try {
				date = String.valueOf(ourJavaTimestampObject);

			} catch (Exception e) {

				e.printStackTrace();

			}

			String owner_name = null;

			Connection con = DriverManager.getConnection(bean.Provider.CONNECTION_URL, bean.Provider.USERNAME,
					bean.Provider.PASSWORD);
			PreparedStatement ps = con.prepareStatement(
					"select oo.owner_name from ememo.owner as oo join ememo.vehicle as vv on(vv.owner_id=oo.owner_id) where vv.vehicle_id="
							+ vehicle_id);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				owner_name = rs.getString(1);
			}

			String rules_name = null;
			PreparedStatement ps1 = con
					.prepareStatement("SELECT rules_name FROM ememo.rules where rules_id=" + rules_id);
			ResultSet rs1 = ps1.executeQuery();
			while (rs1.next()) {
				rules_name = rs1.getString(1);
			}

			Document document = new Document();

			PdfWriter.getInstance(document, new FileOutputStream("F:\\" + memo_id + ".pdf"));
			document.open();

			//HttpSession session = request.getSession();
			StringBuffer img_path = (StringBuffer) session.getAttribute("img_path");

			float[] columnWidths = { 1, 3, 7, 2 };
			PdfPTable table = new PdfPTable(columnWidths);

			PdfPCell c1 = new PdfPCell(new Phrase("No"));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			// c1.setLeft(11);
			table.addCell(c1);

			c1 = new PdfPCell(new Phrase("Details"));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			c1.setColspan(3);
			table.addCell(c1);

			table.addCell("1");
			table.addCell("Memo Id");
			table.addCell(String.valueOf(memo_id));
			table.addCell("");

			table.addCell("2");
			table.addCell("Owner name");
			table.addCell(owner_name);
			table.addCell("");

			table.addCell("3");
			table.addCell("vehicle no");
			table.addCell(vehicle_number);
			table.addCell("");

			table.addCell("4");
			table.addCell("DATE");
			table.addCell(date);
			table.addCell("");

			table.addCell("5");
			table.addCell("Rules name");
			table.addCell(rules_name);
			try {
				// date=String.valueOf(ourJavaTimestampObject);
				table.addCell(total_panelty.toString());

			} catch (Exception e) {
				System.out.println("^^^");
				e.printStackTrace();

			}

			table.addCell("6");
			table.addCell("State");
			table.addCell(rules_break_state);
			table.addCell("");

			table.addCell("7");
			table.addCell("CITY");
			table.addCell(rules_break_city);
			table.addCell("");

			table.addCell("8");
			table.addCell("PLACE");
			table.addCell(rules_break_place);
			table.addCell("");

			table.addCell("9");
			table.addCell("Total");
			table.addCell("");
			try {
				//date=String.valueOf(ourJavaTimestampObject);
				table.addCell(total_panelty.toString());

			} catch (Exception e) {
				System.out.println("^^^^^^");

				e.printStackTrace();

			}

			table.addCell("10");
			table.addCell("Status");
			table.addCell("No");
			table.addCell("");

			document.add(table);

			String final_img_path = String.valueOf(img_path);

			Image img = Image.getInstance(final_img_path);
			// 	img.setRotationDegrees(45f);
			img.scalePercent(17f);
			img.setAbsolutePosition(135f, 45f);

			Font font = FontFactory.getFont(FontFactory.COURIER, 36, BaseColor.BLACK);
			// 			Chunk chunk = new Chunk("Hello World", font);

			document.add(img);
			// 			document.add(chunk);

			document.close();

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}

		request.getRequestDispatcher("send_email.jsp").forward(request, response);
	%>


</body>
</html>