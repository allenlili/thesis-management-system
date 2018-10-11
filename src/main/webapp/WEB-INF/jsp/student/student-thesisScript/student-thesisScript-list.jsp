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
	$('#performForm').attr('action', '${pageContext.request.contextPath }/main/thesisScript!start.action');
	$('#performForm').submit();
}
</script>
</head>
<body>
<jsp:include page="/index/student-index-top.jsp" />
<div id="main-content">
  <div class="container">
  <c:if test="${student.thesisProposal == null }">
    <center>
    <caption class="caption alert-danger text-muted"><span class="icon-hand-right"></span>Tips:您的开题报告还没有下达，不能提交任何稿件！</caption>
    </center>  	
  </c:if>
  <c:if test="${student.thesisProposal != null }">   
  <!-- 我的稿件管理-->    
  <div class="panel panel-primary">
  	<!--头部-->
    <div class="panel-heading">
	  <h3 class="panel-title"><span class="glyphicon glyphicon-list-alt"></span><strong>我的稿件管理</strong></h3>		
	</div>
	
	<!--主体--> 
    <div class="panel-body">
      <!-- start查询内容-->
      <p><span class="glyphicon glyphicon-arrow-right"></span><strong>我的稿件查询</strong></p>
      <form id="queryForm" action="${pageContext.request.contextPath}/main/thesisScript!findPage.action" method="post">
      <s:hidden name="status" ></s:hidden>
      <div class="row">
        <div class="col-xs-4">
	      <div class="input-group">
	        <input type="text" class="form-control" placeholder="我的稿件名称" name="fileName">
	        <span class="input-group-btn">
	          <button class="btn btn-default" type="button" id="queryButton">Go!</button>
	        </span>          
	      </div>                  
        </div>
      </div>               
      </form> 
      <!-- end查询内容-->

      <!-- start删除内容-->
      <form id="performForm" action="${pageContext.request.contextPath }/main/thesisScript!deleteMyScript.action">   	   
      <s:hidden name="definitionKey" value="%{@com.zhbit.core.utils.EnumStatus.ProcessEnum@thesisScript}"></s:hidden>
      <div id="execute">
        <input type="button" class="btn btn-default" onclick="location.href='${pageContext.request.contextPath }/main/thesisScript!toAdd.action'" value="添加我的稿件">
        <input type="submit" class="btn btn-default" value="删除我的稿件">
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
	        <th class="text-center">文件名</th>
	        <th class="text-center">题&nbsp;&nbsp;目</th>
	        <th class="text-center">学&nbsp;&nbsp;生</th>
	        <th class="text-center">指导老师</th>
	        <th class="text-center">创建时间</th>
	        <th class="text-center">是否终稿</th>
	        <th class="text-center">状&nbsp;&nbsp;态</th>
	        <th class="text-center">操&nbsp;&nbsp;作</th>
	      </tr>
	    </thead>
	
	    <tbody>
	      <c:forEach items="${page.result}" var="o">
	        <tr class="tr">
	          <c:if test="${o.status == 1}">
	          <td class="text-center"><input type="checkbox" name="ids" class="singleCheckbox" value="${o.id }"></td>
	          </c:if>
	          <c:if test="${o.status != 1}">
	          <td class="text-center"><input type="checkbox" class="singleCheckbox" value="${o.id }" disabled></td>
	          </c:if>
	          <td class="text-center"><a href="${pageContext.request.contextPath}/main/download.action?fileUuid=${o.uuid}">${o.fileName }</a></td>
	          <td class="text-center">${o.topic.topicName }</td>
	          <td class="text-center">${o.student.name }</td>
	          <td class="text-center">${o.teacher.name }</td>
	          <td class="text-center">${o.startDate }</td>
	          <c:if test="${o.lastScript == null}">
	            <td class="text-center">否</td>
	          </c:if>
	          <c:if test="${o.lastScript == 1}">
	          	<td class="text-center">是</td>
	          </c:if>
	          <c:if test="${o.lastScript == 0}">
	            <td class="text-center">否</td>
	          </c:if>
	          <c:if test="${o.status == 1}">
	          <td id="status" class="text-center">未审批</td>
	          </c:if>
	          <c:if test="${o.status == 2}">
	          <td id="status" class="text-center">审批中</td>
	          </c:if>
	          <c:if test="${o.status == 3}">
	          <td id="status" class="text-center">审批成功</td>
	          </c:if>	          	          
	          <c:if test="${o.status == 1}">
	          <td class="text-center">
	            <a href="${pageContext.request.contextPath}/main/thesisScript!toUpdate.action?id=${o.id}">修改</a>
	          </td>
	          </c:if>
	          <c:if test="${o.status == 2}">	          
	          <td class="text-center">                        
	            <a href="${pageContext.request.contextPath }/process/myInstanceForThesisScript!watch.action?id=${o.id}&definitionKey=<s:property value="@com.zhbit.core.utils.EnumStatus.ProcessEnum@thesisScript"/>">流程监控</a>
	            &nbsp;&nbsp;
	            <a href="${pageContext.request.contextPath }/main/thesisScript!watch.action?id=${o.id}&definitionKey=<s:property value='@com.zhbit.core.utils.EnumStatus.ProcessEnum@thesisScript'/>">查看</a>
	          </td>
	          </c:if>
	          <c:if test="${o.status == 3 || o.status == 4}">	          
	          <td class="text-center">                        
	            <a href="${pageContext.request.contextPath }/main/thesisScript!watch.action?id=${o.id}&definitionKey=<s:property value='@com.zhbit.core.utils.EnumStatus.ProcessEnum@thesisScript'/>">查看</a>
	          </td>
	          </c:if>	
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
  <!-- end 我的稿件管理--> 
  </c:if>
   
  </div>
</div>
<!-- end #main-content -->
<!-- 操控日期 -->
<script src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script src="${pageContext.request.contextPath}/js/control-time.js" charset="UTF-8"></script>


<jsp:include page="/index/student-index-footer.jsp" />
</body>

</html>
