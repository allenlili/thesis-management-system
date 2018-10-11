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
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-style.css">
<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/admin.js"></script>
<script src="${pageContext.request.contextPath}/js/common.js"></script>
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
<nav id="nav" class="navbar navbar-default navbar-inverse" role="navigation">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="${pageContext.request.contextPath }/admin-index.jsp"><i class="icon-home"></i>GTMS</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <v:auth path="/thesis/">
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="icon-list-ul"></i>指导关系管理<b class="caret"></b></a>
          <ul class="dropdown-menu">
            <li><a href="${pageContext.request.contextPath}/chooseTutor/teacher!findUnselectedStudents.action"><i class="icon-circle-arrow-right"></i>反选学生</a></li>
          </ul>
        </li>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="icon-list-ul"></i>论文选题管理<b class="caret"></b></a>
          <ul class="dropdown-menu">
            <li><a href="${pageContext.request.contextPath}/main/topic!findPage.action?status=<s:property value="@com.zhbit.core.utils.EnumStatus.StatusEnum@unstart.value"/>"><i class="icon-circle-arrow-right"></i>未审批</a></li>
            <li class="divider"></li>
            <li><a href="${pageContext.request.contextPath}/main/topicStarted!findPage.action?status=<s:property value="@com.zhbit.core.utils.EnumStatus.StatusEnum@start.value"/>"><i class="icon-circle-arrow-right"></i>审批中</a></li>
            <li class="divider"></li>
            <li><a href="${pageContext.request.contextPath}/main/topicFinished!findPage.action?status=<s:property value="@com.zhbit.core.utils.EnumStatus.StatusEnum@finished.value"/>"><i class="icon-circle-arrow-right"></i>审批结束</a></li>
<!--             <li class="divider"></li> -->
<%--             <li><a href="${pageContext.request.contextPath}/main/topicFinished!findPage.action?queryByAllUser=true&status=<s:property value="@com.zhbit.core.utils.EnumStatus.StatusEnum@finished.value"/>"><i class="icon-circle-arrow-right"></i>历史记录</a></li> --%>
<!--             <li class="divider"></li> -->
<!--             <li><a href="#"><i class="icon-circle-arrow-right"></i>查看学生题目</a></li> -->
          </ul>
        </li>
        
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="icon-list-ul"></i>任务书管理<b class="caret"></b></a>
          <ul class="dropdown-menu">
            <li><a href="${pageContext.request.contextPath}/main/taskBook!findPage.action?status=<s:property value="@com.zhbit.core.utils.EnumStatus.StatusEnum@unstart.value"/>"><i class="icon-circle-arrow-right"></i>未审批</a></li>
            <li class="divider"></li>
            <li><a href="${pageContext.request.contextPath}/main/taskBookStarted!findPage.action?status=<s:property value="@com.zhbit.core.utils.EnumStatus.StatusEnum@start.value"/>"><i class="icon-circle-arrow-right"></i>审批中</a></li>
            <li class="divider"></li>
            <li><a href="${pageContext.request.contextPath}/main/taskBookFinished!findPage.action?status=<s:property value="@com.zhbit.core.utils.EnumStatus.StatusEnum@finished.value"/>"><i class="icon-circle-arrow-right"></i>审批结束</a></li>
<!--             <li class="divider"></li> -->
<%--             <li><a href="${pageContext.request.contextPath}/main/taskBookFinished!findPage.action?queryByAllUser=true&status=<s:property value="@com.zhbit.core.utils.EnumStatus.StatusEnum@finished.value"/>"><i class="icon-circle-arrow-right"></i>历史记录</a></li> --%>
          </ul>          
        </li>
        
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="icon-list-ul"></i>开题报告管理<b class="caret"></b></a>
          <ul class="dropdown-menu">
          	<li><a href="${pageContext.request.contextPath}/main/thesisProposal!selectMyStudentProposal.action"><i class="icon-circle-arrow-right"></i>查看开题报告</a></li>
          </ul>
        </li>
        
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="icon-list-ul"></i>进度报告管理<b class="caret"></b></a>
          <ul class="dropdown-menu">
            <li><a href="${pageContext.request.contextPath}/main/midCheck!selectMyMidCheck.action"><i class="icon-circle-arrow-right"></i>中期检查</a></li>
            <li class="divider"></li>
            <li><a href="${pageContext.request.contextPath}/main/tutorRecorder!findPage.action"><i class="icon-circle-arrow-right"></i>指导记录</a></li>
          </ul>
        </li>
        
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="icon-list-ul"></i>毕业论文管理<b class="caret"></b></a>
          <ul class="dropdown-menu">
            <li><a href="${pageContext.request.contextPath}/main/myStudentScript!findMyStudents.action"><i class="icon-circle-arrow-right"></i>论文提交情况</a></li>
            <li class="divider"></li>
            <v:auth path="/manageMajor/teacher!findPage.action">
            <li><a href="${pageContext.request.contextPath}/manageMajor/teacher!findPage.action"><i class="icon-circle-arrow-right"></i>确定评阅关系</a></li>
            <li class="divider"></li>
            </v:auth>
            <li><a href="${pageContext.request.contextPath}/main/tutorAdvice!findMyStudents.action"><i class="icon-circle-arrow-right"></i>填写指导意见</a></li>
            <li class="divider"></li>
            <li><a href="${pageContext.request.contextPath}/main/viewerAdvice!findMyStudents.action"><i class="icon-circle-arrow-right"></i>填写评阅意见</a></li>
            <li class="divider"></li>
          	<li><a href="${pageContext.request.contextPath}/main/mark!findMyStudents.action"><i class="icon-circle-arrow-right"></i>录入答辩成绩</a></li>
          </ul>
        </li>
		</v:auth>        
