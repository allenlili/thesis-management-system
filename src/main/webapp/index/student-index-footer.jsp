<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="GTMS是一个高效的毕业论文管理系统">
<title>GTMS</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/font-awesome/css/font-awesome.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/student-style.css">
<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/student.js"></script>
<script src="${pageContext.request.contextPath}/js/common.js"></script>
<script src="${pageContext.request.contextPath}/js/headroom.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jQuery.headroom.min.js"></script>
<style type="text/css">  
    .headroom2 {
    	position: fixed;
    	bottom: 0px;left: 0;
    	right: 0;
    	transition: all .2s ease-in-out;}  
    .headroom--unpinned2 {bottom: -100px;}  
    .headroom--pinned2 {bottom: 0;}  
</style>  
<script type="text/javascript">
  	$("doucument").ready(function(){
 		 $(".navbar-fixed-bottom").headroom({
 			  "tolerance": 0,
 			  "offset": 0,
 			  "classes": {
 			  "initial": "headroom2",
 			  "pinned": "headroom--pinned2",
 			  "unpinned": "headroom--unpinned2"
 	        }
 	     });
   	});
</script> 
</head>

<body>
<nav class="navbar navbar-default navbar-fixed-bottom navbar-inverse" role="navigation">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-2">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#">北京理工大学珠海学院</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-2">	
      <ul class="nav navbar-nav navbar-right">
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">欢迎！${currentUser.userName }<b class="caret"></b></a>
          <ul class="dropdown-menu">
            <li><a href="${pageContext.request.contextPath}/me/me!toUpdateStuInfo.action"><i class="icon-user-md"></i>个人信息</a></li>
            <li class="divider"></li>
            <li><a href="${pageContext.request.contextPath}/me/me!toModifyStuUserInfo.action"><i class="icon-lock"></i>密码设置</a></li>
            <c:if test="${currentUser.userName==null}">
              <li class="divider"></li>
              <li><a href="${pageContext.request.contextPath }/login.jsp"><span class="glyphicon glyphicon-log-in"></span>&nbsp;登&nbsp;录</a></li>
            </c:if>
            <c:if test="${currentUser.userName!=null}">
            <li class="divider"></li>
            <li><a href="${pageContext.request.contextPath }/security/user!logout.action"><span class="glyphicon glyphicon-log-out"></span>&nbsp;退&nbsp;出</a></li>
          	</c:if>	
          </ul>
        </li>
        
        <li><a href="${pageContext.request.contextPath}/process/myTask!findPage.action"><i class="icon-bullhorn"></i>我的待办任务</a></li>
      </ul>
    </div><!-- /.navbar-collapse -->
</nav>
</body>
</html>
