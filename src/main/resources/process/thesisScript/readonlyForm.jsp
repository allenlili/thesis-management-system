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
  
    <div class="panel panel-default">
    
      <!--头部-->
      <div class="panel-heading">
        <h3 class="panel-title"><span class="glyphicon glyphicon-list-alt"></span><strong>执行任务</strong></h3>
      </div>
      
      <!--主体-->
      <form action="${pageContext.request.contextPath}/main/thesisScript!performTask.action" method="post">
      <s:hidden name="taskId" value="%{#parameters.taskId}"></s:hidden>
      <s:hidden name="id"></s:hidden>            
	  <!-- start 数据内容-->
	  <div class="table-responsive">
		  <table class="table table-striped table-hover">
		    <thead>
		      <tr>
		        <input type="hidden" id="checkboxes" value="checkbox0">
		        <th class="text-center">文件名</th>
		        <th class="text-center">创建时间</th>
		        <th class="text-center">操&nbsp;&nbsp;作</th>
		      </tr>
		    </thead>    
		    <tbody>
		        <tr>
		          <input type="hidden" name="ids" class="singleCheckbox" value="${id }">
		          <td class="text-center">${fileName }</td>
		          <td class="text-center">${startDate }</td>
		          <td class="text-center">                        
		            <a href="${pageContext.request.contextPath}/main/download.action?fileUuid=${uuid}">下&nbsp;&nbsp;载</a>
		          </td>
		        </tr>
		    </tbody>
		  </table>
		</div>
		<div class="panel-body">  
	    <div class="row" style="margin:5px;">
	      <div class="col-xs-12">
		    <div class="input-group">
			  <label class="">学生问题：</label>
		      <s:textarea name="question" cssClass="form-control" rows="5" cols="200" cssStyle="resize:none;" readonly="true"></s:textarea>
		    </div>                  
	      </div>
	    </div>
        <div class="row" style="margin:5px;">
          <div class="col-xs-12">
            <label class="">老师回复：</label>
	        <div class="input-group">
			  <s:textarea name="answer" cssClass="form-control" rows="5" cols="200" cssStyle="resize:none;" ></s:textarea>
	        </div>                  
          </div>
        </div>
        </div>		  
	  <!-- end数据内容--> 
	
      <!--底部-->
      <div class="panel-footer">
	      <center>
		      <div class="btn-group" id="input" style="margin:5px;">
		        <s:iterator value="#buttonList" var="v">
		          <input name="transition" type="submit" value="${v }" class="btn btn-default"/>
		        </s:iterator>  
		          <input type="button" class="btn btn-default" value="返回" 
		        onClick="location.href='#'"/>
		      </div>   
	      </center>   
      </div>
      </form>
      
    </div>  
    	       
  </div>
</div>
<!-- end #main-content -->
<jsp:include page="/index/admin-index-footer.jsp" />
</body>
</html>
