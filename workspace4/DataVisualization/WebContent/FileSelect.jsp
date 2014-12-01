<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Upload a file and select your graph</title>
<link rel="icon" type="image/png" href="images/favicon.png" />
</head>
<body>
<div style="margin-top:100px;">
<h2 style="text-align:center">SELECT THE TYPE OF GRAPH<br>
</h2>
<br><br>
<form action="Redirection.jsp" method="POST">    
<table style="margin:auto;">
<tr>
<td>    
    <input type="radio" name="graphtype" value="bar" checked>Bar Graph<br>
</td>
</tr>
<tr>
<td>
	<input type="radio" name="graphtype" value="stacked_bar">Stacked Bar Graph<br>
</td>
</tr>
<tr>
<td>
	<input type="radio" name="graphtype" value="grouped_bar">Grouped Bar Graph<br>
</td>
</tr>
<tr>
<td>	
	<input type="radio" name="graphtype" value="area">Area Graph<br>
</td>
</tr>
<tr>
<td>
	<input type="radio" name="graphtype" value="stacked_area">Stacked Area Graph<br>
</td>
</tr>
<tr>
<td>
	<input type="radio" name="graphtype" value="line">Line Graph<br>
</td>
</tr>
<tr>
<td>
	<input type="radio" name="graphtype" value="scatter">Scatter Graph<br>
</td>
</tr>
<tr>
<td>
	<input type="radio" name="graphtype" value="population">Comparison Graph<br><br>
</td>
</tr>
</table>
<br>
<input style="margin-left: 550px;" type='submit' name='submit_btn' value="Submit">
</form>
</div>
</body>
</html>