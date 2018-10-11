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
<script type="text/javascript">
function startProcess() {
	$('#performForm').attr('action', '${pageContext.request.contextPath }/main/thesisScript!start.action');
	$('#performForm').submit();
}
</script>
</head>
<body>
<jsp:include page="/index/admin-index-top.jsp" />
<div id="main-content">
  <div class="container">
   
  <!-- 指导意见表-->    
  <div class="panel panel-default">
  	<!--头部-->
    <div class="panel-heading">
	  <h3 class="panel-title"><span class="glyphicon glyphicon-list-alt"></span><strong>指导意见表</strong></h3>		
	</div>
	
    <!-- start 数据内容-->
    <div class="table-responsive">
	  <table class="table table-striped table-hover table-bordered">
	  <caption class="caption alert-danger text-muted"><span class="icon-hand-right"></span>只有一次提交机会！</caption>
	    <thead>
	      <tr>
	        <input type="hidden" id="checkboxes" value="checkbox0">
	        <th class="text-center">学&nbsp;&nbsp;号</th>
	        <th class="text-center">学&nbsp;&nbsp;生</th>
	        <th class="text-center">题&nbsp;&nbsp;目</th>
	        <th class="text-center">终&nbsp;&nbsp;稿</th>
	        <th class="text-center">指导分数</th>
	        <th class="text-center">是否同意答辩</th>
	        <th class="text-center">确认时间</th>
	        <c:if test="${teacher.forwardTutorGradeStatus == 1 }">
	        <th class="text-center">操&nbsp;&nbsp;作</th>
	        </c:if>
	        <c:if test="${teacher.forwardTutorGradeStatus == 3 }">
	        <th class="text-center">指导意见</th>
	        </c:if>
	      </tr>
	    </thead>    
	    <tbody>
	      <c:forEach items="${students}" var="o">
	        <tr>
	          <input type="hidden" name="ids" class="singleCheckbox" value="${o.id }">
	          <td class="text-center">${o.studentId }</td>
	          <td class="text-center">${o.name }</td>
	          <td class="text-center">${o.topic.topicName }</td>
	          <td class="text-center"><a href="${pageContext.request.contextPath}/main/download.action?fileUuid=${o.lastThesisScript.uuid}">${o.lastThesisScript.fileName }</a></td>
	          <td class="text-center">${o.tutorAdvice.tutorGrade }</td>
	          
	          <c:if test="${o.tutorAdvice == null}">
	            <td class="text-center"></td>
	          </c:if>	          
	          <c:if test="${o.tutorAdvice.agreeOrNot == 0}">
	            <td class="text-center">否</td>
	          </c:if>
	          <c:if test="${o.tutorAdvice.agreeOrNot == 1 }">
	            <td class="text-center">是</td>
	          </c:if>
	          
	          <td class="text-center">${o.tutorAdvice.startDate }</td>
	          
	          <c:if test="${o.tutorAdvice == null && o.lastThesisScript != null}">
	          <td class="text-center">
	            <a href="${pageContext.request.contextPath}/main/tutorAdvice!toAdd.action?studentUuid=${o.uuid}">创建</a>
	          </td>
	          </c:if>
	          <c:if test="${o.tutorAdvice == null && o.lastThesisScript == null}">
	          <td class="text-center"><span class="icon-hand-right"></span>该学生未提交终稿</td>
	          </c:if>
	          
	          <c:if test="${o.tutorAdvice.status == 1 }">
	          <td class="text-center">
	            <a href="${pageContext.request.contextPath}/main/tutorAdvice!toUpdate.action?id=${o.tutorAdvice.id}">修改</a>
	          </td>
	          </c:if>
	          
	          <c:if test="${o.tutorAdvice.status == 3 }">
	          <td class="text-center">
<%-- 	            <a href="${pageContext.request.contextPath}/main/tutorAdvice!watch.action?id=${o.tutorAdvice.id}">查看</a> --%>
	            <a href="#" class="btn btn-mini" rel="popover" data-original-title="指导意见" data-content="${o.tutorAdvice.opinion}" data-placement="top" data-trigger="hover"><span class="glyphicon glyphicon-info-sign"></span></a>
	          </td>
	          </c:if>
	          
	        </tr>
	      </c:forEach>    
	    </tbody>
	  </table>
    </div>
    <!-- end数据内容-->
    <div class="panel-footer">
    <center>
      <c:if test="${teacher.forwardTutorGradeStatus == 1 }">
      <input type="button" class="btn btn-default" value="提&nbsp;&nbsp;&nbsp;&nbsp;交" onClick="startForward();"/>
      </c:if>  
      <input type="button" class="btn btn-default" value="返&nbsp;&nbsp;&nbsp;&nbsp;回" onClick="location.href='${pageContext.request.contextPath}/admin-index.jsp'"/>
    </center> 
    <script type="text/javascript">
    	function startForward(){
    		var answer = confirm("只有一次提交机会，你真的提交了吗？");
    		if(answer == true){
    			url='${pageContext.request.contextPath}/main/tutorAdvice!forwardTutorAdvice.action';
    			$.post(url);
    			window.location.reload();
    		}
    	}
    </script>   
    </div>
      </form><!-- end 删除内容-->             
  </div>
  <!-- end 指导意见表--> 

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
