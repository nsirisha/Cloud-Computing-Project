<%@ page import="com.vega.VegaDemo" %>
<%@ page import="java.util.*" %>  
<%@ page import="java.io.*" %>
<%@ page import="java.util.regex.*" %>
<%@page import="org.apache.poi.hssf.usermodel.HSSFSheet" %>
<%@page import="org.apache.poi.hssf.usermodel.HSSFWorkbook" %>
<%@page import="org.apache.poi.poifs.filesystem.POIFSFileSystem" %>
<%@page import="org.apache.poi.ss.usermodel.Cell" %>
<%@page import="org.apache.poi.ss.usermodel.Row" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Area Graph</title>
	<link rel="icon" type="image/png" href="images/favicon.png" />
    <script src="http://trifacta.github.io/vega/lib/d3.v3.min.js"></script>
    <script src="http://trifacta.github.io/vega/lib/d3.geo.projection.min.js"></script>
    <script src="http://trifacta.github.io/vega/lib/topojson.js"></script>
    <script src="http://trifacta.github.io/vega/vega.js"></script>

</head>
<body>
<div id="vis"></div>
</body>
<%
String s1=request.getParameter("one");
String s2=request.getParameter("two");
String input=new String();
String value=new String();
VegaDemo vg=new VegaDemo();
HashMap<String, ArrayList<String>> hash = (HashMap<String,ArrayList<String>>)session.getAttribute("hmap");
ArrayList<String> list3=hash.get(s1);
ArrayList<String> list4=hash.get(s2);

Pattern pattern = Pattern.compile("\\-?\\d*\\.?\\d+");

boolean flag_col1=false,flag_col2=false;
if(!list3.isEmpty())
{
String col1=list3.get(0).trim();
if(col1.length() >0)
{
	Matcher m1=pattern.matcher(col1);
	flag_col1=m1.matches();
}
}
//System.out.println("flag is"+flag_col1);
if(!list4.isEmpty())
{
String col2=list4.get(0).trim();
if(col2.length() >0)
{
Matcher m2=pattern.matcher(col2);
flag_col2=m2.matches();
}
//System.out.println("flag is"+flag_col2);
}

