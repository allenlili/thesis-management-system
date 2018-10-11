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
<jsp:include page="/index/student-index-top.jsp" />
<div id="main-content">
  <div class="container">
   
  <!-- 待办任务管理-->    
  <div class="panel panel-primary">
  	<!--头部-->
    <div class="panel-heading">
	  <h3 class="panel-title"><span class="glyphicon glyphicon-list-alt"></span><strong>待办任务管理</strong></h3>		
	</div>
	
	<!--主体--> 
    <div class="panel-body">
      <!-- start查询内容-->
      <p><span class="glyphicon glyphicon-arrow-right"></span><strong>待办任务查询</strong></p>
      <form id="queryForm" action="${pageContext.request.contextPath}/process/task!findPage.action" method="post">

      <div class="row">
        <div class="col-xs-6">
	      <div class="input-group">
	        <span class="input-group-addon">流程列表</span>
            <s:select name="definitionKey" list="@com.zhbit.core.utils.EnumStatus.ProcessEnum@values()" listValue="value" headerKey="" headerValue="全部" cssClass="form-control"></s:select>	        
	      </div>                  
        </div>     
        <div class="col-xs-6">
	      <div class="input-group">
	        <input type="text" class="form-control" placeholder="任务名称" name="taskName">
	        <span class="input-group-btn">
	          <button class="btn btn-default" type="button" id="queryButton">Go!</button>
	        </span>          
	      </div>                  
        </div>
      </div>               
      </form> 
      <!-- end查询内容-->

      <!-- start删除内容-->
      <form action="${pageContext.request.contextPath }/process/task!delete.action">   	   
      <div id="execute">
        <input type="submit" class="btn btn-default" value="删除待办任务">
        <button type="button" class="btn btn-default" id="queryButton">查询待办任务</button>
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
	        <th class="text-center"><input type="checkbox" id="checkboxes" value="checkbox0"></th>
	        <th class="text-center">任务名称</th>
	        <th class="text-center">开始时间</th>
	        <th class="text-center">申请人</th>
	        <th class="text-center">流程名称</th>
	        <th class="text-center">操作</th>	               
	      </tr>
	    </thead>    
	    <tbody>
	      <s:iterator value="#page.result">
	        <tr>
	          <td class="text-center"><input type="checkbox" name="ids" class="singleCheckbox" value="${task.id }"></td>
        	  <td class="text-center">${task.name }</td>
              <td class="text-center">
			    <s:property value="task.createTime"/>        
              </td>
              <td class="text-center">${model.user.userName }</td>
              <td class="text-center">${processName }</td>
              <td class="text-center"><a href="${pageContext.request.contextPath }/process/task!toTask.action?taskId=${task.id}">执行任务</a></td>	          
	        </tr>
	      </s:iterator>    
	    </tbody>
	  </table>
    </div>
    <!-- end数据内容-->
    
    <div class="panel-footer">
    </div>
      </form><!-- end 删除内容-->             
  </div>
  <!-- end 任务管理--> 

   
  </div>
</div>
<!-- end #main-content -->

<jsp:include page="/index/student-index-footer.jsp" />
</body>

</html>
