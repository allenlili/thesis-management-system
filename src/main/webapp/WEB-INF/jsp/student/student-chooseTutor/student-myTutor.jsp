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
<script src="${pageContext.request.contextPath}/js/student.js"></script>
<script src="${pageContext.request.contextPath}/js/common.js"></script>
</head>
<body>
<jsp:include page="/index/student-index-top.jsp" />

<div id="main-content">
  <div class="container">
    <div class="panel panel-primary">
	  <!--头部-->
	   <div class="panel-heading">
		 <h3 class="panel-title"><span class="glyphicon glyphicon-list-alt"></span><strong>我的指导老师</strong></h3>		
	  </div> 
	  
	  <!--主体-->
      <div class="panel-body">
       <!-- 内容-->
         <div class="row">
            <div class="col-xs-4">          
              <label class="input-sm"><span class="glyphicon glyphicon-play"></span>第一志愿</label>
            </div>
            <div class="col-xs-4">          
              <label class="input-sm"><span class="glyphicon glyphicon-play"></span>第二志愿</label>
            </div>
            <div class="col-xs-4">          
              <label class="input-sm"><span class="glyphicon glyphicon-play"></span>第三志愿</label>
            </div>
          </div>       
          <div class="row">
            <div class="col-xs-4">          
              <input type="text" class="form-control" readonly="readonly" value="${teachers.firstTeacher.name }"/>
            </div>
            <div class="col-xs-4">          
              <input type="text" class="form-control" readonly="readonly" value="${teachers.secondTeacher.name }"/>
            </div>
            <div class="col-xs-4">          
              <input type="text" class="form-control" readonly="readonly" value="${teachers.thirdTeacher.name }"/>
            </div>
          </div>&nbsp;	      	
	  </div>
	  	       	   
      <!-- start 数据内容-->
      <div class="table-responsive">
	   <table class="table table-striped table-hover">
	   <c:if test="${mytutorTeacher != null }">
	   <caption class="caption alert-danger text-muted"><span class="icon-hand-right"></span>以下是您的指导老师！</caption>
	   </c:if>
	   <c:if test="${mytutorTeacher == null }">
	   <caption class="caption alert-danger text-muted"><span class="icon-hand-right"></span>请耐心等待反选结果！</caption>
	   </c:if>	    
	     <thead>
	       <tr>
	         <th class="text-center">教工号</th>
	         <th class="text-center">教工姓名</th>
	         <th class="text-center">学&nbsp;&nbsp;院</th>
	         <th class="text-center">专&nbsp;&nbsp;业</th>
	         <th class="text-center">邮&nbsp;&nbsp;箱</th>
	         <th class="text-center">电话号码</th>
	         <th class="text-center">研究方向</th>
	       </tr>
	     </thead>	     
	     <tbody>
	       <c:if test="${mytutorTeacher != null }">
	       <tr>
	         <td class="text-center">${mytutorTeacher.teacherId }</td>
			 <td class="text-center">${mytutorTeacher.name }</td>
			 <td class="text-center">${mytutorTeacher.institute.instituteName }</td>
			 <td class="text-center">
			 <c:forEach items="${mytutorTeacher.majors}" var="m">
			   	${m.majorName }&nbsp;
			 </c:forEach>
			 </td>
			 <td class="text-center">${mytutorTeacher.teacherEmail }</td>
			 <td class="text-center">${mytutorTeacher.teacherTel }</td>
             <td class="text-center">
                <a href="#" class="btn btn-mini" rel="popover" data-original-title="研究方向" data-content="${mytutorTeacher.teacherNote }" data-placement="top" data-trigger="hover"><span class="glyphicon glyphicon-info-sign"></span></a>        
             </td>				  
	       </tr>
	       </c:if>
	     </tbody> 
	   </table>
	   <div class="panel-footer">
	   </div>
     </div>
     <!-- end数据内容-->       
    </div>             
  </div>
</div>

<!-- end #main-content -->
<jsp:include page="/index/student-index-footer.jsp" />
</body>
</html>
