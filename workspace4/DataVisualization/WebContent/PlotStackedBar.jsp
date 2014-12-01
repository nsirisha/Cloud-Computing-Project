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
	<title>Stacked Bar Graph</title>
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
String s3=request.getParameter("three");
String input=new String();
String value=new String();
VegaDemo vg=new VegaDemo();
HashMap<String, ArrayList<String>> hash = (HashMap<String,ArrayList<String>>)session.getAttribute("hmap");
ArrayList<String> list3=hash.get(s1);
ArrayList<String> list4=hash.get(s2);
ArrayList<String> list5=hash.get(s3);
int max_length=s3.length()*2+400;
Pattern pattern = Pattern.compile("\\-?\\d*\\.?\\d+");

String col1=list3.get(0).trim();
Matcher m1=pattern.matcher(col1);
boolean flag_col1=m1.matches();
//System.out.println("flag is"+flag_col1);

String col2=list4.get(0).trim();
Matcher m2=pattern.matcher(col2);
boolean flag_col2=m2.matches();
//System.out.println("flag is"+flag_col2);

String col3=list5.get(0).trim();
Matcher m3=pattern.matcher(col3);
boolean flag_col3=m3.matches();

if(flag_col1==false || flag_col2==false)
{	
%>
<p style="font-color:red">Please select appropriate columns to plot Stacked Bar Graph 
<%
}
else
{			
	HashMap<String,String> check=new HashMap<String,String>();
	HashMap<String,String> check2=new HashMap<String,String>();
	int i=0,j=0,k=0;
	Pattern p = Pattern.compile("\\-?\\d*\\.?\\d+");
	int count=0;

	int limit1=list3.size()>300 ? 300 : list3.size();
	int limit2=list4.size()>300 ? 300 : list3.size();
	int limit3=list5.size()>300 ? 300 : list3.size();
	while(i<limit1 && j<limit2 && k<limit3)
	{
		
		String x=list3.get(i).toString().trim();//.replaceAll("[^\\d]", "");
		String y=list4.get(j).toString().trim();//.replaceAll("[^\\d]", "");
		String c=list5.get(k).toString().trim();//.replaceAll("[^\\w]", "");
		if(x.length()==0 || y.length()==0 || c.length()==0)
		{
			i++;
			j++;
			k++;
			continue;
		}
		String key="";
		String key2="";
		Matcher ma=p.matcher(x);
		Matcher m=p.matcher(y);
		if(x.equalsIgnoreCase("0") && y.equalsIgnoreCase("0"))
		{
				i++;
				j++;
				k++;
				continue;
		}
		if(ma.matches() && m.matches())
		{
			key=x+y;
			key2=x+c;
			if(check.containsKey(key))
			{
				i++;
				j++;
				k++;
				continue;
			}
			if(check2.containsKey(key2))
			{
				i++;
				j++;
				k++;
				continue;
			}
			check2.put(key2, "0");				
			check.put(key, "0");
			value+="{\"x\":"+x +", "+"\"y\":"+ y +", "+"\"c\":"+ "\""+c+"\""+"}, ";
		}
		i++;			
		j++;
		k++;
	}	
	if(value.length() > 0)
	{
	value=value.substring(0,value.lastIndexOf(','));
	
	input="{"+
			 " \"width\": 500,"+
			  "\"height\": 200,"+
			  " \"padding\": {\"top\": 200, \"left\": "+max_length+", \"bottom\": 300, \"right\": 100},"+
			  " \"data\": [" +
			    "{"+
			     " \"name\": \"table\","+
			      " \"values\": [ "+value+" ]" +
			    "},"+
			    "{ "+
			      " \"name\": \"stats\", "+
			     " \"source\": \"table\", "+
			     " \"transform\": [ "+
			       " {\"type\": \"facet\", \"keys\": [\"data.x\"]},"+
			        "{\"type\": \"stats\", \"value\": \"data.y\"}"+
			     " ]"+
			   " }"+
			  "],"+
			 " \"scales\": [ "+
			    "{"+
			     " \"name\": \"x\","+
			      " \"type\": \"ordinal\", "+
			      " \"range\": \"width\", "+
			     " \"domain\": {\"data\": \"table\", \"field\": \"data.x\"} "+
			    "},"+
			   " {"+
			     " \"name\": \"y\","+
			      "\"type\": \"linear\","+
			      " \"range\": \"height\","+
			      " \"nice\": true,"+
			     " \"domain\": {\"data\": \"stats\", \"field\": \"sum\"} "+
			    "},"+
			    "{"+
			      " \"name\": \"color\","+
			       " \"type\": \"ordinal\", "+
			      " \"range\": \"category20\" "+
			    "}"+
			 " ],"+
			 " \"axes\": [ "+
			   " {\"type\": \"x\", \"scale\": \"x\", \"title\":\""+s1+"\", \"titleOffset\":70, \"properties\": {"+
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
		     	"}},"+
			   " {\"type\": \"y\", \"scale\": \"y\", \"title\":\""+s2+"\", \"titleOffset\":80, \"properties\": {"+
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
		     	"}} "+
			 " ], "+
			  " \"legends\": ["+
			   " {"+
			      " \"fill\": \"color\","+
			      " \"title\": \""+s3+"\","+
			    	"\"orient\": \"left\","+
				     " \"offset\": 0,"+
				      " \"properties\": {"+
				       " \"symbols\": {"+
				         " \"fillOpacity\": {\"value\": 1},"+
				         " \"stroke\": {\"value\": \"transparent\"}"+
				       " }"+
			     " }"+
			    "}"+
			  "],"+

			  " \"marks\": ["+
			   " { "+
			      " \"type\": \"group\","+
			      " \"from\": {"+
			        " \"data\": \"table\","+
			        " \"transform\": ["+
			         " {\"type\": \"facet\", \"keys\": [\"data.c\"]},"+
			         " {\"type\": \"stack\", \"point\": \"data.x\", \"height\": \"data.y\"}"+
			       " ]"+
			     " },"+
			     " \"marks\": ["+
			       " {"+
			         " \"type\": \"rect\","+
			         " \"properties\": { "+
			           " \"enter\": {"+
			             " \"x\": {\"scale\": \"x\", \"field\": \"data.x\"},"+
			             " \"width\": {\"scale\": \"x\", \"band\": true, \"offset\": -1},"+
			             " \"y\": {\"scale\": \"y\", \"field\": \"y\"},"+
			              " \"y2\": {\"scale\": \"y\", \"field\": \"y2\"},"+
			              " \"fill\": {\"scale\": \"color\", \"field\": \"data.c\"} "+
			           " },"+
			            " \"update\": { "+
			             " \"fillOpacity\": {\"value\": 1} "+
			           " },"+
			           " \"hover\": {"+
			            "  \"fillOpacity\": {\"value\": 0.5}"+
			            "}"+
			          "}"+
			       " }"+
			     " ]"+
			   " }"+    
			 " ]"+
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
<% }
	else
	{
		%>
		<p>Data not suitable for graph plot
		<%
	}
}
 %>
</html>