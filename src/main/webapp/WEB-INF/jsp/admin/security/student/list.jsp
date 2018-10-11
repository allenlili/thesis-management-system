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
	  <h3 class="panel-title"><span class="glyphicon glyphicon-list-alt"></span><strong>学生管理</strong></h3>		
	</div>
	
	<!--主体--> 
    <div class="panel-body">
      <!-- start查询内容-->
      <p><span class="glyphicon glyphicon-arrow-right"></span><strong>学生查询</strong></p>
      <form id="queryForm" action="${pageContext.request.contextPath}/security/student!findPage.action" method="post">
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
      <form action="${pageContext.request.contextPath }/security/student!delete.action">   	   
      <div id="execute">
        <input type="button" class="btn btn-default" onclick="location.href='${pageContext.request.contextPath }/security/student!toAdd.action'" value="添加学生">
        <input type="submit" class="btn btn-default" value="删除学生">
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
	  <table class="table table-striped table-hover table-bordered">
	    <thead>
	      <tr>
	        <th class="text-center"><input type="checkbox" id="checkboxes" value="checkbox0"></th>
	        <th class="text-center">&nbsp;届&nbsp;</th>
	        <th class="text-center">学&nbsp;&nbsp;号</th>
	        <th class="text-center">学生姓名</th>
	        <th class="text-center">学&nbsp;&nbsp;院</th>
	        <th class="text-center">专&nbsp;&nbsp;业</th>
	        <th class="text-center">班&nbsp;&nbsp;级</th>
	        <th class="text-center">性&nbsp;&nbsp;别</th>
	        <th class="text-center">电话号码</th>
	        <th class="text-center">操&nbsp;&nbsp;作</th>
	      </tr>
	    </thead>    
	    <tbody>
	      <c:forEach items="${page.result}" var="o">
	        <tr>
	          <td class="text-center"><input type="checkbox" name="ids" class="singleCheckbox" value="${o.id }"></td>
	          <td class="text-center">${o.whichGrade }</td>
	          <td class="text-center">${o.studentId }</td>
			  <td class="text-center">${o.name }</td>
			  <td class="text-center">${o.institute.instituteName }</td>
			  <td class="text-center">${o.major.majorName }</td>
			  <td class="text-center">${o.whichclass }</td>
			  <c:if test="${o.sex == 1 }">
			  	<td class="text-center">男</td>
			  </c:if>
			  <c:if test="${o.sex == 2 }">
			  	<td class="text-center">女</td>
			  </c:if>			  
			  <td class="text-center">${o.telephone }</td>
	          <td class="text-center">
	            <a href="${pageContext.request.contextPath}/security/student!toUpdate.action?id=${o.id}">修改</a>
	          </td>
	        </tr>
	      </c:forEach>    
	    </tbody>
	  </table>
    </div>
    <!-- end数据内容-->    
    
      </form><!-- end 删除内容-->
    <div class="panel-footer">
	    <form action="${pageContext.request.contextPath}/security/student!uploadStuInfo.action" method="post" enctype="multipart/form-data">
	      <div class="form-group">
	        <label for="exampleInputFile" class="text-muted">自动初始化学生信息</label>
	        <span class="alert-warning">${infoString}</span>
	        <input type="file" id="exampleInputFile" name="stuinfo" class="form-control"/>
	        <p class="help-block">功能说明：按照模版格式上传信息，即初始化用户数据以及学生信息。</p>
	        <input type="submit" class="form-control" value="上&nbsp;&nbsp;传"/>
	      </div>          
	    </form>
    </div>                   
  </div>
  <!-- end 学生管理--> 
  
  </div>
</div>
<!-- end #main-content -->


</body>
<jsp:include page="/index/admin-index-footer.jsp" />
</html>
