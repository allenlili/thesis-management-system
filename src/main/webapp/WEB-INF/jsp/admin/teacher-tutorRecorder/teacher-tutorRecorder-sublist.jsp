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
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/font-awesome/css/font-awesome.css">
<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/admin.js"></script>
<script src="${pageContext.request.contextPath}/js/common.js"></script>
</head>
<body>
<jsp:include page="/index/admin-index-top.jsp" />
<div id="main-content">
  <div class="container">
   
  <!-- 指导记录-->    
  <div class="panel panel-default">
  	<!--头部-->
    <div class="panel-heading">
	  <h3 class="panel-title"><span class="glyphicon glyphicon-list-alt"></span><strong>该学生指导记录</strong></h3>		
	</div>
    <!-- start 数据内容-->
    <div class="table-responsive">
	  <table class="table table-striped table-hover  table-bordered">
	    <thead>
	      <tr>
	        <th class="text-center">学&nbsp;&nbsp;号</th>
	        <th class="text-center">姓&nbsp;&nbsp;名</th>
	        <th class="text-center">专&nbsp;&nbsp;业</th>
	        <th class="text-center">届&nbsp;&nbsp;别</th>
	        <th class="text-center">指导老师</th>
	        <th class="text-center">论文题目</th>
	      </tr>
	    </thead>    
	    <tbody>
	        <tr>
	          <td class="text-center">${result.student.studentId }</td>
			  <td class="text-center">${result.student.name }</td>
			  <td class="text-center">${result.student.major.majorName }</td>
			  <td class="text-center">${result.student.whichGrade }</td>
			  <td class="text-center">${result.teacher.name }</td>
			  <td class="text-center">${result.student.topic.topicName }</td>
	        </tr>
	    </tbody>
	  </table>
    </div>
    <!-- end数据内容-->	
    <!-- start 数据内容-->
    <div class="table-responsive">
	  <table class="table table-striped table-hover table=condensed">
	  <caption class="caption alert-danger text-muted"><span class="icon-hand-right"></span>指导记录</caption>
	    <thead>
	      <tr>
	        <th class="text-center">序&nbsp;&nbsp;号</th>
	        <th class="text-center">创建日期</th>
	        <th class="text-center">进展情况</th>
	        <th class="text-center">所遇到的问题</th>
	        <th class="text-center">给予的指导</th>
	      </tr>
	    </thead>    
	    <tbody>
	    	<s:iterator value="#result.tutorRecorders" var="o">
	        <tr>
	          <td class="text-center">${o.id }</td>
			  <td class="text-center">${o.startDate }</td>
			  <td class="text-center">${o.progress }</td>
			  <td class="text-center">${o.question }</td>
			  <td class="text-center">${o.answer }</td>
	        </tr>
	        </s:iterator>  
	    </tbody>
	  </table>
    </div>
    <!-- end数据内容-->    
    
    <div class="panel-footer">
	  <input type="button" class="form-control" value="返&nbsp;&nbsp;回" onclick="javascript:history.go(-1);"/>
    </div>                   
  </div>
  <!-- end 指导记录--> 
  
  </div>
</div>
<!-- end #main-content -->


</body>
<jsp:include page="/index/admin-index-footer.jsp" />
</html>
