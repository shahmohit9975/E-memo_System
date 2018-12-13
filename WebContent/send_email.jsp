<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@page
	import=" java.io.IOException,
 java.io.PrintWriter,
 java.util.Properties,
 javax.activation.DataHandler,
 javax.activation.DataSource,
 javax.activation.FileDataSource,
 javax.mail.BodyPart,
 javax.mail.Message,
 javax.mail.MessagingException,
 javax.mail.Multipart,
 javax.mail.PasswordAuthentication,
 javax.mail.Session,
 javax.mail.Transport,
 javax.mail.internet.InternetAddress,
 javax.mail.internet.MimeBodyPart,
 javax.mail.internet.MimeMessage,
 javax.mail.internet.MimeMultipart,
 javax.servlet.RequestDispatcher,
 javax.servlet.ServletException,
 javax.servlet.http.HttpServlet,
 javax.servlet.http.HttpServletRequest,
 javax.servlet.http.HttpServletResponse
"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<%
		int memo_id = (int) session.getAttribute("memo_id");
		String to = "shefalikshah76@gmail.com";//change accordingly  			// Receiver Email_id
		final String user = "shahmohit9975@gmail.com";//change accordingly 	   // Sender Email_id 
		final String password = "your_password";//change accordingly  

		//1) get the session object     
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "465");
		Session session1 = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password);
			}
		});

		//2) compose message     
		try {
			MimeMessage message = new MimeMessage(session1);
			message.setFrom(new InternetAddress(user));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
			message.setSubject("Memo");

			//3) create MimeBodyPart object and set your message text     
			BodyPart messageBodyPart1 = new MimeBodyPart();
			messageBodyPart1.setText("You have got memo...");

			//4) create new MimeBodyPart object and set DataHandler object to this object      
			MimeBodyPart messageBodyPart2 = new MimeBodyPart();

			String filename = "F:\\" + memo_id + ".pdf";//change accordingly  
			DataSource source = new FileDataSource(filename);
			messageBodyPart2.setDataHandler(new DataHandler(source));
			messageBodyPart2.setFileName(filename);

			//5) create Multipart object and add MimeBodyPart objects to this object      
			Multipart multipart = new MimeMultipart();
			multipart.addBodyPart(messageBodyPart1);
			multipart.addBodyPart(messageBodyPart2);

			//6) set the multiplart object to the message object  
			message.setContent(multipart);

			//7) send message  
			Transport.send(message);

			System.out.println("message sent....");
			request.getRequestDispatcher("uplode_img_in_db").forward(request, response);
		} catch (MessagingException ex) {
			ex.printStackTrace();
		}
	%>

</body>
</html>