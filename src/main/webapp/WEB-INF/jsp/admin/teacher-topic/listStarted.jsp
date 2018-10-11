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
   
  <!-- 题目管理-->    
  <div class="panel panel-default">
  	<!--头部-->
    <div class="panel-heading">
	  <h3 class="panel-title"><span class="glyphicon glyphicon-list-alt"></span><strong>选题管理</strong>-审批中</h3>		
	</div>
	
	<!--主体--> 
    <div class="panel-body">
      <!-- start查询内容-->
      <p><span class="glyphicon glyphicon-arrow-right"></span><strong>论文题目查询</strong></p>
      <form id="queryForm" action="${pageContext.request.contextPath}/main/topicStarted!findPage.action" method="post">
  	  <s:hidden name="queryAllUser" ></s:hidden>
  	  <s:hidden name="status" ></s:hidden>      
      <div class="row">
        <div class="col-xs-4">
	      <div class="input-group">
	        <input type="text" class="form-control" placeholder="题目名称" name="topicName">
	        <span class="input-group-btn">
	          <button class="btn btn-default" type="button" id="queryButton">Go!</button>
	        </span>          
	      </div>                  
        </div>
<!--         <div class="col-xs-4"> -->
<!--           <div class="form-group"> -->
<!-- 	        <div class="input-group date form_date" data-date="" data-date-format="yyyy年mm月dd日"> -->
<!-- 	          <input type="text" class="form-control" placeholder="开始日期" name="startDate"> -->
<!-- 			  <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span> -->
<!-- 			  <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>           -->
<!-- 	        </div> -->
<!-- 	      </div>                   -->
<!--         </div> -->
<!--         <div class="col-xs-4"> -->
<!-- 	      <div class="form-group"> -->
<!-- 		    <div class="input-group date form_date" data-date="" data-date-format="yyyy年mm月dd日"> -->
<!-- 		      <input type="text" class="form-control" placeholder="结束日期" name="endDate"> -->
<!-- 		      <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span> -->
<!-- 			  <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>           -->
<!-- 		    </div>                   -->
<!-- 	      </div> -->
<!--         </div>                 -->
      </div>               
      </form> 
      <!-- end查询内容-->

      <!-- start删除内容-->
      <form id="performForm" action="${pageContext.request.contextPath }/main/topicStarted!delete.action">   	   
      <s:hidden name="definitionKey" value="%{@com.zhbit.core.utils.EnumStatus.ProcessEnum@topic}"></s:hidden>
      <div id="execute">
        <input type="submit" class="btn btn-default" value="删除题目">
        <button type="button" class="btn btn-default" id="queryButton">查询题目</button>
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
	        <th class="text-center">题目名称</th>
	        <th class="text-center">类&nbsp;&nbsp;型</th>
	        <th class="text-center">来&nbsp;&nbsp;源</th>
	        <th class="text-center">难易程度</th>
	        <th class="text-center">题目性质</th>
	        <th class="text-center">是否新题</th>
	        <th class="text-center">对应学生</th>
	        <th class="text-center">创建日期</th>	        
	        <th class="text-center">状&nbsp;&nbsp;态</th>
	        <th class="text-center">操&nbsp;&nbsp;作</th>
	      </tr>
	    </thead>    
	    <tbody>
	      <c:forEach items="${page.result}" var="o">
	        <tr>
	          <td class="text-center"><input type="checkbox" name="ids" class="singleCheckbox" value="${o.id }"></td>
	          <td class="text-center">${o.topicName }</td>
	          <td class="text-center">${o.type }</td>
	          <td class="text-center">${o.origin }</td>
	          <td class="text-center">${o.level }</td>
	          <td class="text-center">${o.quality }</td>
	          <td class="text-center">${o.oldOrNew }</td>
	          <c:if test="${o.student == null }">
	          <td class="text-center">学生未确认</td>
	          </c:if>
	          <c:if test="${o.student != null }">
	          <td class="text-center">${o.student.name }</td>	
	          </c:if>
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
	          <td class="text-center">
	            <a href="${pageContext.request.contextPath }/process/instance!watch.action?id=${o.id}&definitionKey=<s:property value="@com.zhbit.core.utils.EnumStatus.ProcessEnum@topic"/>">流程监控</a>
	          </td>	          
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
  <!-- end 选题管理--> 

   
  </div>
</div>
<!-- end #main-content -->
<script src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script src="${pageContext.request.contextPath}/js/control-time.js" charset="UTF-8"></script>
<jsp:include page="/index/admin-index-footer.jsp" />
</body>

</html>
