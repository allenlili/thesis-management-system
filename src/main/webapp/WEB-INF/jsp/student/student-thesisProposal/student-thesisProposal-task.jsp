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
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/student-style.css">
<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/student.js"></script>
<script src="${pageContext.request.contextPath}/js/common.js"></script>
</head>
<body>
<jsp:include page="/index/student-index-top.jsp" />
<div id="main-content">
  <div class="container">
   
  <!-- 用户管理-->    
  <div class="panel panel-primary">
  	<!--头部-->
    <div class="panel-heading">
	  <h3 class="panel-title"><span class="glyphicon glyphicon-list-alt"></span><strong>待办任务管理</strong></h3>		
	</div>
	
    <!-- start 数据内容-->
    <div class="table-responsive">
	  <table class="table table-striped table-hover">
	    <thead>
	      <tr>
	        <th class="text-center"><input type="hidden" id="checkboxes" value="checkbox0"></th>
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
	          <td class="text-center"><input type="hidden" name="ids" class="singleCheckbox" value="${task.id }"></td>
        	  <td class="text-center">${task.name }</td>
              <td class="text-center">
			    <s:property value="task.createTime"/>        
              </td>
              <td class="text-center">${model.user.userName }/${model.user.realName }</td>
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
