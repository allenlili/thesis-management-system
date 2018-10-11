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
<script src="${pageContext.request.contextPath}/js/common.js"></script>
<script src="${pageContext.request.contextPath}/js/student.js"></script>
<script src="${pageContext.request.contextPath}/js/headroom.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jQuery.headroom.min.js"></script>
<style type="text/css">  
    .headroom{
    	position: fixed;
    	top: 0px;left: 0;
    	right: 0;
    	transition: all .2s ease-in-out;}  
    .headroom--unpinned{top: -100px;}  
    .headroom--pinned{top: 0px;}  
</style>
<script type="text/javascript">
  	$("doucument").ready(function(){
 		 $('#nav').headroom();
   	});
</script> 
</head>

<body>
<nav id="nav" class="navbar navbar-default" role="navigation">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="${pageContext.request.contextPath }/student-index.jsp"><i class="icon-home"></i>GTMS</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <li><a href="${pageContext.request.contextPath}/chooseTutor/student!findPossibleTeachers.action"><i class="icon-user"></i>我的指导老师</a></li>
        <li><a href="${pageContext.request.contextPath}/main/myTopic!selectMyTopic.action"><i class="icon-book"></i>我的论文选题</a></li>
        <li><a href="${pageContext.request.contextPath}/main/myTaskBook!selectMyTaskBook.action"><i class="icon-book"></i>我的任务书</a></li>
        <li><a href="${pageContext.request.contextPath}/main/thesisProposal!selectMyThesisProposal.action"><i class="icon-book"></i>我的开题报告</a></li>
        <li><a href="${pageContext.request.contextPath}/main/thesisScript!findPage.action"><i class="icon-book"></i>我的论文稿件</a></li>
        <li><a href="${pageContext.request.contextPath}/main/mark!findMyMark.action"><i class="icon-star"></i>我的论文成绩</a></li>
<!--         <li><a href="#"><i class="icon-book"></i>相关文件下载</a></li> -->
 <!--
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret"></b></a>
          <ul class="dropdown-menu">
            <li><a href="#">Action</a></li>
            <li><a href="#">Another action</a></li>
            <li><a href="#">Something else here</a></li>
            <li class="divider"></li>
            <li><a href="#">Separated link</a></li>
            <li class="divider"></li>
            <li><a href="#">One more separated link</a></li>
          </ul>
        </li>
      </ul>

      <ul class="nav navbar-nav navbar-right">
        <li><a href="#">Link</a></li>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret"></b></a>
          <ul class="dropdown-menu">
            <li><a href="#">Action</a></li>
            <li><a href="#">Another action</a></li>
            <li><a href="#">Something else here</a></li>
            <li class="divider"></li>
            <li><a href="#">Separated link</a></li>
          </ul>
        </li>
      </ul>
-->      
    </div><!-- /.navbar-collapse -->
</nav>
</body>
</html>
