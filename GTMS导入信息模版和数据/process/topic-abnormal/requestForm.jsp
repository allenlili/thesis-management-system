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
      <form action="${pageContext.request.contextPath}/main/topic!performTask.action" method="post">
      <s:hidden name="taskId" value="%{#parameters.taskId}"></s:hidden>
      <s:hidden name="id"></s:hidden>             
      <div class="panel-body">
      <p><span class="glyphicon glyphicon-arrow-right"></span><strong>${taskName }</strong></p>
      <!--start查看内容 -->
    	  <div class="row" style="margin:5px;">
	        <div class="col-xs-4">
		      <div class="input-group">
		        <span class="input-group-addon">申请人</span>
		        <input type="text" class="form-control" name="topicName" value="${user.userName }" readonly="readonly">
		      </div>                  
	        </div>
	      </div>  
	      <div class="row" style="margin:5px;">
	        <div class="col-xs-4">
		      <div class="input-group">
		        <span class="input-group-addon">题目名称</span>
		        <input type="text" class="form-control" name="topicName" value="${topicName }" >
		      </div>                  
	        </div>
	        <div class="col-xs-4">
		      <div class="input-group">
		        <span class="input-group-addon">类&nbsp;&nbsp;型</span>
		        <input type="text" class="form-control" name="type" value="${type }" readonly="readonly">	
		      </div>                  
	        </div>
	        <div class="col-xs-4">
		      <div class="input-group">
		        <span class="input-group-addon">来&nbsp;&nbsp;源</span>
		        <input type="text" class="form-control" name="origin" value="${origin }" readonly="readonly">
		      </div>                 
	        </div>	      
	      </div>
	      <div class="row" style="margin:5px;">
	        <div class="col-xs-4">
		      <div class="input-group">
		        <span class="input-group-addon">难易程度</span>
		        <input type="text" class="form-control" name="level" value="${level }" readonly="readonly">
		      </div>                  
	        </div>
	        <div class="col-xs-4">
		      <div class="input-group">
		        <span class="input-group-addon">题目性质</span>
		        <input type="text" class="form-control" name="quality" value="${quality }" readonly="readonly">
		      </div>                  
	        </div>
	        <div class="col-xs-4">
		      <div class="input-group">
		        <span class="input-group-addon">是否新题</span>
		        <input type="text" class="form-control" name="oldOrNew" value="${oldOrNew }" readonly="readonly">
		      </div>                  
	        </div>
	      </div>
	      <div class="row" style="margin:5px;">
	        <div class="col-xs-12">
		      <div class="input-group">
			    <span class="input-group-addon">审批意见</span>
				<s:textarea name="comment" cssClass="form-control" rows="5" cssStyle="resize:none;"></s:textarea>
		      </div>                  
	        </div>
	      </div>	      	    	    	            
        <!--end-->
      </div>
      
	  <!-- start 数据内容-->
	  <div class="table-responsive">
		<table class="table table-striped table-hover">
		  <caption class="caption alert-danger text-muted"><span class="icon-hand-right"></span>Tips:以下是审评意见。</caption>
		  <thead>
		    <tr>
		      <th class="text-center">任务名称</th>
		      <th class="text-center">审批意见</th>
		    </tr>
		  </thead>    
		  <tbody>
			<!-- 审批意见 -->
			<c:forEach items="${commentList}" var="c">
		    <tr>
			  <td class="text-center" >${c.taskName }</td>
			  <td class="text-center">${c.comment }</td>
			</tr>	  
			</c:forEach>    
		  </tbody>
		</table>
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
