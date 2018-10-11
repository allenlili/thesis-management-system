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
</head>
<body>
<jsp:include page="/index/admin-index-top.jsp" />
<div id="main-content">
  <div class="container">

  <!-- 已选学生-->    
  <div class="panel panel-default">
  	<!--头部-->
    <div class="panel-heading">
	  <h3 class="panel-title">
	    <span class="glyphicon glyphicon-list-alt"></span><strong>第一轮已选学生</strong>
	    <span>&nbsp;&nbsp;已选择人数：${realHaveSelectedNum }&nbsp;&nbsp;</span>	  
		<span><span class="icon-warning-sign"></span> 不能超过${myselfTeacher.teachNum }人&nbsp;&nbsp;</span>	    
	    <span>${errorString }&nbsp;&nbsp;</span>
	  </h3>		
	</div>
    <input type="hidden" id="realHaveSelectedNum" value="${realHaveSelectedNum }">
    <input type="hidden" id="teachNum" value="${myselfTeacher.teachNum }">
    <!-- start 数据内容-->
    <form action="${pageContext.request.contextPath }/chooseTutor/teacher!unMatchStudent.action"> 
    <div class="table-responsive">
	  <table class="table table-striped table-hover" id="deleteTable">
	   <c:if test="${realHaveSelectedNum == 0 }">
	   <caption class="caption alert-danger text-muted"><span class="icon-hand-right"></span>Tips:您未在第一轮选择学生。</caption>
	   </c:if>		  
	    <thead>
	      <tr>
	        <c:if test="${myselfTeacher.chooseStudentRunNum == '0' }">
	        <th class="text-center"><input type="checkbox" id="checkboxes" value="checkbox0"></th>
	        </c:if>
	        <th class="text-center">学&nbsp;&nbsp;号</th>
	        <th class="text-center">学生姓名</th>
	        <th class="text-center">学&nbsp;&nbsp;院</th>
	        <th class="text-center">专&nbsp;&nbsp;业</th>
	        <th class="text-center">班&nbsp;&nbsp;级</th>
	        <th class="text-center">绩&nbsp;&nbsp;点</th>
	        <th class="text-center">性&nbsp;&nbsp;别</th>
	        <th class="text-center">qq</th>
	        <th class="text-center">电话号码</th>
	        <th class="text-center">研究方向</th>
	      </tr>
	    </thead>    
	    <tbody>	    
	      <c:forEach items="${studentSelectedByMe}" var="o">
	        <tr>
	          <c:if test="${myselfTeacher.chooseStudentRunNum == '0' }">
	          <td class="text-center"><input type="checkbox" name="uuids" class="singleCheckbox" value="${o.uuid }"></td>
	          </c:if>
	          <td class="text-center">${o.studentId }</td>
			  <td class="text-center">${o.name }</td>
			  <td class="text-center">${o.institute.instituteName }</td>
			  <td class="text-center">${o.major.majorName }</td>
			  <td class="text-center">${o.whichclass }</td>
			  <td class="text-center">${o.gpa }</td>
			  <c:if test="${o.sex == 1 }">
			  	<td class="text-center">男</td>
			  </c:if>
			  <c:if test="${o.sex == 2 }">
			  	<td class="text-center">女</td>
			  </c:if>			  
			  <td class="text-center">${o.qq }</td>
			  <td class="text-center">${o.telephone }</td>
	          <td class="text-center">
	            <a href="#" class="btn btn-mini" rel="popover" data-original-title="研究方向" data-content="${o.studentNote }" data-placement="top" data-trigger="hover"><span class="glyphicon glyphicon-info-sign"></span></a>
	          </td>
	        </tr>
	      </c:forEach>    
	    </tbody>
	  </table>
	  <c:if test="${myselfTeacher.chooseStudentRunNum == '0' }">
      <center>
       <div class="btn-group" id="input">
         <input type="submit" id="getUnSelectedStudents" class="btn btn-default" value="剔除选择">
         <input type="button" class="btn btn-default" value="提交结果" 
         onClick="location.href='${pageContext.request.contextPath}/chooseTutor/teacher!forwardInverseMatch.action'"/>
       </div>
      </center>
      </c:if>	  
    </div>
    <!-- end数据内容-->    
    </form>
    
    <div class="panel-footer">
    </div>                   
  </div>
  <!-- end 已选管理-->
  
  <c:if test="${myselfTeacher.chooseStudentRunNum == '1' }">
   <center>
    <div class="btn-group" id="input">
      <input type="button" class="btn btn-default btn-lg" value="点击进入下一轮" 
      onClick="location.href='${pageContext.request.contextPath}/chooseTutor/teacher!findUnselectedStudents.action'"/>
    </div>
    <caption class="caption alert-danger text-muted"><span class="icon-hand-right"></span>Tips:若您点击后未能进入下一轮，请耐心等候其他老师选择完毕！</caption>
   </center>
  </c:if>   
  
  <c:if test="${myselfTeacher.chooseStudentRunNum == '0' }">      
  <!-- 反选学生-->    
  <div class="panel panel-default">
  	<!--头部-->
    <div class="panel-heading">
	  <h3 class="panel-title"><span class="glyphicon glyphicon-list-alt"></span><strong>第一轮可选学生</strong></h3>		
	</div>
    
    <!-- start 数据内容-->
    <form id="addStudents" action="${pageContext.request.contextPath }/chooseTutor/teacher!matchStudent.action"> 
    <div class="table-responsive">
	  <table class="table table-striped table-hover" id="addTable">
	    <thead>
	      <tr>
	        <th class="text-center"><input type="checkbox" id="checkboxes2" value="checkbox0"></th>
	        <th class="text-center">学&nbsp;&nbsp;号</th>
	        <th class="text-center">学生姓名</th>
	        <th class="text-center">学&nbsp;&nbsp;院</th>
	        <th class="text-center">专&nbsp;&nbsp;业</th>
	        <th class="text-center">班&nbsp;&nbsp;级</th>
	        <th class="text-center">绩&nbsp;&nbsp;点</th>
	        <th class="text-center">性&nbsp;&nbsp;别</th>
	        <th class="text-center">qq</th>
	        <th class="text-center">电话号码</th>
	        <th class="text-center">研究方向</th>
	      </tr>
	    </thead>    
	    <tbody>
	      <c:forEach items="${unSelectedStudents}" var="o">
	        <tr>
	          <td class="text-center"><input type="checkbox" name="uuids" class="singleCheckbox2" value="${o.uuid }"></td>
	          <td class="text-center">${o.studentId }</td>
			  <td class="text-center">${o.name }</td>
			  <td class="text-center">${o.institute.instituteName }</td>
			  <td class="text-center">${o.major.majorName }</td>
			  <td class="text-center">${o.whichclass }</td>
			  <td class="text-center">${o.gpa }</td>
			  <c:if test="${o.sex == 1 }">
			  	<td class="text-center">男</td>
			  </c:if>
			  <c:if test="${o.sex == 2 }">
			  	<td class="text-center">女</td>
			  </c:if>			  
			  <td class="text-center">${o.qq }</td>
			  <td class="text-center">${o.telephone }</td>
	          <td class="text-center">
	            <a href="#" class="btn btn-mini" rel="popover" data-original-title="研究方向" data-content="${o.studentNote }" data-placement="top" data-trigger="hover"><span class="glyphicon glyphicon-info-sign"></span></a>
	          </td>
	        </tr>
	      </c:forEach>    
	    </tbody>
	  </table>
      <center>
       <div class="btn-group">
         <input id="getSelectedStudents" type="button" class="btn btn-default" value="确定选择">
         <input type="button" class="btn btn-default" value="返回主页" 
         onclick="location.href='${pageContext.request.contextPath }/admin-index.jsp'">
       </div>
      </center>	  
    </div>
    <!-- end数据内容-->    
    </form>
    
    <div class="panel-footer">
    </div>                   
  </div>
  <!-- end 反选管理-->  
  </c:if>
  
  </div>
</div>
<!-- end #main-content -->


</body>
<jsp:include page="/index/admin-index-footer.jsp" />
</html>
