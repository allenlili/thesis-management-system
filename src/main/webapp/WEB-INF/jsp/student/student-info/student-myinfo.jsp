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
<script src="${pageContext.request.contextPath}/js/student.js"></script>
<script src="${pageContext.request.contextPath}/js/common.js"></script>
</head>
<body>
<jsp:include page="/index/student-index-top.jsp" />
<div id="main-content">
  <div class="container"> 
    <!-- 我的信息-->
    <div class="panel panel-default"> 
      <!--头部-->
      <div class="panel-heading">
        <h3 class="panel-title"><span class="glyphicon glyphicon-list-alt"></span><strong>我的个人信息</strong></h3>
      </div>
      
      <!--主体-->
      <div class="panel-body"> 
        <!--start修改内容 -->
        <form action="${pageContext.request.contextPath}/me/me!saveStuInfo.action" method="post">
          <input name="student.uuid" type="hidden" value="${student.uuid }">
          <div class="row">
            <div class="col-xs-12">
              <div class="input-group" id="input"> <span class="input-group-addon">学&nbsp;&nbsp;&nbsp;号</span>
                <input type="text" class="form-control" readonly="readonly" value="${student.studentId}"/>
              </div>
            </div>
            <div class="col-xs-12">
              <div class="input-group" id="input"> <span class="input-group-addon">学生姓名</span>
                <input type="text" class="form-control" readonly="readonly" value="${student.name}"/>
              </div>
            </div>
          </div>
          
          <div class="row">
            <div class="col-xs-12">
              <div class="input-group" id="input"> <span class="input-group-addon">学院</span>
                <input type="text" class="form-control" readonly="readonly" value="${student.institute.instituteName}"/>
              </div>
            </div>
            <div class="col-xs-12">
              <div class="input-group" id="input"> <span class="input-group-addon">专业</span>
                <input type="text" class="form-control" readonly="readonly" value="${student.major.majorName}"/>
              </div>
            </div>            
          </div> 
                   
          <div class="row">
            <div class="col-xs-12">
              <div class="input-group" id="input"> <span class="input-group-addon">班&nbsp;&nbsp;级</span>
                <input type="text" class="form-control" readonly="readonly" value="${student.whichclass}"/>
              </div>
            </div>
            <div class="col-xs-12">
              <div class="input-group" id="input"> <span class="input-group-addon">绩&nbsp;&nbsp;点</span>
                <input type="text" class="form-control" value="${student.gpa}" readonly="readonly"/>
              </div>
            </div>
            <div class="col-xs-12">
              <div class="input-group" id="input"> <span class="input-group-addon">性&nbsp;&nbsp;别</span>
                <c:if test="${student.sex == 1 }">
                  <input type="text" class="form-control" value="男" readonly="readonly"/>
                </c:if>
                <c:if test="${student.sex == 2 }">
                  <input type="text" class="form-control" value="女" readonly="readonly"/>
                </c:if>
                <c:if test="${student.sex == null }">
                  <input type="text" class="form-control" value="" readonly="readonly"/>
                </c:if>
              </div>
            </div>
          </div>
          
          <div class="row">
            <div class="col-xs-12">
              <div class="input-group" id="input"> <span class="input-group-addon">qq</span>
                <input name="student.qq" type="text" class="form-control" value="${student.qq}"/>
              </div>
            </div>
            <div class="col-xs-12">
              <div class="input-group" id="input"> <span class="input-group-addon">电话号码</span>
                <input name="student.telephone" type="text" class="form-control" value="${student.telephone}"/>
              </div>
            </div>          
          </div>
          <div class="row">
            <div class="col-xs-12">
              <div class="input-group" id="input"> <span class="input-group-addon">研究方向</span>
                <textarea name="student.studentNote" class="form-control" style="resize:none;" cols="30" rows="5">${student.studentNote}</textarea>
              </div>
            </div>
          </div>
          <center>
            <div class="btn-group" id="input">
              <input type="submit" class="btn btn-default" value="确&nbsp;&nbsp;定"/>
              <input type="button" class="btn btn-default" value="返&nbsp;&nbsp;回" onclick="location.href='${pageContext.request.contextPath}/student-index.jsp'"/>
            </div>
          </center>
        </form>
        <!--end 修改内容   --> 
        
      </div>
      
      <!--底部-->
      <div class="panel-footer"> </div>
    </div>
    <!-- end 学生管理--> 
  </div>
</div>
<!-- end #main-content -->

<jsp:include page="/index/student-index-footer.jsp" />
</body>
</html>
