<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="bean.Provider.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>
<style>
.container {
	position: relative;
}

.topright {
	position: absolute;
	top: 8px;
	right: 16px;
	font-size: 18px;
}

img {
	width: 30%;
	height: 30%;
	/*      opacity: 0.3;  */
}

img {
	width: 30%;
	height: 30%;
	/* 	max-width: 680px; */
	padding-top: 60px;
	padding-right: 20px;
	padding-bottom: 10px;
	padding-left: 10px;
}

input[type=file] {
	padding-top: 5px;
	padding-right: 5px;
	padding-bottom: 5px;
	padding-left: 5px;
	/* 	background: #2d2d2d; */
	position: absolute;
	right: 150px;
}
</style>
<script>
	var request = new XMLHttpRequest();
	function searchInfo_for_rules_id() {
		var name = document.rules_id.rules_id_no.value;
		var url = "search_rules_for_assistance.jsp?val=" + name;

		try {
			request.onreadystatechange = function() {
				if (request.readyState == 4) {
					var val = request.responseText;
					document.getElementById('mylocation_for_rules_id').innerHTML = val;
				}
			}//end of function  
			request.open("GET", url, true);
			request.send();
		} catch (e) {
			alert("Unable to connect to server");
		}
	}
	function searchInfo_for_vehicle_id() {
		var name = document.vehicle_id.vehicle_id_no.value;
		var url = "search_vehicle_id_for_assistance.jsp?val=" + name;

		try {
			request.onreadystatechange = function() {
				if (request.readyState == 4) {
					var val = request.responseText;
					document.getElementById('mylocation_for_vehicle_id').innerHTML = val;
				}
			}//end of function  
			request.open("GET", url, true);
			request.send();
		} catch (e) {
			alert("Unable to connect to server");
		}
	}
	function hello1() {
		var rules_id_no = document.rules_id.rules_id_no.value;
		var vehicle_id_no = document.vehicle_id.vehicle_id_no.value;

		var url = "save_value_in_session_assistance.jsp?rules_id_no="
				+ rules_id_no + "&vehicle_id_no=" + vehicle_id_no;
		request.open("GET", url, true);
		request.send();
	}
	
	function path_store_in_session() {
	
		
		var img_path = document.rules_break.file.value;
		// var name=this.files[0];

		console.dir(img_path);
		//alert(img_path);

		
		var newPathname = "";

	    
	    var res = img_path.split("\\");
	    
	    for (var i = 0; i < res.length ; i++) {

			  newPathname += res[i];
			    newPathname += ",";
			}
		
	    
	   // alert(newPathname);
		var url = "save_image_path_in_session.jsp?img_path="+newPathname;
		//alert(url);
		request.open("GET", url, true);
	//	alert("hello");
		request.send();
		
		
	}
	function hello() {
		var rules_break_state = document.rules_break.rules_break_state.value;
		var rules_break_city = document.rules_break.rules_break_city.value;
		var rules_break_place = document.rules_break.rules_break_place.value;

		var rules_name = document.rules_break.rules_name.value;
		var vehicle_number = document.rules_break.vehicle_number.value;

		var url = "save_value_in_session_assistance.jsp?rules_break_state="
				+ rules_break_state + "&rules_break_city=" + rules_break_city
				+ "&rules_break_place=" + rules_break_place + "&rules_name="
				+ rules_name + "&vehicle_number=" + vehicle_number;
		request.open("GET", url, true);
		request.send();


	}
</script>

<title>Assistance_Home_page</title>
</head>
<body>
FS

	<a href="logout_assistance.jsp">LOGOUT</a>

	<form action="Get_data_from_assistance" name="rules_break"
		enctype="multipart/form-data" method="post">
		<%!String state_q = "SELECT * FROM ememo.rules_break_state";
	String city_q = "SELECT * FROM ememo.rules_break_city";
	String place_q = "SELECT * FROM ememo.rules_break_place";
	String rules_q = "select rules_name from ememo.rules";
	String vehicle_q = "SELECT upper(concat(vehicle_state,vehicle_city,vehicle_number)) as v FROM ememo.vehicle";%>


		<input type="file" name="file" id="profile-img"
			onchange="path_store_in_session()"> <br> <img src=""
			id="profile-img-tag" width="200px" />
		<script type="text/javascript">
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            
            alert(reader);
            
            reader.onload = function (e) {
                $('#profile-img-tag').attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    }
    $("#profile-img").change(function(){
        readURL(this);
    });
</script>

		<%
			PreparedStatement ps = null;
			PreparedStatement ps1 = null;
			PreparedStatement ps2 = null;
			PreparedStatement ps3 = null;
			PreparedStatement ps4 = null;
			try {
				Class.forName(bean.Provider.DRIVER);

				Connection con = DriverManager.getConnection(bean.Provider.CONNECTION_URL, bean.Provider.USERNAME,
						bean.Provider.PASSWORD);
				//state_q = "SELECT * FROM ememo.rules_break_state";
				ps = con.prepareStatement(state_q);
				ps1 = con.prepareStatement(city_q);
				ps2 = con.prepareStatement(place_q);
				ps3 = con.prepareStatement(rules_q);
				ps4 = con.prepareStatement(vehicle_q);
				ResultSet rs = ps.executeQuery();
				ResultSet rs1 = ps1.executeQuery();
				ResultSet rs2 = ps2.executeQuery();
				ResultSet rs3 = ps3.executeQuery();
				ResultSet rs4 = ps4.executeQuery();
		%>
		<p>

			<br> <br> <br> Select Rules : <select
				onchange="hello()" name="rules_name">
				<option value="-------">-------</option>
				<%
					while (rs3.next()) {
							String fname = rs3.getString("rules_name");
				%>
				<option value="<%=fname%>" name="rules_name"><%=fname%></option>
				<%
					}
				%>
			</select>
			<!-- 	*********************************************************		 -->
			<br> <br> <br> Select Vehicle Number : <select
				onchange="hello()" name="vehicle_number">
				<option value="-------">-------</option>
				<%
					while (rs4.next()) {
							String fname = rs4.getString("v");
				%>
				<option value="<%=fname%>" name="vehicle_no"><%=fname%></option>
				<%
					}
				%>
			</select>


			<!-- 	*********************************************************		 -->
			<br> <br> Select State : <select onchange="hello()"
				name="rules_break_state">
				<option value="-------">-------</option>
				<%
					while (rs.next()) {

							String fname = rs.getString("state");
				%>
				<option value="<%=fname%>" name="state"><%=fname%></option>
				<%
					}
				%>
			</select>
			<!-- 	*********************************************************		 -->
			<br> <br> <br> Select City : <select
				onchange="hello()" name="rules_break_city">
				<option value="-------">-------</option>
				<%
					while (rs1.next()) {
							String fname = rs1.getString("city");
				%>
				<option value="<%=fname%>" name="city"><%=fname%></option>
				<%
					}
				%>
			</select>
			<!-- 	*********************************************************		 -->
			<br> <br> <br> Select Place : <select
				onchange="hello()" name="rules_break_place">
				<option value="-------">-------</option>
				<%
					while (rs2.next()) {
							String fname = rs2.getString("place");
				%>
				<option value="<%=fname%>" name="place"><%=fname%></option>
				<%
					}
				%>
			</select>
		</p>
		<%
			} catch (SQLException sqe) {
				out.println(sqe);
			}
		%>
		<br /> <br> <input type="submit" value="SUBMITTT">
	</form>








</body>
</html>