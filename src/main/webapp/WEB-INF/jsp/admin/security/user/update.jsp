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
<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/admin.js"></script>
<script src="${pageContext.request.contextPath}/js/common.js"></script>
</head>
<body>
<jsp:include page="/index/admin-index-top.jsp" />
<div id="main-content">
  <div class="container">
  	<!-- 用户管理-->
    <div class="panel panel-default">
      <!--头部-->
      <div class="panel-heading">
        <h3 class="panel-title"><span class="glyphicon glyphicon-list-alt"></span><strong>用户管理</strong></h3>
      </div>
      
      <!--主体-->    
      <div class="panel-body">
      	<!--start修改内容 -->
      	<form action="${pageContext.request.contextPath}/security/user!save.action" method="post">
		<s:hidden name="id"></s:hidden>
		<div class="form-group">        
            <p><span class="glyphicon glyphicon-arrow-right"></span><strong>修改用户</strong></p>
            <div class="input-group" id="input">
              <span class="input-group-addon">用户名称</span>
              <input name="userName" type="text" class="form-control" placeholder="学号或者工号" value="${userName }">
            </div>
            
            <div class="input-group" id="input">
              <span class="input-group-addon">密&nbsp;&nbsp;&nbsp;码</span>
              <input name="password" type="password" class="form-control" placeholder="新密码"/>
            </div>
	        <center>
	        <div class="btn-group" id="input">
	          <input type="submit" class="btn btn-default" value="修&nbsp;&nbsp;&nbsp;&nbsp;改"/>
	          <input type="button" class="btn btn-default" value="返&nbsp;&nbsp;&nbsp;&nbsp;回" 
	          onClick="location.href='${pageContext.request.contextPath}/security/user!findPage.action'"/>
	        </div>
	        </center>
            </form>
        </div>      
        <!--end 修改内容   -->
        
        <!--start添加角色等 -->
        <div class="form-group">
        
          <!-- 关联角色 start -->        
          <div class="col-xs-6 col-md-4">
            <div class="panel panel-default">
              <!-- Default panel contents -->
              <div class="panel-heading">角&nbsp;&nbsp;&nbsp;色</div>
            
              <!-- Table -->
              <div class="table-responsive">	
              <table class="table">
			    <thead>
			      <tr>			
			        <th class="text-center">角色名称</th>			      
			        <th class="text-center">操&nbsp;&nbsp;作</th>
			      </tr>
			    </thead>    
			    <tbody>
			      <!-- 数据和删除操作行 -->
				  <c:forEach items="${roles}" var="o">
				    <tr>
			          <td class="text-center">${o.roleName }</td>
			          <td class="text-center">
			            <input type="button" class="btn" onclick="location.href='${pageContext.request.contextPath }/security/user!deleteRole.action?id=${id }&roleId=${o.id }'" value="删除">
			          </td>
				    </tr>
				  </c:forEach>
				  <!-- 增加行 -->
				  <form action="${pageContext.request.contextPath }/security/user!addRole.action" method="post">
				    <s:hidden name="id"></s:hidden>
					<tr>
			          <td class="text-center">
			          	<s:select name="roleId" list="#roleList" listKey="id" listValue="roleName" cssClass="input"></s:select>
			          </td>
			          <td class="text-center">
			          <input type="submit" class="btn" value="保存">
			          </td>
					</tr>
				  </form>
			    </tbody>
              </table>
              </div>
              
            </div>
          </div>
          <!-- 关联角色 end --> 
  
  		</div>
      </div>
      
      <!--底部-->
      <div class="panel-footer">
		
      </div>
      
    </div>
	<!-- end 用户管理-->
  </div>
</div>
<!-- end #main-content -->

<jsp:include page="/index/admin-index-footer.jsp" />
</body>

</html>
