<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/taglib.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="GTMS是一个高效的毕业论文管理系统">
<title>GTMS</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/font-awesome/css/font-awesome.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-style.css">
<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/admin.js"></script>
<script src="${pageContext.request.contextPath}/js/common.js"></script>
</head>
<body>
<jsp:include page="/index/admin-index-top.jsp" />
<div id="main-content">
  <div class="container">

  <!-- 已选学生-->    
  <div class="panel panel-default">
  	<!--头部-->
    <div class="panel-heading">
	  <h3 class="panel-title">
	    <span class="glyphicon glyphicon-list-alt"></span><strong>您的三轮选择汇总</strong>
	  </h3>		
	</div>
    <!-- start 数据内容-->
    <div class="table-responsive">
	  <table class="table table-striped table-hover" id="deleteTable">
	    <thead>
	      <tr>
	        <th class="text-center">学&nbsp;&nbsp;号</th>
	        <th class="text-center">学生姓名</th>
	        <th class="text-center">学&nbsp;&nbsp;院</th>
	        <th class="text-center">专&nbsp;&nbsp;业</th>
	        <th class="text-center">班&nbsp;&nbsp;级</th>
	        <th class="text-center">绩&nbsp;&nbsp;点</th>
	        <th class="text-center">性&nbsp;&nbsp;别</th>
	        <th class="text-center">qq</th>
	        <th class="text-center">电话号码</th>
	        <th class="text-center">研究方向</th>
	      </tr>
	    </thead>    
	    <tbody>	    
	      <c:forEach items="${mystudents}" var="o">
	        <tr>
	          <td class="text-center">${o.studentId }</td>
			  <td class="text-center">${o.name }</td>
			  <td class="text-center">${o.institute.instituteName }</td>
			  <td class="text-center">${o.major.majorName }</td>
			  <td class="text-center">${o.whichclass }</td>
			  <td class="text-center">${o.gpa }</td>
			  <c:if test="${o.sex == 1 }">
			  	<td class="text-center">男</td>
			  </c:if>
			  <c:if test="${o.sex == 2 }">
			  	<td class="text-center">女</td>
			  </c:if>			  
			  <td class="text-center">${o.qq }</td>
			  <td class="text-center">${o.telephone }</td>
	          <td class="text-center">
	            <a href="#" class="btn btn-mini" rel="popover" data-original-title="研究方向" data-content="${o.studentNote }" data-placement="top" data-trigger="hover"><span class="glyphicon glyphicon-info-sign"></span></a>
	          </td>
	        </tr>
	      </c:forEach>    
	    </tbody>
	  </table>
    </div>
    <!-- end数据内容-->    
    
    <div class="panel-footer">
    </div>                   
  </div>
  <!-- end 已选管理-->
  
  </div>
</div>
<!-- end #main-content -->


</body>
<jsp:include page="/index/admin-index-footer.jsp" />
</html>
