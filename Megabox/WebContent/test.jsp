<%@page import="megaboxClass.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="greeting" value="${param.greetin }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%-- <%
//Selenium a = new Selenium();
//a.bookingSelenium();
Click a = new Click();
a.Crawling();
%> --%>
<%


//Selenium a = new Selenium();
//a.bookingSelenium();
Click a = new Click();
a.Crawling();

/* String x ="등급 : 15세이상관람가";
String y="개봉일 : 2020.06.24";
System.out.println(x.substring(5, 7)+" "+y.substring(6)); */
/*
등급 : 15세이상관람가
개봉일 : 2020.06.24
*/
%>

</body>
</html>