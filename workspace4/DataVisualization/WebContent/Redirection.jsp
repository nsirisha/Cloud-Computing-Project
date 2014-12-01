<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Redirecting...</title>
<link rel="icon" type="image/png" href="images/favicon.png" />
</head>
<body>
<%
if(request.getParameter("graphtype").equalsIgnoreCase("bar"))
{
%>
	<jsp:include page="SelectTwoCols.jsp" />
<%
}
else if(request.getParameter("graphtype").equalsIgnoreCase("stacked_bar"))
{
%>
	<jsp:include page="SelectThreeColsStackedBar.jsp" />
<%
}
else if(request.getParameter("graphtype").equalsIgnoreCase("grouped_bar"))
{
%>
	<jsp:include page="SelectThreeColsGroupedBar.jsp" />
<%
}
else if(request.getParameter("graphtype").equalsIgnoreCase("area"))
{
%>
	<jsp:include page="SelectTwoColsArea.jsp" />	
<%
}
else if(request.getParameter("graphtype").equalsIgnoreCase("stacked_area"))
{
%>
	<jsp:include page="SelectThreeColsStackedArea.jsp" />
<%
}
else if(request.getParameter("graphtype").equalsIgnoreCase("scatter"))
{
%>
	<jsp:include page="SelectThreeColsScatter.jsp" />
<%
}
else if(request.getParameter("graphtype").equalsIgnoreCase("line"))
{
%>
	<jsp:include page="SelectThreeColsLine.jsp" />
<%
}
else if(request.getParameter("graphtype").equalsIgnoreCase("population"))
{
%>
	<jsp:include page="SelectFourColsComparison.jsp" />
<%
}
%>
</body>
</html>