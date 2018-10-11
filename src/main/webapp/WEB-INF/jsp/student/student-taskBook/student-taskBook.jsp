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
  
  <!-- 我的任务书：加载部分信息-->    
    <div class="panel panel-primary">
       <div class="panel-heading">
          <h3 class="panel-title">我的任务书</h3>
       </div>
       <div class="panel-body">
       <c:if test="${taskBook == null }">
       <center>
       <caption class="caption alert-danger text-muted"><span class="icon-hand-right"></span>Tips:您的任务书还没有下达！</caption>
       </center>
       </c:if>  
         <!-- start 内容-->
	       <div class="row" style="margin:5px;">
	         <div class="col-xs-12">
		       <div class="input-group">
			     <span class="input-group-addon">一、主要研究内容：</span>
				 <s:textarea name="#taskBook.firstContent" cssClass="form-control" rows="5" cssStyle="resize:none;" readonly="true"></s:textarea>
		       </div>                  
	         </div>
	       </div>
	       <div class="row" style="margin:5px;">
	         <div class="col-xs-12">
		       <div class="input-group">
			     <span class="input-group-addon">二、主要任务目标：</span>
				 <s:textarea name="#taskBook.secondContent" cssClass="form-control" rows="5" cssStyle="resize:none;" readonly="true"></s:textarea>
		       </div>                  
	         </div>
	       </div>
         <!-- end内容-->   
       </div>
    </div>
       
  </div>
</div>
<!-- end #main-content -->
</body>
<jsp:include page="/index/student-index-footer.jsp" />
</html>