<!--         <li class="dropdown"> -->
<!--           <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="icon-list-ul"></i>学院/专业管理<b class="caret"></b></a> -->
<!--           <ul class="dropdown-menu"> -->
<%--             <li><a href="${pageContext.request.contextPath}/manageMajor/teacher!findPage.action"><i class="icon-circle-arrow-right"></i>确定指导关系</a></li> --%>
<!--             <li class="divider"></li> -->
<%--             <li><a href="${pageContext.request.contextPath}/manageMajor/student!findPage.action"><i class="icon-circle-arrow-right"></i>学生管理</a></li> --%>
<!--             <li class="divider"></li> -->
<!--             <li><a href="#"><i class="icon-circle-arrow-right"></i>管理指导关系</a></li>             -->
<!--             <li class="divider"></li> -->
<!--             <li><a href="#"><i class="icon-circle-arrow-right"></i>管理论文题目</a></li> -->
<!--             <li class="divider"></li> -->
<!--             <li><a href="#"><i class="icon-circle-arrow-right"></i>管理开题报告</a></li> -->
<!--             <li class="divider"></li>                         -->
<!--             <li><a href="#"><i class="icon-circle-arrow-right"></i>管理中期检查表</a></li> -->
<!--             <li class="divider"></li> -->
<!--             <li><a href="#"><i class="icon-circle-arrow-right"></i>管理指导记录表</a></li> -->
<!--             <li class="divider"></li> -->
<!--             <li><a href="#"><i class="icon-circle-arrow-right"></i>管理指导评阅意见表</a></li>                                       -->
<!--             <li class="divider"></li> -->
<!--             <li><a href="#"><i class="icon-circle-arrow-right"></i>管理毕业论文</a></li> -->
<!--             <li class="divider"></li> -->
<!--             <li><a href="#"><i class="icon-circle-arrow-right"></i>管理论文成绩</a></li>                        -->
<!--           </ul> -->
<!--         </li> -->

        <v:auth path="/process/">
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="icon-list-ul"></i>工作流管理<b class="caret"></b></a>
          <ul class="dropdown-menu">
<%--             <li><a href="${pageContext.request.contextPath}/process/task!findPage.action"><i class="icon-circle-arrow-right"></i>待办任务</a></li> --%>
<!--             <li class="divider"></li> -->
            <li><a href="${pageContext.request.contextPath}/process/definition!findPage.action"><i class="icon-circle-arrow-right"></i>流程定义</a></li>
            <li class="divider"></li>
            <li><a href="${pageContext.request.contextPath}/process/instance!findPage.action"><i class="icon-circle-arrow-right"></i>流程实例</a></li>
            <li class="divider"></li>
            <li><a href="${pageContext.request.contextPath}/process/history!findPage.action"><i class="icon-circle-arrow-right"></i>历史流程</a></li>
          </ul>
        </li>
        </v:auth>

        <v:auth path="/security/">
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="icon-list-ul"></i>权限管理<b class="caret"></b></a>
          <ul class="dropdown-menu">
            <li><a href="${pageContext.request.contextPath}/security/resource!findPage.action"><i class="icon-circle-arrow-right"></i>资源管理</a></li>
            <li class="divider"></li>
            <li><a href="${pageContext.request.contextPath}/security/role!findPage.action"><i class="icon-circle-arrow-right"></i>角色管理</a></li>
            <li class="divider"></li>
            <li><a href="${pageContext.request.contextPath}/security/user!findPage.action"><i class="icon-circle-arrow-right"></i>用户管理</a></li>         
          </ul>
        </li>
        </v:auth>
        
        <v:auth path="/security/">
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="icon-list-ul"></i>系统管理<b class="caret"></b></a>
          <ul class="dropdown-menu">
<%--             <li><a href="${pageContext.request.contextPath}/security/resource!findPage.action"><i class="icon-circle-arrow-right"></i>资源管理</a></li> --%>
<!--             <li class="divider"></li> -->
<%--             <li><a href="${pageContext.request.contextPath}/security/role!findPage.action"><i class="icon-circle-arrow-right"></i>角色管理</a></li> --%>
<!--             <li class="divider"></li> -->
<%--             <li><a href="${pageContext.request.contextPath}/security/user!findPage.action"><i class="icon-circle-arrow-right"></i>用户管理</a></li> --%>
<!--             <li class="divider"></li> -->
            <li><a href="${pageContext.request.contextPath}/security/institute!findPage.action"><i class="icon-circle-arrow-right"></i>学院管理</a></li>
            <li class="divider"></li>
            <li><a href="${pageContext.request.contextPath}/security/major!findPage.action"><i class="icon-circle-arrow-right"></i>专业管理</a></li>
    		<li class="divider"></li>
            <li><a href="${pageContext.request.contextPath}/security/teacher!findPage.action"><i class="icon-circle-arrow-right"></i>教工管理</a></li>     		
            <li class="divider"></li>
            <li><a href="${pageContext.request.contextPath}/security/student!findPage.action"><i class="icon-circle-arrow-right"></i>学生管理</a></li>            
          </ul>
        </li>
        </v:auth>
        
        <v:auth path="/druid/index.html">
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="icon-list-ul"></i>后台监控<b class="caret"></b></a>
          <ul class="dropdown-menu">
            <li><a href="${pageContext.request.contextPath }/druid/index.html" target="blank"><i class="icon-circle-arrow-right"></i>数据源监控</a></li>
          </ul>        
        </li>
        </v:auth> 
         
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
       
</body>
</html>
