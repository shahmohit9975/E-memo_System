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
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lobster">
<style>

html { 
  background: url(bg_officers.jpg) no-repeat center center fixed; 
  -webkit-background-size: cover;
  -moz-background-size: cover;
  -o-background-size: cover;
  background-size: cover;
}
.font_style {
  font-family: "Lobster", serif;
  font-size:20px;
}
.generete_button {
  display: inline-block;
  padding: 10px 20px;
  font-size: 14px;
  cursor: pointer;
  text-align: center;
  text-decoration: none;
  outline: none;
  color: #fff;
  background-color: black;
  border: none;
  border-radius: 15px;
  box-shadow: 0 9px #999;
   -webkit-transition-duration: 0.4s; 
  transition-duration: 0.4s;
}

.generete_button:hover {background-color: #ff1a1a}

.generete_button:active {
  background-color: #3e8e41;
  box-shadow: 0 5px #666;
  transform: translateY(4px);
}
.logout_button {
 
  border: none;
  color: white;

  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  -webkit-transition-duration: 0.4s; 
  transition-duration: 0.4s;
  cursor: pointer;
    background-color: #47d147;
  color: black;
  border: 2px solid #555555;
  border-radius: 15px;
  width: 100px;
  height:30px;
}



.logout_button:hover {
  background-color: #c2f0c2;
  color: black;
}
.container {
	position: relative;
	
}

.topright {
	position: absolute;
	top: 8px;
	right: 16px;
	font-size: 18px;
}

select{

width: 95%;
border-radius: 20px;
outline: none;

}
input[type=file] {
	padding-top: 5px;
	padding-right: 5px;
	padding-bottom: 5px;
	padding-left: 5px;
	/* 	background: #2d2d2d; */
	
	right: 150px;
}


img {
	outline:none;

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


	<a href="logout_assistance.jsp">
	
	<button class="logout_button"><b>LOGOUT</b></button>
	</a>
<br>
<br>
	<form action="Get_data_from_assistance" name="rules_break"
		enctype="multipart/form-data" method="post">
		<%!String state_q = "SELECT * FROM ememo.rules_break_state";
	String city_q = "SELECT * FROM ememo.rules_break_city";
	String place_q = "SELECT * FROM ememo.rules_break_place";
	String rules_q = "select rules_name from ememo.rules";
	String vehicle_q = "SELECT upper(concat(vehicle_state,vehicle_city,vehicle_number)) as v FROM ememo.vehicle";%>

<table border="0" align="center">


	<tr>

			<td align="center" colspan="2">
			<input type="file" name="file" id="profile-img"
			onchange="path_store_in_session()">
			
			<script type="text/javascript">
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            
           // alert(reader);
            
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
			
			</td>
			
			<td rowspan="7">
			<img src=""id="profile-img-tag" style="width: 380px;height: 350px;"  />
			</td>
	
	</tr>
	<tr>
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
			<td align="center" class="w3-xxxlarge font_style w3-lobster">
			Select Rules :
			</td>
			
			<td>
			<select
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
			</td>
	
	</tr>
	<tr>

			<td align="center" class="w3-xxxlarge font_style w3-lobster">
			Select Vehicle Number :
			</td>
			
			<td>
			<select
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
			</td>
	
	</tr>
	<tr>

			<td align="center" class="w3-xxxlarge font_style w3-lobster">
			Select State :
			</td>
			
			<td>
			<select onchange="hello()"
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
			</td>
	
	</tr>
	<tr>

			<td align="center" class="w3-xxxlarge font_style w3-lobster">
			Select City :
			</td>
			
			<td>
			<select
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
			</td>
	
	</tr>
	<tr>

			<td align="center" class="w3-xxxlarge font_style w3-lobster">
			 Select Place :
			</td>
			
			<td>
			<select
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
			<%
			} catch (SQLException sqe) {
				out.println(sqe);
			}
		%>
			</td>
	
	</tr>
	<tr>

			<td>
			
			</td>
			
			<td align="center" >
			<input type="submit" value="GENERATE MEMO" class="generete_button" style="margin-right:35px;">
			</td>
	
	</tr>
</table>

	</form>



</body>
</html>
