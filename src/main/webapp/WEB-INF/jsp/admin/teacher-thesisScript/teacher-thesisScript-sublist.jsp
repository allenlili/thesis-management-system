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
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-datetimepicker.min.css">
<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/admin.js" charset="UTF-8"></script>
<script src="${pageContext.request.contextPath}/js/common.js" charset="UTF-8"></script>
</head>
<body>
<jsp:include page="/index/admin-index-top.jsp" />
<div id="main-content">
  <div class="container">
   
  <!-- 我的稿件管理-->    
  <div class="panel panel-default">
  	<!--头部-->
    <div class="panel-heading">
	  <h3 class="panel-title"><span class="glyphicon glyphicon-list-alt"></span><strong>该学生的稿件</strong></h3>		
	</div>
	
    <!-- start 数据内容-->
    <div class="table-responsive">
	  <table class="table table-striped table-hover table-condensed table-bordered">
	    <thead>
	      <tr>
	        <input type="hidden" id="checkboxes" value="checkbox0">
	        <th class="text-center">文件名</th>
	        <th class="text-center">题&nbsp;&nbsp;目</th>
	        <th class="text-center">学&nbsp;&nbsp;生</th>
	        <th class="text-center">指导老师</th>
	        <th class="text-center">创建时间</th>
	        <th class="text-center">是否终稿</th>
	        <th class="text-center">状&nbsp;&nbsp;态</th>
	        <th class="text-center">操&nbsp;&nbsp;作</th>
	      </tr>
	    </thead>    
	    <tbody>
	      <c:forEach items="${thesisScripts}" var="o">
	        <tr>
	          <input type="hidden" name="ids" class="singleCheckbox" value="${o.id }">
	          <td class="text-center">${o.fileName }</td>
	          <td class="text-center">${o.topic.topicName }</td>
	          <td class="text-center">${o.student.name }</td>
	          <td class="text-center">${o.teacher.name }</td>
	          <td class="text-center">${o.startDate }</td>
	          <c:if test="${o.lastScript == 0}">
	            <td class="text-center">否</td>
	          </c:if>
	          <c:if test="${o.lastScript == 1}">
	          	<td class="text-center">是</td>
	          </c:if>
	          <c:if test="${o.status == 1}">
	          <td id="status" class="text-center">未审批</td>
	          </c:if>
	          <c:if test="${o.status == 2}">
	          <td id="status" class="text-center">审批中</td>
	          </c:if>
	          <c:if test="${o.status == 3}">
	          <td id="status" class="text-center">审批成功</td>
	          </c:if>	          	          
	          <td class="text-center">
	            <a href="${pageContext.request.contextPath}/main/myStudentScript!getMystudentScriptDetails.action?uuid=${o.uuid}">查看</a>
	          </td>
	        </tr>
	      </c:forEach>    
	    </tbody>
	  </table>
    </div>
    <!-- end数据内容-->    
   
    <div class="panel-footer">
    <center>
      <input type="button" class="btn btn-default" value="返&nbsp;&nbsp;&nbsp;&nbsp;回" 
      onClick="location.href='${pageContext.request.contextPath}/main/myStudentScript!findMyStudents.action'"/>
    </center>     
    </div>
      </form><!-- end 删除内容-->             
  </div>
  <!-- end 我的稿件管理--> 

   
  </div>
</div>
<!-- end #main-content -->
<!-- 操控日期 -->
<script src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script src="${pageContext.request.contextPath}/js/control-time.js" charset="UTF-8"></script>


<jsp:include page="/index/admin-index-footer.jsp" />
</body>

</html>
