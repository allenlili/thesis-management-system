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
   
  <!-- 学生管理-->    
  <div class="panel panel-default">
  	<!--头部-->
    <div class="panel-heading">
	  <h3 class="panel-title"><span class="glyphicon glyphicon-list-alt"></span><strong>指导记录表</strong></h3>		
	</div>
	
	<!--主体--> 
    <div class="panel-body">
      <!-- start查询内容-->
      <p><span class="glyphicon glyphicon-arrow-right"></span><strong>学生查询</strong></p>
      <form id="queryForm" action="${pageContext.request.contextPath}/main/tutorRecorder!findPage.action" method="post">
      <div class="row">
        <div class="col-xs-6">      
	      <div class="input-group">
	        <input type="text" class="form-control" placeholder="姓名" name="name">
	        <span class="input-group-btn">
	          <button class="btn btn-default" type="button" id="queryButton">Go!</button>
	        </span>          
	      </div>
	    </div>
	    <div class="col-xs-6">  
	      <div class="input-group">
	        <input type="text" class="form-control" placeholder="学号" name="studentId">
	        <span class="input-group-btn">
	          <button class="btn btn-default" type="button" id="queryButton2">Go!</button>
	        </span>          
	      </div>
	    </div>
	  </div>                       
      </form> 
      <!-- end查询内容-->

      <!-- start删除内容-->
      <div id="execute">
        <button type="button" class="btn btn-default" id="queryButton">查询学生</button>
      </div>
        			                               
      <!-- start分页内容-->
      <div id="page">	            
        <%@include file="/page.jsp"%> 		
	  </div>
      <!-- end 分页内容-->          
    </div>
           
    <!-- start 数据内容-->
    <div class="table-responsive">
	  <table class="table table-striped table-hover">
	    <thead>
	      <tr>
<!-- 	        <th class="text-center"><input type="checkbox" id="checkboxes" value="checkbox0"></th> -->
	        <th class="text-center">学&nbsp;&nbsp;号</th>
	        <th class="text-center">学生姓名</th>
	        <th class="text-center">学&nbsp;&nbsp;院</th>
	        <th class="text-center">专&nbsp;&nbsp;业</th>
	        <th class="text-center">班&nbsp;&nbsp;级</th>
	        <th class="text-center">绩&nbsp;&nbsp;点</th>
	        <th class="text-center">性&nbsp;&nbsp;别</th>
	        <th class="text-center">qq</th>
	        <th class="text-center">电话号码</th>
	        <th class="text-center">操&nbsp;&nbsp;作</th>
	      </tr>
	    </thead>    
	    <tbody>
	      <c:forEach items="${page.result}" var="o">
	        <tr>
<%-- 	          <td class="text-center"><input type="checkbox" name="ids" class="singleCheckbox" value="${o.id }"></td> --%>
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
	            <a href="${pageContext.request.contextPath}/main/tutorRecorder!watch.action?id=${o.id}">查看指导记录</a>
	          </td>
	        </tr>
	      </c:forEach>    
	    </tbody>
	  </table>
    </div>
    <!-- end数据内容-->    
    
      </form><!-- end 删除内容-->
    <div class="panel-footer">
    </div>                   
  </div>
  <!-- end 学生管理--> 
  
  </div>
</div>
<!-- end #main-content -->


</body>
<jsp:include page="/index/admin-index-footer.jsp" />
</html>
