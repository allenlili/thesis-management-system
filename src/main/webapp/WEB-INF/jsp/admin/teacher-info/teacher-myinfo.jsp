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
  	<!-- 我的信息-->
    <div class="panel panel-default">
      <!--头部-->
      <div class="panel-heading">
        <h3 class="panel-title"><span class="glyphicon glyphicon-list-alt"></span><strong>个人信息</strong></h3>
      </div>
      
      <!--主体-->    
      <div class="panel-body">
      	<!--start修改内容 -->
      	<form action="${pageContext.request.contextPath}/me/me!saveTeaInfo.action" method="post">
        <input type="hidden" name="teacher.uuid" value="${teacher.uuid }">
        <div class="input-group" id="input">
          <span class="input-group-addon">教工号</span>
          <input type="text" class="form-control" readonly="readonly" value="${teacher.teacherId}" readonly="readonly"/>
        </div>
      
        <div class="input-group" id="input">
          <span class="input-group-addon">教工姓名</span>
          <input type="text" class="form-control" value="${teacher.name}" readonly="readonly"/>
        </div>
          
        <div class="input-group" id="input">
          <span class="input-group-addon">职&nbsp;&nbsp;称</span>
          <input type="text" class="form-control" value="${teacher.institute.instituteName}" readonly="readonly"/>
        </div>
        
        <div class="input-group" id="input">
          <span class="input-group-addon">专&nbsp;&nbsp;业</span>
          <textarea class="form-control" style="resize:none;" cols="50" rows="1" readonly="readonly"><c:forEach items="${teacher.majors}" var="m">${m.majorName }&nbsp;</c:forEach></textarea>
        </div>                  
                             
        <div class="input-group" id="input">
          <span class="input-group-addon">职&nbsp;&nbsp;称</span>
          <input type="text" class="form-control" value="${teacher.level}" readonly="readonly"/>
        </div>
     
        <div class="input-group" id="input">
          <span class="input-group-addon">最大指导数量</span>
          <input type="text" class="form-control" readonly="readonly" value="${teacher.teachNum}"/>
        </div>  
            
        <div class="input-group" id="input">
          <span class="input-group-addon">实际指导数量</span>
          <input type="text" class="form-control" value="${teacher.realTeachNum}" readonly="readonly"/>
        </div>            
             
        <div class="input-group" id="input">
          <span class="input-group-addon">性&nbsp;&nbsp;别</span>
<%--               <s:select name="sex" list="#{1:'男', 2:'女'}" cssClass="form-control"></s:select> --%>
          <c:if test="${teacher.sex == 1 }">
          	<input type="text" class="form-control" value="男" readonly="readonly"/>
          </c:if>
          <c:if test="${teacher.sex == 2 }">
          	<input type="text" class="form-control" value="女" readonly="readonly"/>
          </c:if>
          <c:if test="${teacher.sex == null }">
          	<input type="text" class="form-control" value="" readonly="readonly"/>
          </c:if>          
        </div>
        
        <div class="input-group" id="input">
          <span class="input-group-addon">邮&nbsp;&nbsp;箱</span>
          <input name="teacher.teacherEmail" type="text" class="form-control" value="${teacher.teacherEmail}"/>
        </div>
     
        <div class="input-group" id="input">
          <span class="input-group-addon">电话号码</span>
          <input name="teacher.teacherTel" type="text" class="form-control" value="${teacher.teacherTel}"/>
        </div>
     
        <div class="input-group" id="input">
          <span class="input-group-addon">研究方向</span>
     	  <textarea name="teacher.teacherNote" class="form-control" style="resize:none;" cols="30" rows="5">${teacher.teacherNote}</textarea>
        </div>
            
        <center>
        <div class="input-group" id="input">
          <input type="submit" class="form-control btn btn-default" value="确定修改信息"/>          
        </div>
        </center>
        </form>      
       <!--end 修改内容   -->	
  	</div>
  		
	<!--底部-->
    <div class="panel-footer">

    </div>
  		
   </div>
	  <!-- end 学生管理-->
  </div>
</div>
<!-- end #main-content -->

<jsp:include page="/index/admin-index-footer.jsp" />
</body>

</html>
