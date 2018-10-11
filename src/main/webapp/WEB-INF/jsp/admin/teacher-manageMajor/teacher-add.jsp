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
  
    <div class="panel panel-default">
    
      <!--头部-->
      <div class="panel-heading">
        <h3 class="panel-title"><span class="glyphicon glyphicon-list-alt"></span><strong>学院专业教工管理</strong></h3>
      </div>
      
      <!--主体-->      
      <div class="panel-body">
      <!--start增加内容 -->
      <form action="${pageContext.request.contextPath}/manageMajor/teacher!save.action" method="post">      
        <div class="form-group">
          <p><span class="glyphicon glyphicon-arrow-right"></span><strong>增加老师</strong></p>
        
          <div class="input-group" id="input">
            <span class="input-group-addon">教工号</span>
            <input name="teacherId" type="text" class="form-control" placeholder="">
          </div>
        
          <div class="input-group" id="input">
            <span class="input-group-addon">教工姓名</span>
            <input name="name" type="text" class="form-control" placeholder="" >
          </div>
          
          <div class="input-group" id="input">
            <span class="input-group-addon">学&nbsp;&nbsp;院</span>
            <s:select name="instituteId" list="#instituteList" listKey="id" listValue="instituteName" cssClass="form-control"></s:select>
          </div>
          
          <div class="input-group" id="input">
            <span class="input-group-addon">专&nbsp;&nbsp;业</span>
            <s:select name="majorId" list="#majorList" listKey="id" listValue="majorName" cssClass="form-control"></s:select>
          </div> 
                             
          <div class="input-group" id="input">
            <span class="input-group-addon">职&nbsp;&nbsp;称</span>
            <input name="level" type="text" class="form-control" placeholder="" >
          </div>
          
          <div class="input-group" id="input">
            <span class="input-group-addon">指导数量</span>
            <input name="teachNum" type="text" class="form-control" placeholder="" >
          </div>
          
          <div class="input-group" id="input">
            <span class="input-group-addon">实际指导数量</span>
            <input name="realTeachNum" type="text" class="form-control" placeholder="" >
          </div>             
                  
          <div class="input-group" id="input">
            <span class="input-group-addon">性&nbsp;&nbsp;别</span>
            <s:select name="sex" list="#{1:'男', 2:'女'}" cssClass="form-control"></s:select>
          </div>
          
          <div class="input-group" id="input">
            <span class="input-group-addon">邮&nbsp;&nbsp;箱</span>
            <input name="teacherEmail" type="text" class="form-control" placeholder="" >
          </div>
          
          <div class="input-group" id="input">
            <span class="input-group-addon">电话号码</span>
            <input name="teacherTel" type="text" class="form-control" placeholder="">
          </div>
          
          <div class="input-group" id="input">
            <span class="input-group-addon">研究方向</span>
          	<textarea name="teacherNote" class="form-control" placeholder="" style="resize:none;" cols="30" rows="5"></textarea>
          </div>                              
                            
          <center>
          <div class="btn-group" id="input">
            <input type="submit" class="btn btn-default" value="添&nbsp;&nbsp;&nbsp;&nbsp;加"/>
            <input type="button" class="btn btn-default" value="返&nbsp;&nbsp;&nbsp;&nbsp;回" 
            onClick="location.href='${pageContext.request.contextPath}/manageMajor/teacher!findPage.action'"/>
          </div>
          </center>   
        </div><!--end  增加内容 -->
      </form>
      </div>
      
      <!--底部-->
      <div class="panel-footer">
      </div>
      
    </div>  
    	       
  </div>
</div>
<!-- end #main-content -->
<jsp:include page="/index/admin-index-footer.jsp" />
</body>
</html>
