<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
 <title>Change image on select new image from file input</title>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>
<style>
img {
	max-width: 680px;
	padding-top: 60px;
	padding-right: 30px;
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

<title>Insert Mohit</title>
</head>
<body>
<form enctype='multipart/form-data'>
<input type="file" name="file" id="profile-img">
<br>
<img src="" id="profile-img-tag" width="200px" />
</form>

<script type="text/javascript">
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            
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


</body>
</html>