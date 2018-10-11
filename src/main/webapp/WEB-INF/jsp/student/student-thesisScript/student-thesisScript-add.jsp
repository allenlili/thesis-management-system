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
<jsp:include page="/index/student-index-top.jsp" />
<div id="main-content">
  <div class="container">
  
    <div class="panel panel-primary">
    
      <!--头部-->
      <div class="panel-heading">
        <h3 class="panel-title"><span class="glyphicon glyphicon-list-alt"></span><strong>我的稿件管理</strong></h3>
      </div>
      
      <!--主体-->      
      <div class="panel-body">
      <!--start增加内容 -->
      <form  action="${pageContext.request.contextPath}/main/thesisScript!save.action" method="post" enctype="multipart/form-data">      
        <div class="form-group">
          <p><span class="glyphicon glyphicon-arrow-right"></span><strong>上传稿件</strong></p>
        
          <div class="input-group" id="input">
            <span class="input-group-addon">稿&nbsp;&nbsp;件</span>
            <input name="script" type="file" class="form-control">
          </div>

          <div class="input-group" id="input">
            <label class="">终&nbsp;&nbsp;稿
            <input name="lastScript" type="checkbox" value="1">
            </label>
          </div>          

		  <div class="row" style="margin:5px;">
		    <label class=""></label>
		    <div class="col-xs-12">
		      <div class="input-group">
		        <s:textarea name="question" cssClass="form-control" rows="5" cols="200" placeholder='请提出问题，若无，请填写"无"' style="resize:none;"></s:textarea>
		      </div>                  
		    </div>
		  </div> 
                                 
          <center>
          <div class="btn-group" id="input">
            <input type="submit" class="btn btn-default" value="上传稿件"/>
            <input type="button" class="btn btn-default" value="返&nbsp;&nbsp;&nbsp;&nbsp;回" 
            onClick="location.href='${pageContext.request.contextPath}/main/thesisScript!findPage.action'"/>
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
<jsp:include page="/index/student-index-footer.jsp" />
</body>
</html>
