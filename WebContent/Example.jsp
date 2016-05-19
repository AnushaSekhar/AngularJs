<!DOCTYPE html>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<html lang="en-US">
<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>
<body>
<!-- ng-app directive defines angular js application -must***-->

<div ng-app="myApp">
<script>
	var myApp = angular.module('myApp',[]);
 	<%@ page import ="java.sql.*" %>
 
 	<% 
 	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
 	Connection conn =DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databaseName=Erevenueplustest;integratedSecurity=false","sa","Anusha@123");
 	 Statement stmt = conn.createStatement();
 	 String sql="select * from employee_master";
 	 ResultSet rs = stmt.executeQuery(sql);
 	 try
 	 {
 	  if(rs!=null)
 	  {
 		  %>
myApp.controller('empCtl',function($scope) 
   {
    $scope.empData = [
<%
    rs.next();
    while(true)
    {
%> 
     {"emp_code":"<%=rs.getString("emp_code")%>","emp_name":"<%=rs.getString("emp_name")%>","pay_month_year":"<%=rs.getString("pay_month_year")%>","gross_pay":"<%=rs.getString("gross_pay")%>","tot_pay":"<%=rs.getString("tot_pay")%>"}
   
     <%if(rs.next()) {%> , <% } else break;
    } %>
    console.log( $scope.empData)
  <% } 
  }
 catch(SQLException e) 
 {
  e.printStackTrace();
 }
 stmt.close();
 rs.close();
 conn.close();
 stmt=null;
 rs=null;
 conn=null;
%>
         ];
 
}); 
</script>
<script>

</script>
</head>
<body ng-controller="empCtl">
 Search: <input ng-model="query" type="text" />
<table border=1 cellpadding=5>
 <tr>
  <th><a href="" ng-click="sortField = 'emp_code'" >Emp Code</a></th>
  <th><a href="" ng-click="sortField = 'emp_name'" >Emp Name</a></th>
  <th>Month Year</th><th>Gross Pay</th><th>Tot Pay</th></tr> 
  <tr ng-repeat="emp in empData ">
  
  <td>{{emp.emp_code}}</td>
  <td>{{emp.emp_name}}</td>
  <td>{{emp.pay_month_year}}</td>
  <td>{{emp.gross_pay}}</td>
  <td>{{emp.tot_pay}}</td> 
 </tr>
</table>
</body>
</html>