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
<script type="text/javascript">
	$(document).ready(function() {
		$("#messagetable").hide();
		$("#addtable").hide();
		$(".rtmenu").click(function() {
			$(".rtmenu").removeClass("active");
			$(this).addClass("active");
		});
		$("#look").click(function(){
			//$("#messagetable").show();
			$("#addtable").hide();
			$("#messagetable").fadeIn("slow");
			$("#hh5").text("学生信息列表");
			$("#edittable").hide();
		});
		$("#add").click(function(){
			$("#messagetable").hide();
			$("#addtable").fadeIn("slow");
			$("#hh5").text("添加学生信息");
			$("#edittable").hide();
		});
	
	});

</script>
</head>

<body style="padding-top: 65px; overflow: hidden;">

	<div class="container-fluid">
		<div class="col-md-12">
			<nav class="navbar navbar-expand-sm bg-dark navbar-dark fixed-top">
				<div class="col-md-4"></div>
				<a class="navbar-brand col-md-4 " href="#"
					style="text-align: center;">学生管理系统</a>
				<div class="col-md-4"></div>
			</nav>
		</div>
		<div class="row">
			<div class="col-md-2">
				<nav id="sidebarMenu"
					class="col-md-2 fixed-left d-md-block bg-light sidebar collapse">
					<div class="sidebar-sticky pt-3">
						<h6
							class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
							<span>20183732 高梦涛</span>
						</h6>
						<ul class="list-group">
							<li class="list-group-item" ><a class="nav-link rtmenu" id="look"
								href="#">浏览学生信息<span class="sr-only">(current)</span>
							</a></li>
							<li class="list-group-item "><a class="nav-link rtmenu" id="add"
								href="#">添加学生信息 </a></li>
						</ul>
					</div>
				</nav>
			</div>
			<div class="col-md-10" align="left">
				<h5 id="hh5" class="mx-auto font-weight-normal text-secondary text-muted">修改学生信息</h5>
				<table id="messagetable" class="table table-hover" >
					<thead class="thead-light">
						<tr>
							<th>姓名</th>
							<th>性别</th>
							<th>出生日期</th>
							<th>所在地</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<%
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
								ResultSet rs = stmt.executeQuery("select * from student");

								/*
								PreparedStatement stmt = con.prepareStatement("select * from bookinfo");
								ResultSet rs = stmt.executeQuery();
								*/
								while (rs.next()) {
									int id = rs.getInt(1);
									out.println("<tr><td>" + rs.getString(2) + "</td><td>" + rs.getString(3) + "</td><td>"
											+ rs.getString(4)+ "</td><td>" + rs.getString(5) + "</td><td><a href='edit.jsp?id=" + id
											+ "'>修改</a>&nbsp;<a href='del.jsp?id=" + id + "'>删除</a></td></tr>");
								}
								rs.close();
								stmt.close();
								con.close();
							} catch (Exception e) {
								out.println("Exception:" + e.getMessage());
							}
						%>
					</tbody>
				</table>
				<form action="add.jsp" class="form-group">
				<table id="addtable" class="table table-hover table-bordered" >
				<thead class="thead-light">
						<tr>
							<th>类目</th>
							<th>值</th>
						</tr>
					</thead>
				<tr><td>姓名</td><td><input id="name" type="text" name="name" class="form-control"></td></tr>
				<tr><td>性别</td><td><input  type="radio" name="sex" value="男" >男&nbsp;&nbsp;<input type="radio" name="sex" value="女">女</td></tr>
				<tr><td>出生日期</td><td><input id="birthday" name="birthday" type="text" class="form-control"></td></tr>
				<tr><td>所在地域</td><td><input id="place" name="place" type="text" class="form-control"></td></tr>
				<tr><td colspan="2" align="center"><input type="submit" class="btn-primary" value="提交">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="reset" class="btn-secondary" value="重置"></td></tr>
				</table>
				</form>
				<% int iid=Integer.parseInt(request.getParameter("id"));%>
				<form action="editsave.jsp" class="form-group">
				<table id="edittable" class="table table-hover table-bordered" >
				<thead class="thead-light">
						<tr>
							<th>类目</th>
							<th>值</th>
						</tr>
					</thead>
					<%
	
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
		ResultSet rsst=stmt.executeQuery("select * from student where sno="+iid);
		rsst.next();
		out.println("<input type='text' hidden='true' name='id' value="+rsst.getInt("sno")+">"+"<tr><td>姓名</td><td><input id='name' type='text' name='name' class='form-control' value='"+
		rsst.getString("name")+"'></td></tr><tr><td>性别</td><td><input  type='text' name='sex'  value="+rsst.getString("gender")+" ></td></tr>"
		+"<tr><td>出生日期</td><td><input id='birthday' name='birthday' type='text' class='form-control' value="+rsst.getString("birthday")+"></td></tr>"
		+"<tr><td>所在地域</td><td><input id='place' name='place' type='text' class='form-control' value="+rsst.getString("address")+"></td></tr>"
		+"<tr><td colspan='2' align='center'><input type='submit' class='btn-primary' value='提交'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
				+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='reset' class='btn-secondary' value='重置'></td></tr>");
		rsst.close();
		stmt.close();
		con.close();
	} catch (Exception e) {
		out.println("Exception:" + e.getMessage());
	}
%>
				
				</table>
				</form>
			</div>
		</div>
	</div>
</body>
</html>