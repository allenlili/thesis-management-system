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
        <h3 class="panel-title">
          <span class="glyphicon glyphicon-list-alt"></span><strong>选题管理</strong>
          <span>${error }</span>
        </h3>
      </div>
     
      <!--主体-->      
      <div class="panel-body">
      <p><span class="glyphicon glyphicon-arrow-right"></span><strong>添加选题</strong></p>
      <!--start增加内容 -->
      <form id="topicForm" action="${pageContext.request.contextPath}/main/topic!save.action" method="post">      
	    <div class="row" style="margin:5px;">
	      <div class="col-xs-4">
		    <div class="input-group">
		      <span class="input-group-addon">题目名称</span>
		      <input id="topicName" name="topicName" type="text" class="form-control" placeholder="请填写" >
		    </div>                  
	      </div>
	      <div class="col-xs-4">
		    <div class="input-group">
		      <span class="input-group-addon">题目类型</span>
	          <s:select name="type" list="@com.zhbit.core.utils.EnumStatus.TopicTypeEnum@values()" listKey="value" listValue="value" cssClass="form-control" emptyOption="true"></s:select>	        
		    </div>                  
	      </div>
	      <div class="col-xs-4">
		    <div class="input-group">
		      <span class="input-group-addon">题目来源</span>
	          <s:select name="origin" list="@com.zhbit.core.utils.EnumStatus.TopicOriginEnum@values()" listKey="value" listValue="value" cssClass="form-control" emptyOption="true"></s:select>	        
		    </div>                 
	      </div>	      
	    </div>
	    <div class="row" style="margin:5px;">
	      <div class="col-xs-4">
		    <div class="input-group">
		      <span class="input-group-addon">难易程度</span>
	          <s:select name="level" list="@com.zhbit.core.utils.EnumStatus.TopicLevelEnum@values()" listKey="value" listValue="value" cssClass="form-control" emptyOption="true"></s:select>	        
		    </div>                  
	      </div>	    
	      <div class="col-xs-4">
		    <div class="input-group">
		      <span class="input-group-addon">题目性质</span>
	          <s:select name="quality" list="@com.zhbit.core.utils.EnumStatus.TopicQualityEnum@values()" listKey="value" listValue="value" cssClass="form-control" emptyOption="true"></s:select>	        
		    </div>                  
	      </div>
	      <div class="col-xs-4">
		    <div class="input-group">
		      <span class="input-group-addon">是否新题</span>
	          <s:select name="oldOrNew" list="@com.zhbit.core.utils.EnumStatus.TopicIsUsedEnum@values()" listKey="value" listValue="value" cssClass="form-control" emptyOption="true"></s:select>	        
		    </div>                  
	      </div>
	    </div>
        
        <center>
        <div class="btn-group" id="input">
          <input id="submitTopic" type="button" class="btn btn-default" value="添&nbsp;&nbsp;&nbsp;&nbsp;加"/>
          <input type="button" class="btn btn-default" value="返&nbsp;&nbsp;&nbsp;&nbsp;回" 
          onClick="location.href='${pageContext.request.contextPath}/main/topic!findPage.action?status=<s:property value="@com.zhbit.core.utils.EnumStatus.StatusEnum@unstart.value"/>'"/>
        </div>
        </center>
		<script type="text/javascript">
			$("#submitTopic").click(function(){
				var flag = true;
				if($("#topicName").val()==""){
					flag = false;
					alert("题目信息不完整，不允许提交！");
				}
				$("select").each(function(key,value){
					if(value.value==''){
						flag = false;
						alert("题目信息不完整，不允许提交！");
						return false;
					}
				});
				if(flag){
					$("#topicForm").submit();
				}
			});
			
			$("#topicName").blur(function(){
				var url = '${pageContext.request.contextPath}/main/equal!equal.action';
				var params = {topicName:$("#topicName").val()};
				$.post(
					url,
					params,			
				    function(data,status){
						var member = eval("("+data+")");
						var equal = member.equal;
						if(equal==true){
							$("#topicName").val("");
							alert("题目不允许重复，请重新输入题目！");
						};
				     },
				     'json');					
				return true;
			});

		</script>         
        <!--end  增加内容 -->
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
