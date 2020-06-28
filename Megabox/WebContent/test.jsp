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
%>

</body>
</html>