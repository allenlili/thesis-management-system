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
  <c:if test="${student.taskBook == null }">
    <center>
    <caption class="caption alert-danger text-muted"><span class="icon-hand-right"></span>Tips:您的任务书还没有下达，不能填写开题报告！</caption>
    </center>  	
  </c:if>
  <c:if test="${student.taskBook != null }">
    <div class="panel panel-primary">
    
      <!--头部-->
      <div class="panel-heading">
        <h3 class="panel-title">
          <span class="glyphicon glyphicon-list-alt"></span><strong>我的开题报告</strong>
          <span>${error }</span>
        </h3>
      </div>
      
      <!--主体-->      
      <div class="panel-body">
      <p><span class="glyphicon glyphicon-arrow-right"></span><strong>创建开题报告</strong></p>
      <!--start增加内容 -->
      <form action="${pageContext.request.contextPath}/main/thesisProposal!save.action" method="post">      
        <div class="row" style="margin:5px;">
          <label class="">一、研究的现状及其意义</label>
          <div class="col-xs-12">
	        <div class="input-group">
			  <s:textarea name="firstContent" cssClass="form-control" rows="3" cols="200"></s:textarea>
	        </div>                  
          </div>
        </div>
        <div class="row" style="margin:5px;">
          <label class="">二、研究目标、研究内容和拟解决的关键问题</label>
          <div class="col-xs-12">
	        <div class="input-group">
			  <s:textarea name="secondContent" cssClass="form-control" rows="3" cols="200"></s:textarea>
	        </div>                  
          </div>
        </div>
        <div class="row" style="margin:5px;">
          <label class="">三、研究的基本思路和方法、技术路线、实验方案及可行性分析</label>
          <div class="col-xs-12">
	        <div class="input-group">
			  <s:textarea name="thirdContent" cssClass="form-control" rows="3" cols="200"></s:textarea>
	        </div>                  
          </div>
        </div>
        <div class="row" style="margin:5px;">
          <label class="">四、研究计划及进度安排</label>
          <div class="col-xs-12">
	        <div class="input-group">
			  <s:textarea name="fourthContent" cssClass="form-control" rows="3" cols="200"></s:textarea>
	        </div>                  
          </div>
        </div>
        <div class="row" style="margin:5px;">
          <label class="">五、参考文献</label>
          <div class="col-xs-12">
	        <div class="input-group">
			  <s:textarea name="fifthContent" cssClass="form-control" rows="5" cols="200"></s:textarea>
	        </div>                  
          </div>
        </div>                        	    
        <!--end  增加内容 -->
        <center>
        <div class="btn-group" id="input">
          <input type="submit" class="btn btn-default" value="创&nbsp;&nbsp;&nbsp;&nbsp;建"/>
          <input type="button" class="btn btn-default" value="返&nbsp;&nbsp;&nbsp;&nbsp;回" 
          onClick="location.href='${pageContext.request.contextPath}/main/thesisProposal!findPage.action?status=<s:property value="@com.zhbit.core.utils.EnumStatus.StatusEnum@unstart.value"/>'"/>
        </div>
        </center>        
      </form>
      </div>
      <!--底部-->
      <div class="panel-footer">
      </div>
      
    </div>  
   </c:if>    	       
  </div>
</div>
<!-- end #main-content -->
<jsp:include page="/index/student-index-footer.jsp" />
</body>
</html>
