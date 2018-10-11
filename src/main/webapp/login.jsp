<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="GTMS是一个高效的毕业论文管理系统">
<title>GTMS</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap2.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/font-awesome/css/font-awesome.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme.css">
<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap2.min.js"></script>
<script src="${pageContext.request.contextPath}/js/common.js"></script>
<script type="text/javascript">
$(function(){
	$("#verify").click(function(){
		$(this).attr('src',"${pageContext.request.contextPath}/security/securityCodeImage.action?timestamp="+(new Date()).getTime());
	});
});
</script>
</head>
<body>
    <div class="navbar">
      <div class="navbar-inner">
        <ul class="nav pull-right">
        </ul>
        <a class="brand" href="">
          <span class="first">GTMS</span>
          <span class="second">本科毕业生论文管理系统</span>
        </a>
      </div>
    </div>
    <div class="row-fluid">
      <div class="dialog">
        <div class="block">
            <p class="block-heading"><i class="icon-signin"></i>登&nbsp;&nbsp;&nbsp;&nbsp;录</p>
            <div class="block-body">
            <form action="${pageContext.request.contextPath}/security/user!login.action" method="post">
               <label><strong><i class="icon-user-md"></i>用户名</strong></label>
               <input type="text" class="span12" name="userName" placeholder="学号/教工号">
               
               <label><strong><i class="icon-unlock"></i>密&nbsp;&nbsp;&nbsp;码</strong></label>
               <input type="password" class="span12" name="password">
               
               <label><strong><i class="icon-qrcode"></i>验证码</strong></label>
               <input style="position:relative;width:280px;height:24px;margin:0px 1px 1px 1px;"  type="text" name="securityCode"> 
               <img style="position:relative;width:69px;height:35px;" id="verify" src="${pageContext.request.contextPath}/security/securityCodeImage.action" />
               
               <div class="row" style="position:relative;left:125px;top:10px;bottom:10px">
                 <div class="span3" style="position:relative;top:5px;">
                   <label class="radio"><i class="icon-user"></i>学生
		             <input type="radio" name="userType" id="optionsRadios1" value="1" checked>
                   </label>
                 </div>
                 <div class="span3" style="position:relative;top:5px;">
                   <label class="radio"><i class="icon-user"></i>教工
                   <input type="radio" name="userType" id="optionsRadios2" value="2">  
                   </label>
                 </div>
               </div>
               
               <div class="row" style="position:relative;top:20px;">                
               <input type="submit" class="btn btn-primary pull-right" value="登&nbsp;&nbsp;录"/>
               </div>
               
               <div class="form-group" style="margin:10%;position:relative;top:10px;">
                 <center><strong>&copy; 2014 北京理工大学珠海学院  @Allen</strong></center>
               </div>                    
               <div class="clearfix"></div>
            </form>
            </div>
        </div>
      </div>
    </div>
</body>
</html>


      
      
      
   