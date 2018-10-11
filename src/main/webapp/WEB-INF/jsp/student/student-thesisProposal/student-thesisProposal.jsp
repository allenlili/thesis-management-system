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
   
  <!-- 我的开题报告-->    
  <div class="panel panel-primary">
  	<!--头部-->
    <div class="panel-heading">
	  <h3 class="panel-title"><span class="glyphicon glyphicon-list-alt"></span><strong>我的开题报告</strong></h3>		
	</div>
    <form id="performForm" action="${pageContext.request.contextPath }/main/thesisProposal!start.action">
    <s:hidden name="definitionKey" value="%{@com.zhbit.core.utils.EnumStatus.ProcessEnum@thesisProposal}"></s:hidden>
    <!-- start 启动内容-->
    <!-- start 数据内容-->
    <div class="table-responsive">
	  <table class="table table-striped table-hover">
	    <thead>
	      <tr>
	        <input type="hidden" id="checkboxes" value="checkbox0">
	        <th class="text-center">题&nbsp;&nbsp;目</th>
	        <th class="text-center">学&nbsp;&nbsp;生</th>
	        <th class="text-center">指导老师</th>
	        <th class="text-center">创建时间</th>
	        <th class="text-center">状&nbsp;&nbsp;态</th>
	        <th class="text-center">操&nbsp;&nbsp;作</th>
	      </tr>
	    </thead>    
	    <tbody>
	        <tr>
	          <input type="hidden" name="ids" class="singleCheckbox" value="${thesisProposal.id }">
	          <td class="text-center">${thesisProposal.topic.topicName }</td>
	          <td class="text-center">${thesisProposal.student.name }</td>
	          <td class="text-center">${thesisProposal.teacher.name }</td>
	          <td class="text-center">${thesisProposal.startDate }</td>
	          <c:if test="${thesisProposal.status == 1}">
	          <td id="status" class="text-center">未审批</td>
	          </c:if>
	          <c:if test="${thesisProposal.status == 2}">
	          <td id="status" class="text-center">审批中</td>
	          </c:if>
	          <c:if test="${thesisProposal.status == 3}">
	          <td id="status" class="text-center">审批成功</td>
	          </c:if>	          	          
	          <c:if test="${thesisProposal.status == 1}">
	          <td class="text-center">
	            <a href="${pageContext.request.contextPath}/main/thesisProposal!toUpdate.action?id=${thesisProposal.id}">修改</a>
	          </td>
	          </c:if>
	          <c:if test="${thesisProposal.status == 2}">	          
	          <td class="text-center">                        
	            <a href="${pageContext.request.contextPath }/process/myInstance!watch.action?id=${thesisProposal.id}&definitionKey=<s:property value="@com.zhbit.core.utils.EnumStatus.ProcessEnum@thesisProposal"/>">流程监控</a>
	            &nbsp;&nbsp;
	            <a href="${pageContext.request.contextPath }/main/thesisProposal!watch.action?id=${thesisProposal.id}&definitionKey=<s:property value='@com.zhbit.core.utils.EnumStatus.ProcessEnum@thesisProposal'/>">查看</a>
	          </td>
	          </c:if>
	          <c:if test="${thesisProposal.status == 3 || thesisProposal.status == 4}">	          
	          <td class="text-center">                        
	            <a href="${pageContext.request.contextPath }/main/thesisProposal!watch.action?id=${thesisProposal.id}&definitionKey=<s:property value='@com.zhbit.core.utils.EnumStatus.ProcessEnum@thesisProposal'/>">查看</a>
	          </td>
	          </c:if>	          	
	        </tr>
	    </tbody>
	  </table>
    </div>
	
	<c:if test="${thesisProposal.status == 1}">    
    <center>
    <div id="startProcess" class="input-group">
      <input id="startProcess" type="submit" class="btn btn-default" value="启动审批流程">         
    </div>
    </center>
    </c:if>    
    <!-- end数据内容-->    
    <div class="panel-footer">
    </div>
    </form>
    <!-- end 启动内容-->             
  </div>
  <!-- end 我的开题报告--> 
  </div>
</div>
<!-- end #main-content -->
<!-- 操控日期 -->
<jsp:include page="/index/student-index-footer.jsp" />
</body>

</html>
