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
<jsp:include page="/index/student-index-top.jsp" />
<body>
<div id="main-content">
  <div class="container">
    <!--选择题目-->
    <div class="panel panel-primary">
       <div class="panel-heading">
          <h3 class="panel-title">我的论文题目</h3>
       </div>
       <div class="panel-body">
       <!--内容-->        
            
       <!--内容-->
       </div>
       <div class="table-responsive">
       <table class="table table-striped table-bordered table-hover table-condensed">
         <thead>
           <tr>
	        <th class="text-center">题目名称</th>
	        <th class="text-center">类&nbsp;&nbsp;型</th>
	        <th class="text-center">来&nbsp;&nbsp;源</th>
	        <th class="text-center">难易程度</th>
	        <th class="text-center">题目性质</th>
	        <th class="text-center">是否新题</th>
           </tr>
         </thead>
         <tbody>
		    <tr>
		      <td class="text-center">${topic.topicName }</td>
		      <td class="text-center">${topic.type }</td>
		      <td class="text-center">${topic.origin }</td>
		      <td class="text-center">${topic.level }</td>
		      <td class="text-center">${topic.quality }</td>
		      <td class="text-center">${topic.oldOrNew }</td>
		    </tr>
         </tbody>
       </table>
       </div>
       <div class="panel-footer">
       </div>       
    </div>
    </form>        
    <!--end 选择题目-->    
    
  </div>
</div>
<!-- end #main-content -->
</body>
<jsp:include page="/index/student-index-footer.jsp" />
</html>
