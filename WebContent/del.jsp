<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>学生管理系统</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
	integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
	integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
	crossorigin="anonymous"></script>
<script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
	integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"
	integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI"
	crossorigin="anonymous"></script>

<link rel="stylesheet" type="text/css" href="dashboard.css">
</head>
<script type="text/javascript">
if(!confirm("确认删除？")){
	window.location.href="welcome.jsp";
}
</script>
<%
	String name=request.getParameter("name");
	String sex=request.getParameter("sex");
	String birth=request.getParameter("birthday");
	String place=request.getParameter("place");
	try {
		Connection con = null;
		String driverName = "com.mysql.cj.jdbc.Driver";
		String dbURL = "jdbc:mysql://localhost:3306/studentmanagement"
				+ "?useSSL=false&serverTimezone=UTC&useUnicode=yes&characterEncoding=utf8";
		String userName = "root";
		String userPwd = "123456";
		try {
			Class.forName(driverName);
			System.out.println("加载驱动成功！");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("加载驱动失败！");
		}
		try {
			con = DriverManager.getConnection(dbURL, userName, userPwd);
			System.out.println("连接数据库成功！");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.print("mysql连接失败！");
		}
		//使用Statement对象
		Statement stmt = con.createStatement();
		stmt.executeUpdate("delete from student where sno="+request.getParameter("id"));
		stmt.close();
		con.close();
	} catch (Exception e) {
		out.println("Exception:" + e.getMessage());
	}
%>
<body style="padding-top: 65px; overflow: hidden;">
<h5>删除成功！</h5><a a href="welcome.jsp">点击返回</a>
</body>
</html>