if(flag_col1==false || flag_col2==false)
{	
%>
<p style="font-color:red">Please select appropriate columns to plot Area Graph 
<%
}
else
{	
	HashMap<String,String> check=new HashMap<String,String>();
	int i=0,j=0;
	Pattern p = Pattern.compile("\\-?\\d*\\.?\\d+");	
	int limit1=list3.size()>300 ? 300 : list3.size();
	int limit2=list4.size()>300 ? 300 : list3.size();	
	while(i<list3.size() && j<list4.size())
	{		
		String x=list3.get(i).toString().trim();//.replaceAll("[^\\d]", "");
		String y=list4.get(j).toString().trim();//.replaceAll("[^\\d]", "");
		if(x.length()==0 || y.length()==0)
		{
			i++;
			j++;			
			continue;
		}
		String key="";
		Matcher ma=p.matcher(x);
		Matcher m=p.matcher(y);
		if(ma.matches() && m.matches())
		{
			key=x+y;
			if(check.containsKey(key))
			{
				i++;
				j++;				
				continue;
			}
			check.put(key, "0");
			value+="{\"x\":"+ x +", "+"\"y\":"+ y +"}, ";	
		}
		i++;			
		j++;
	}
	
	if(value.length()>0)
	{
	value=value.substring(0,value.lastIndexOf(','));	
	input="{"+
			  "\"width\": 500,"+
			  " \"height\": 300,"+
			  "\"padding\": {"+
			   " \"top\": 100,"+
			    " \"left\": 400,"+
			    " \"bottom\": 300,"+
			    " \"right\": 100"+
			  "},"+
			  " \"data\": ["+
			    "{"+
			     " \"name\": \"table\","+
			     " \"values\": ["+value+" ]"+
			   " }"+
			  "],"+
			  " \"scales\": ["+
			    "{"+
			      " \"name\": \"x\","+
			      " \"type\": \"linear\","+
			     " \"range\": \"width\","+
			      " \"zero\": false,"+
			      " \"domain\": {"+
			       " \"data\": \"table\","+
			       " \"field\": \"data.x\" "+
			     " }"+
			    "},"+
			   " {"+
			     " \"name\": \"y\", "+
			     " \"type\": \"linear\","+
			     " \"range\": \"height\","+
			      " \"nice\": true,"+
			      " \"domain\": {"+
			       " \"data\": \"table\","+
			       " \"field\": \"data.y\" "+
			     " }"+
			    "}"+
			 " ],"+
			 " \"axes\": ["+
			   " {"+
			     " \"type\": \"x\","+
			      " \"scale\": \"x\","+
			    	"\"title\":\""+s1+"\","+
			    	"\"titleOffset\":80,"+
			      " \"ticks\": 20,"+
			    	"\"properties\": {"+
			       "\"ticks\": {"+
			         "\"stroke\": {\"value\": \"steelblue\"}"+
			       "},"+
			       
			       "\"labels\": {"+
			         "\"fill\": {\"value\": \"steelblue\"},"+
			         "\"angle\": {\"value\": 50},"+
			         "\"fontSize\": {\"value\": 14},"+
			         "\"align\": {\"value\": \"left\"},"+
			         "\"baseline\": {\"value\": \"middle\"},"+
			         "\"dx\": {\"value\": 3}"+
			       "},"+
			       "\"title\": {"+
			         "\"fontSize\": {\"value\": 16}"+
			       "},"+
			       "\"axis\": {"+
			         "\"stroke\": {\"value\": \"#333\"},"+
			         "\"strokeWidth\": {\"value\": 1.5}"+
			       "}"+
			     "}"+	  
			   " },"+
			    "{"+
			     " \"type\": \"y\","+
			     " \"scale\": \"y\", \"title\":\""+s2+"\",\"titleOffset\":80, \"properties\": {"+
					       "\"ticks\": {"+
					         "\"stroke\": {\"value\": \"steelblue\"}"+
					       "},"+
					       
					       "\"labels\": {"+
					         "\"fill\": {\"value\": \"steelblue\"},"+
					         "\"angle\": {\"value\": 0},"+
					         "\"fontSize\": {\"value\": 14},"+
					         "\"align\": {\"value\": \"right\"},"+
					         "\"baseline\": {\"value\": \"middle\"},"+
					         "\"dy\": {\"value\": 3}"+
					       "},"+
					       "\"title\": {"+
					         "\"fontSize\": {\"value\": 16}"+
					       "},"+
					       "\"axis\": {"+
					         "\"stroke\": {\"value\": \"#333\"},"+
					         "\"strokeWidth\": {\"value\": 1.5}"+
					       "}"+
					     	"}"+
			   " }"+
			 " ],"+
			 " \"marks\": ["+
			   " {"+
			     " \"type\": \"area\","+
			     " \"from\": {"+
			      "  \"data\": \"table\""+
			      "},"+
			     " \"properties\": {"+
			       " \"enter\": {"+
			         " \"interpolate\": {"+
			          "  \"value\": \"monotone\" "+
			          "},"+
			          " \"x\": {"+
			           " \"scale\": \"x\","+
			           " \"field\": \"data.x\" "+
			          "},"+
			          " \"y\": {"+
			           " \"scale\": \"y\","+
			            " \"field\": \"data.y\" "+
			          "},"+
			          " \"y2\": {"+
			           " \"scale\": \"y\","+
			           " \"value\": 0 "+
			         " },"+
			         " \"fill\": {"+
			           " \"value\": \"#9edae5\" "+
			          "}"+
			       " },"+
			        " \"update\": {"+
			         " \"fillOpacity\": {"+
			           " \"value\": 1"+
			         " }"+
			        "},"+
			       " \"hover\": {"+
			         " \"fillOpacity\": {"+
			           " \"value\": 0.5 "+
			         " }"+
			       " }"+
			     " }"+
			   " }"+
			  "]"+
			"}";
			//System.out.println(input);
%>
<script type="text/javascript">
var text;
	text='<%=input%>';
	call_vega();
function parse(spec) 
{	
  vg.parse.spec(spec, function(chart) { chart({el:"#vis"}).update(); });
}
function call_vega()
{
	parse(JSON.parse(text));
}

</script>
<% 
	}
	else
	{
		%>
		<p>Data not suitable for graph plot
		<%
	}
	}
%>
</html>