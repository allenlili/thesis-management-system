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
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-datetimepicker.min.css">
<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/admin.js" charset="UTF-8"></script>
<script src="${pageContext.request.contextPath}/js/common.js" charset="UTF-8"></script>
</head>
<body>
<jsp:include page="/index/admin-index-top.jsp" />
<div id="main-content">
  <div class="container">
   
  <!-- 填成绩-->    
  <div class="panel panel-default">
  	<!--头部-->
    <div class="panel-heading">
	  <h3 class="panel-title"><span class="glyphicon glyphicon-list-alt"></span><strong>学生成绩汇总</strong></h3>		
	</div>
	
    <!-- start 数据内容-->
    <form id="forward" action="${pageContext.request.contextPath}/main/mark!forwardGrade.action" method="post">
    <div class="table-responsive">
	  <table class="table table-striped table-hover table-bordered">
	    <thead>
	      <tr>
	        <input type="hidden" >
	        <th class="text-center">学&nbsp;&nbsp;号</th>
	        <th class="text-center">学&nbsp;&nbsp;生</th>
	        <th class="text-center">题&nbsp;&nbsp;目</th>
	        <th class="text-center">指导成绩</th>
	        <th class="text-center">评阅成绩</th>
	        <th class="text-center">答辩成绩</th>
	        <th class="text-center">总成绩</th>
	        <th class="text-center">确认时间</th>
	      </tr>
	    </thead>    
	    <tbody>
	      <c:forEach items="${students}" var="o">
	        <tr>
	          <input type="hidden" name="uuids" class="studentIdlists" value="${o.uuid }">
	          <td class="text-center">${o.studentId }</td>
	          <td class="text-center">${o.name }</td>
	          <td class="text-center">${o.topic.topicName }</td>
	          <td class="text-center">${o.mark.tutorGrade }</td>
	          <td class="text-center">${o.mark.viewerGrade }</td>
	          <c:if test="${o.mark.status == 3 }">
	          <td class="text-center">${o.mark.lectureGrade}</td>
	          </c:if>
	          <c:if test="${o.mark.status == 1 }">
	          <td class="text-center"><input type="text" name="lectureGrades" class="input-sm gradelists text-center"></td>
	          </c:if>
	          <c:if test="${o.mark == null }">
	          <td class="text-center">${o.mark.lectureGrade}</td>
	          </c:if>	          	          
			  <td class="text-center">${o.mark.totalGrade }</td>	          
	          <td class="text-center">${o.mark.startDate }</td>
	        </tr>
	      </c:forEach>    
	    </tbody>
	  </table>
	  <script type="text/javascript">
		  $(".gradelists").blur(function(){
			  	$(".gradelists").each(function(){
			  		if(parseInt($(this).val())>100 || parseInt($(this).val())<0){
			  			alert("百分制！谢谢！");
			  			return false;
			  		}
			  	});			  
		  });
	  </script>
    </div>
    </form>
    <!-- end数据内容-->
        
    <div class="panel-footer">
    <center>
    <div class="btn-group" id="input">
      <c:if test="${teacher.forwardLectureGradeStatus == 1}">
      <input type="button" id="forwardGrade" class="btn btn-default" value="提&nbsp;&nbsp;&nbsp;&nbsp;交"/>
      </c:if>
      <input type="button" class="btn btn-default" value="返&nbsp;&nbsp;&nbsp;&nbsp;回" 
      onClick="location.href='${pageContext.request.contextPath}/admin-index.jsp'"/>
    </div>
    </center>    
    </div>
      </form><!-- end 删除内容-->             
  </div>
  <!-- end 填成绩--> 

   
  </div>
</div>
<!-- end #main-content -->
<!-- 操控日期 -->
<script src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script src="${pageContext.request.contextPath}/js/control-time.js" charset="UTF-8"></script>


<jsp:include page="/index/admin-index-footer.jsp" />
</body>

</html>
