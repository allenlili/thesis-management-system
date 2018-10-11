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
<script type="text/javascript">
function startProcess() {
	$('#performForm').attr('action', '${pageContext.request.contextPath }/main/taskBook!start.action');
	$('#performForm').submit();
}
</script>
</head>
<body>
<jsp:include page="/index/admin-index-top.jsp" />
<div id="main-content">
  <div class="container">
   
  <!-- 任务书管理-->    
  <div class="panel panel-default">
  	<!--头部-->
    <div class="panel-heading">
	  <h3 class="panel-title"><span class="glyphicon glyphicon-list-alt"></span><strong>任务书管理</strong>-未审批</h3>		
	</div>
	
	<!--主体--> 
    <div class="panel-body">
      <!-- start查询内容-->
      <p><span class="glyphicon glyphicon-arrow-right"></span><strong>任务书查询</strong></p>
      <form id="queryForm" action="${pageContext.request.contextPath}/main/taskBook!findPage.action" method="post">
      <s:hidden name="status" ></s:hidden>
      <div class="row">
        <div class="col-xs-4">
	      <div class="input-group">
	        <input type="text" class="form-control" placeholder="题目名称" name="topicNameFind">
	        <span class="input-group-btn">
	          <button class="btn btn-default" type="button" id="queryButton">Go!</button>
	        </span>          
	      </div>                  
        </div>
      </div>               
      </form> 
      <!-- end查询内容-->

      <!-- start删除内容-->
      <form id="performForm" action="${pageContext.request.contextPath }/main/taskBook!delete.action">   	   
      <s:hidden name="definitionKey" value="%{@com.zhbit.core.utils.EnumStatus.ProcessEnum@taskBook}"></s:hidden>
      <div id="execute">
<%--         <input type="button" class="btn btn-default" onclick="location.href='${pageContext.request.contextPath }/main/taskBook!toAdd.action'" value="添加任务书"> --%>
<!--         <input type="submit" class="btn btn-default" value="删除任务书"> -->
        <button type="button" class="btn btn-default" id="queryButton">查询任务书</button>
        <button type="button" class="btn btn-default" onclick="startProcess();">启动流程</button>
      </div>
        			                               
      <!-- start分页内容-->
      <div id="page">	            
        <%@include file="/page.jsp"%> 		
	  </div>
      <!-- end 分页内容-->          
    </div>
           
    <!-- start 数据内容-->
    <div class="table-responsive">
	  <table class="table table-striped table-hover">
	    <thead>
	      <tr>
	        <th class="text-center"><input type="checkbox" id="checkboxes" value="checkbox0"></th>
	        <th class="text-center">题&nbsp;&nbsp;目</th>
	        <th class="text-center">学&nbsp;&nbsp;生</th>
	        <th class="text-center">指导老师</th>
	        <th class="text-center">创建时间</th>
	        <th class="text-center">状&nbsp;&nbsp;态</th>
	        <th class="text-center">操&nbsp;&nbsp;作</th>
	      </tr>
	    </thead>    
	    <tbody>
	      <c:forEach items="${page.result}" var="o">
	        <tr>
	          <td class="text-center"><input type="checkbox" name="ids" class="singleCheckbox" value="${o.id }"></td>
	          <td class="text-center">${o.topic.topicName }</td>
	          <td class="text-center">${o.student.name }</td>
	          <td class="text-center">${o.teacher.name }</td>
	          <td class="text-center">${o.startDate }</td>
	          <c:if test="${o.status == 1 }">
	          <td class="text-center">已生成</td>
	          </c:if>
	          <c:if test="${o.status == 2 }">
	          <td class="text-center">审批中</td>
	          </c:if>
	          <c:if test="${o.status == 3 }">
	          <td class="text-center">审批成功</td>
	          </c:if>
	          <c:if test="${o.status == 4 }">
	          <td class="text-center">审批失败</td>
	          </c:if>
	          <c:if test="${o.status == 3 || o.status == 4}">
	          <td class="text-center">结束审批</td>
	          </c:if>
	          <td class="text-center"><a href="${pageContext.request.contextPath}/main/taskBook!toUpdate.action?id=${o.id}">填写/修改</a></td>	          
	        </tr>
	      </c:forEach>    
	    </tbody>
	  </table>
    </div>
    <!-- end数据内容-->    
    
    <div class="panel-footer">
    </div>
      </form><!-- end 删除内容-->             
  </div>
  <!-- end 任务书管理--> 

   
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
