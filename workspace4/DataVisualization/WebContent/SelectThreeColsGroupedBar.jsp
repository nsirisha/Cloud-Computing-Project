<%@ page import="com.vega.VegaDemo" %>
<%@ page import="java.util.*" %>  
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Select three columns to plot graph</title>
<link rel="icon" type="image/png" href="images/favicon.png" />
</head>
<body>
<%

VegaDemo vg= new VegaDemo();
HashMap<String, ArrayList<String>> hm=new HashMap<String, ArrayList<String>>();
String filename=(String)session.getAttribute("UploadedPath");
hm=vg.parse(filename);
session.setAttribute("hmap", hm);
%>
<h3 style="text-align:center">SELECT THREE COLUMNS TO PLOT GRAPH<br></h3>
<div style="margin-left: 550px;margin-top:100px">

<form style="display:inline-block" action="PlotGroupedBar.jsp" method="post">
<label for="one">Column 1</label>
<select name="one" style="display:inline-block">
<%
for(String s :hm.keySet())
{
%>
<option value="<%=s %>"><%=s %></option>
<%
}
%>
</select>
<br>
<label for="two">Column 2</label>
<select name="two" style="display:inline-block">
<%
for(String s :hm.keySet())
{
%>
<option value="<%=s %>"><%=s %></option>
<%
}
%>
</select>
<br>
<label for="three">Column 3</label>
<select name="three" style="display:inline-block">
<%
for(String s :hm.keySet())
{
%>
<option value="<%=s %>"><%=s %></option>
<%
}
%>
</select>
<br><br>
<input style="margin-left:50px" type="submit" value="Submit"/>
</form>
</div>

</body>
</html>