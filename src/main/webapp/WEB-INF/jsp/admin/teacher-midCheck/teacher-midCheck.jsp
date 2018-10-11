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
<jsp:include page="/index/admin-index-top.jsp" />
<div id="main-content">
  <div class="container">
   
  <!-- 我的中期检查-->    
  <div class="panel panel-default">
  	<!--头部-->
    <div class="panel-heading">
	  <h3 class="panel-title"><span class="glyphicon glyphicon-list-alt"></span><strong>我的中期检查表</strong></h3>		
	</div>
    <form id="performForm" action="${pageContext.request.contextPath }/main/thesisProposal!start.action">
    <s:hidden name="definitionKey" value="%{@com.zhbit.core.utils.EnumStatus.ProcessEnum@thesisProposal}"></s:hidden>
    <!-- start 启动内容-->
    <!-- start 数据内容-->
    <div class="table-responsive">
	  <table class="table table-striped table-hover table-bordered table-condensed">
	    <thead>
	      <tr>
	        <input type="hidden" id="checkboxes" value="checkbox0">
	        <th class="text-center">指导老师</th>
	        <th class="text-center">创建时间</th>
	        <th class="text-center">操&nbsp;&nbsp;作</th>
	      </tr>
	    </thead>    
	    <tbody>
	    	<c:if test="${midCheck != null }">
	        <tr>
	          <input type="hidden" name="ids" class="singleCheckbox" value="${midCheck.id }">
	          <td class="text-center">${midCheck.teacher.name }</td>
	          <td class="text-center">${midCheck.startDate }</td>
	          <td class="text-center">
	            <a href="${pageContext.request.contextPath}/main/midCheck!toUpdate.action?id=${midCheck.id}">修改</a>
	          </td>
	        </tr>
	        </c:if>
	    </tbody>
	  </table>
    </div>
	
	<c:if test="${midCheck == null}">    
    <center>
    <div id="startProcess" class="input-group">
      <input type="button" class="btn btn-default" value="创建中期检查" onclick="location.href='${pageContext.request.contextPath}/main/midCheck!createMidCheck.action'"/>         
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
<jsp:include page="/index/admin-index-footer.jsp" />
</body>

</html>
