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
        <h3 class="panel-title"><span class="glyphicon glyphicon-list-alt"></span><strong>评阅意见表</strong></h3>
      </div>
      
      <!--主体-->      
      <div class="panel-body">
      <!--start增加内容 -->
      <form  action="${pageContext.request.contextPath}/main/viewerAdvice!update.action" method="post" enctype="multipart/form-data">      
        <s:hidden name="id"></s:hidden>
        <div class="form-group">
          <p><span class="glyphicon glyphicon-arrow-right"></span><strong>修改评阅意见表</strong></p>
        
          <div class="input-group" id="input">
            <span class="input-group-addon">评阅分数</span>
            <input id="viewerGrade" name="viewerGrade" type="text" class="form-control" value="${viewerGrade }">
          </div>
          <script type="text/javascript">
            $("#viewerGrade").blur(function(){
          	  var value = parseInt($("#viewerGrade").val());
        	  if(value > 100 || value < 0){
        		  alert("百分制！谢谢！");
        		  $("#viewerGrade").val("");
        	  }
            });
          </script>          

          <div class="input-group" id="input">
            <label class="">是否同意答辩？
            <input id="yes" name="agreeOrNot" type="radio" value="1">
            </label>同意
            <label class="">
            <input id="no" name="agreeOrNot" type="radio" value="0">
            </label>不同意            
          </div>
          <input id="agreeOrNot" type="hidden" value="${agreeOrNot }">
          <script type="text/javascript">
          	$(document).ready(function(){
          		var value = $("#agreeOrNot").val();
          		if(value == 1){
          			$("#yes").attr('checked','checked');
          		}else{
          			$("#no").attr('checked','checked');
          		}
          	});
          </script>          

		  <div class="row" style="margin:5px;">
		    <label class="">评阅意见：</label>
		    <div class="col-xs-12">
		      <div class="input-group">
		        <s:textarea name="opinion" cssClass="form-control" rows="5" cols="200" placeholder='请给出评阅意见！' style="resize:none;"></s:textarea>
		      </div>                  
		    </div>
		  </div> 
                                 
          <center>
          <div class="btn-group" id="input">
            <input type="submit" class="btn btn-default" value="更&nbsp;&nbsp;&nbsp;&nbsp;新"/>
            <input type="button" class="btn btn-default" value="返&nbsp;&nbsp;&nbsp;&nbsp;回" 
            onClick="location.href='${pageContext.request.contextPath}/main/viewerAdvice!findMyStudents.action'"/>
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
