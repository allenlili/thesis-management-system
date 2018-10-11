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
        <h3 class="panel-title"><span class="glyphicon glyphicon-list-alt"></span><strong>选题管理</strong></h3>
      </div>
      <!--主体-->      
      <div class="panel-body">
        <p><span class="glyphicon glyphicon-arrow-right"></span><strong>修改选题</strong></p>
        <!--start修改内容 -->
        <form id="topicForm" action="${pageContext.request.contextPath}/main/topic!update.action" method="post">      
	      <s:hidden name="id" id="topicId"></s:hidden>
	      <div class="row" style="margin:5px;">
	        <div class="col-xs-4">
		      <div class="input-group">
		        <span class="input-group-addon">题目名称</span>
		        <input id="topicName" type="text" class="form-control" name="topicName" value="${topicName }">
		      </div>                  
	        </div>
	        <div class="col-xs-4">
		      <div class="input-group">
		        <span class="input-group-addon">类&nbsp;&nbsp;型</span>
	            <s:select id="typeSelect" name="type" list="@com.zhbit.core.utils.EnumStatus.TopicTypeEnum@values()" listKey="value" listValue="value" cssClass="form-control"></s:select>	        
		        <input id="type" type="hidden" class="form-control" value="${type }" readonly="readonly">	
		      </div>                  
	        </div>
			<script type="text/javascript">
			$(document).ready(function(){
				var type = $("#type").val();
				$("#typeSelect option").each(function(key, value){
					if(value.value != type){
						value.attr("selected", false);
					}					
					if(value.value == type){
						value.attr("selected", true);
					}
				});
			});
			</script>	        
	        <div class="col-xs-4">
		      <div class="input-group">
		        <span class="input-group-addon">来&nbsp;&nbsp;源</span>
	            <s:select id="originSelect" name="origin" list="@com.zhbit.core.utils.EnumStatus.TopicOriginEnum@values()" listKey="value" listValue="value" cssClass="form-control"></s:select>	        
		        <input id="origin" type="hidden" class="form-control" value="${origin }" readonly="readonly">
		      </div>                 
	        </div>
			<script type="text/javascript">
			$(document).ready(function(){
				var origin = $("#origin").val();
				$("#originSelect option").each(function(key, value){
					if(value.value != origin){
						value.attr("selected", false);
					}					
					if(value.value == origin){
						value.attr("selected", true);
					}
				});
			});
			</script>	        	      
	      </div>
	      <div class="row" style="margin:5px;">
	        <div class="col-xs-4">
		      <div class="input-group">
		        <span class="input-group-addon">难易程度</span>
	            <s:select id="levelSelect" name="level" list="@com.zhbit.core.utils.EnumStatus.TopicLevelEnum@values()" listKey="value" listValue="value" cssClass="form-control"></s:select>	        
		        <input id="level" type="hidden" class="form-control" value="${level }" readonly="readonly">
		      </div>                  
	        </div>
			<script type="text/javascript">
			$(document).ready(function(){
				var level = $("#level").val();
				$("#levelSelect option").each(function(key, value){
					if(value.value != level){
						value.attr("selected", false);
					}					
					if(value.value == level){
						value.attr("selected", true);
					}
				});
			});
			</script>	        
	        <div class="col-xs-4">
		      <div class="input-group">
		        <span class="input-group-addon">题目性质</span>
	            <s:select id="qualitySelect" name="quality" list="@com.zhbit.core.utils.EnumStatus.TopicQualityEnum@values()" listKey="value" listValue="value" cssClass="form-control"></s:select>	        
		        <input id="quality" type="hidden" class="form-control" value="${quality }" readonly="readonly">
		      </div>                  
	        </div>
			<script type="text/javascript">
			$(document).ready(function(){
				var quality = $("#quality").val();
				$("#qualitySelect option").each(function(key, value){
					if(value.value != quality){
						value.attr("selected", false);
					}					
					if(value.value == quality){
						value.attr("selected", true);
					}
				});
			});
			</script>	        
	        <div class="col-xs-4">
		      <div class="input-group">
		        <span class="input-group-addon">是否曾用题</span>
	            <s:select id="oldOrNewSelect" name="oldOrNew" list="@com.zhbit.core.utils.EnumStatus.TopicIsUsedEnum@values()" listKey="value" listValue="value" cssClass="form-control"></s:select>	        
		        <input id="oldOrNew" type="hidden" class="form-control" value="${oldOrNew }" readonly="readonly">
		      </div>                  
	        </div>
			<script type="text/javascript">
			$(document).ready(function(){
				var oldOrNew = $("#oldOrNew").val();
				$("#oldOrNewSelect option").each(function(key, value){
					if(value.value != oldOrNew){
						value.attr("selected", false);
					}					
					if(value.value == oldOrNew){
						value.attr("selected", true);
					}
				});
			});
			</script>	        
	      </div>
          <center>
          <div class="btn-group" id="input">
            <input id="submitTopic" type="button" class="btn btn-default" value="修&nbsp;&nbsp;&nbsp;&nbsp;改"/>
            <input type="button" class="btn btn-default" value="返&nbsp;&nbsp;&nbsp;&nbsp;回" 
            onClick="location.href='${pageContext.request.contextPath}/main/topic!findPage.action?status=1'"/>
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
        		var params = {
        					   id:$("#topicId").val(),
        				topicName:$("#topicName").val()
        		};
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
          </form>	      	      	      
	   </div>          
        <!--end  修改内容 -->
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
