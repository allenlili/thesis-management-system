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
  	<!-- 学生管理-->
    <div class="panel panel-default">
      <!--头部-->
      <div class="panel-heading">
        <h3 class="panel-title"><span class="glyphicon glyphicon-list-alt"></span><strong>学生管理</strong></h3>
      </div>
      
      <!--主体-->    
      <div class="panel-body">
      	<!--start修改内容 -->
      	<form action="${pageContext.request.contextPath}/security/student!update.action" method="post">
		<s:hidden name="id"></s:hidden>
        <div class="input-group" id="input">
          <span class="input-group-addon">学&nbsp;&nbsp;&nbsp;号</span>
          <input name="studentId" type="text" class="form-control" readonly="readonly" value="${studentId}"/>
        </div>
      
        <div class="input-group" id="input">
          <span class="input-group-addon">学生姓名</span>
          <input name="name" type="text" class="form-control" value="${name}"/>
        </div>
                             
        <div class="input-group" id="input">
          <span class="input-group-addon">班&nbsp;&nbsp;级</span>
          <input name="whichclass" type="text" class="form-control" value="${whichclass}"/>
        </div>
     
        <div class="input-group" id="input">
          <span class="input-group-addon">绩&nbsp;&nbsp;点</span>
          <input name="grade" type="text" class="form-control" value="${gpa}"/>
        </div>  
             
        <div class="input-group" id="input">
          <span class="input-group-addon">性&nbsp;&nbsp;别</span>
<%--               <s:select name="sex" list="#{1:'男', 2:'女'}" cssClass="form-control"></s:select> --%>
          <c:if test="${sex == 1}">
          	<input name="sex" type="text" class="form-control" value="男" readonly="readonly"/>
          </c:if>
          <c:if test="${sex == 2}">
            <input name="sex" type="text" class="form-control" value="女" readonly="readonly"/>
          </c:if>
        </div>
        
        <div class="input-group" id="input">
          <span class="input-group-addon">qq</span>
          <input name="qq" type="text" class="form-control" value="${qq}"/>
        </div>
     
        <div class="input-group" id="input">
          <span class="input-group-addon">电话号码</span>
          <input name="telephone" type="text" class="form-control" value="${telephone}"/>
        </div>
     
        <div class="input-group" id="input">
          <span class="input-group-addon">研究方向</span>
     	  <textarea name="studentNote" class="form-control" style="resize:none;" cols="30" rows="5">${studentNote}</textarea>
        </div>
            
        <center>
        <div class="btn-group" id="input">
          <input type="submit" class="btn btn-default" value="修&nbsp;&nbsp;&nbsp;&nbsp;改"/>
          <input type="button" class="btn btn-default" value="返&nbsp;&nbsp;&nbsp;&nbsp;回" 
          onClick="location.href='${pageContext.request.contextPath}/security/student!findPage.action'"/>
        </div>
        </center>
        </form>      
       <!--end 修改内容   -->
  		
		
        <!--start修改学院和专业 -->
       <div class="form-group">
       
          <!-- 关联学院 start -->        
          <div class="col-xs-4 col-md-4">
            <div class="panel panel-default">
              <!-- Default panel contents -->
              <div class="panel-heading">学&nbsp;&nbsp;&nbsp;院</div>
              <!-- Table -->
              <div class="table-responsive">	
              <table class="table">
			    <thead>
			      <tr>			
			        <th class="text-center">学院名称</th>			      
			        <th class="text-center">操&nbsp;&nbsp;作</th>
			      </tr>
			    </thead>    
			    <tbody>
			      <!-- 数据和删除操作行 -->
<%-- 				  <c:forEach items="${institute}" var="o"> --%>
				    <tr>
			          <td class="text-center">${institute.instituteName }</td>
			          <td class="text-center">
			            <input type="button" class="btn" onclick="location.href='${pageContext.request.contextPath }/security/student!deleteInstitute.action?id=${id }&instituteId=${institute.id }'" value="删除">
			          </td>
				    </tr>
<%-- 				  </c:forEach> --%>
				  <!-- 增加行 -->
				  <form action="${pageContext.request.contextPath }/security/student!addInstitute.action" method="post">
				    <s:hidden name="id"></s:hidden>
					<tr>
			          <td class="text-center">
			          	<s:select name="instituteId" list="#instituteList" listKey="id" listValue="instituteName" cssClass="input"></s:select>
			          </td>
			          <td class="text-center">
			          <input type="submit" class="btn" value="保存">
			          </td>
					</tr>
				  </form>
			    </tbody>
              </table>
              </div>
              <!-- 关联学院end -->
            </div>
          </div>
    
    
          <!-- 关联专业 start -->        
          <div class="col-xs-4 col-md-4">
            <div class="panel panel-default">
              <!-- Default panel contents -->
              <div class="panel-heading">专&nbsp;&nbsp;&nbsp;业</div>
            
              <!-- Table -->
              <div class="table-responsive">	
              <table class="table">
			    <thead>
			      <tr>			
			        <th class="text-center">专业名称</th>			      
			        <th class="text-center">操&nbsp;&nbsp;作</th>
			      </tr>
			    </thead>    
			    <tbody>
			      <!-- 数据和删除操作行 -->
<%-- 				  <c:forEach items="${institute}" var="o"> --%>
				    <tr>
			          <td class="text-center">${major.majorName }</td>
			          <td class="text-center">
			            <input type="button" class="btn" onclick="location.href='${pageContext.request.contextPath }/security/student!deleteMajor.action?id=${id }&majorId=${major.id }'" value="删除">
			          </td>
				    </tr>
<%-- 				  </c:forEach> --%>
				  <!-- 增加行 -->
				  <form action="${pageContext.request.contextPath }/security/student!addMajor.action" method="post">
				    <s:hidden name="id"></s:hidden>
					<tr>
			          <td class="text-center">
			          	<s:select name="majorId" list="#majorList" listKey="id" listValue="majorName" cssClass="input"></s:select>
			          </td>
			          <td class="text-center">
			          <input type="submit" class="btn" value="保存">
			          </td>
					</tr>
				  </form>
			    </tbody>
              </table>
              </div>
              <!-- 关联专业end -->
            </div>
          </div>
          
          <div class="col-xs-4 col-md-4">
            <div class="panel panel-default">
              <!-- Default panel contents -->
              <div class="panel-heading">评阅老师</div>
            
              <!-- Table -->
              <div class="table-responsive">	
              <table class="table">
			    <thead>
			      <tr>			
			      	<th class="text-center">工&nbsp;&nbsp;号</th>	
			        <th class="text-center">姓&nbsp;&nbsp;名</th>			      
			        <th class="text-center">操&nbsp;&nbsp;作</th>
			      </tr>
			    </thead>    
			    <tbody>
			      <!-- 数据和删除操作行 -->
<%-- 				  <c:forEach items="${institute}" var="o"> --%>
				    <tr>
			          <td class="text-center">${teacher.teacherId }</td>
			          <td class="text-center" colspan="2">${teacher.name }</td>
<!-- 			          <td class="text-center"> -->
<%-- 			            <input type="button" class="btn" onclick="location.href='${pageContext.request.contextPath }/security/student!deleteTeacher.action?id=${id }&teacherId=${major.id }'" value="删除"> --%>
<!-- 			          </td> -->
				    </tr>
<%-- 				  </c:forEach> --%>
				  <!-- 增加行 -->
				  <form action="${pageContext.request.contextPath }/security/student!addTeacher.action" method="post">
				    <s:hidden name="id"></s:hidden>
					<tr>
			          <td class="text-center" colspan="2">
			          	<s:select name="teacherId" list="#teacherList" listKey="id" listValue="name" cssClass="input"></s:select>
			          </td>
			          <td class="text-center" colspan="2">
			            <input type="submit" class="btn" value="替换">
			          </td>
					</tr>
				  </form>
			    </tbody>
              </table>
              </div>
              <!-- 关联指导老师end -->
            </div>
          </div>           
                      
        </div>  
        </div>  
        <!--end修改学院和专业、指导老师 -->
  		
        <div class="panel panel-default" style="margin:0px 30px 10px 30px;">  		
	      <!--头部-->
	      <div class="panel-heading">
	        <h3 class="panel-title">
	          <span class="glyphicon glyphicon-list-alt"></span><strong>更换题目</strong>
	        </h3>
	      </div>
	      <!--主体-->      
	      <div class="panel-body">
	      <p><span class="glyphicon glyphicon-arrow-right"></span><strong>新题目</strong></p>
	      <!--start增加内容 -->
	      <form id="topicForm" action="${pageContext.request.contextPath}/security/student!addTopic.action?id=${id}" method="post">      
		    <div class="row" style="margin:5px;">
		      <div class="col-xs-4">
			    <div class="input-group">
			      <span class="input-group-addon">题目名称</span>
			      <input id="topicName" name="topic.topicName" type="text" class="form-control" placeholder="题目名称" >
			    </div>                  
		      </div>
		      <div class="col-xs-4">
			    <div class="input-group">
			      <span class="input-group-addon">题目类型</span>
		          <s:select name="topic.type" list="@com.zhbit.core.utils.EnumStatus.TopicTypeEnum@values()" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="form-control"></s:select>	        
			    </div>                  
		      </div>
		      <div class="col-xs-4">
			    <div class="input-group">
			      <span class="input-group-addon">题目来源</span>
		          <s:select name="topic.origin" list="@com.zhbit.core.utils.EnumStatus.TopicOriginEnum@values()" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="form-control"></s:select>	        
			    </div>                 
		      </div>	      
		    </div>
		    <div class="row" style="margin:5px;">
		      <div class="col-xs-4">
			    <div class="input-group">
			      <span class="input-group-addon">难易程度</span>
		          <s:select name="topic.level" list="@com.zhbit.core.utils.EnumStatus.TopicLevelEnum@values()" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="form-control"></s:select>	        
			    </div>                  
		      </div>	    
		      <div class="col-xs-4">
			    <div class="input-group">
			      <span class="input-group-addon">题目性质</span>
		          <s:select name="topic.quality" list="@com.zhbit.core.utils.EnumStatus.TopicQualityEnum@values()" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="form-control"></s:select>	        
			    </div>                  
		      </div>
		      <div class="col-xs-4">
			    <div class="input-group">
			      <span class="input-group-addon">是否新题</span>
		          <s:select name="topic.oldOrNew" list="@com.zhbit.core.utils.EnumStatus.TopicIsUsedEnum@values()" listKey="value" listValue="value" headerKey="" headerValue="" cssClass="form-control"></s:select>	        
			    </div>                  
		      </div>
		    </div>
	        <center>
	        <div class="btn-group" id="input">
	          <input id="submitTopic" type="button" class="btn btn-default" value="更&nbsp;&nbsp;&nbsp;&nbsp;改"/>
	        </div>
	        </center>
          <script type="text/javascript">
          $("#submitTopic").click(function(){
        		var flag = true;
        		if($("#topicName").val()==""){
        			flag = false;
        			alert("题目信息不完整，不允许提交！");
        			return false;
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
		 <!-- start 数据内容-->
		 <div class="table-responsive">
			<table class="table table-striped table-hover">
			  <thead>
			    <tr>
			      <th class="text-center">原题目名称</th>
			      <th class="text-center">类&nbsp;&nbsp;型</th>
			      <th class="text-center">来&nbsp;&nbsp;源</th>
			      <th class="text-center">难易程度</th>
			      <th class="text-center">题目性质</th>
			      <th class="text-center">是否新题</th>
			    </tr>
			  </thead>    
			  <tbody>
			      <tr>
			        <td class="text-center">${topic.topicName }</td>
			        <td class="text-center">${topic.type }</td>
			        <td class="text-center">${topic.origin }</td>
			        <td class="text-center">${topic.level }</td>
			        <td class="text-center">${topic.quality }</td>
			        <td class="text-center">${topic.oldOrNew }</td>
			      </tr>
			  </tbody>
			</table>
		  </div>	      
	    </div>
	    <!-- 替换选题 --> 		
  		
  		<!--底部-->
        <div class="panel-footer">

        </div>
  		
      </div>
	  
	  <!-- end 学生管理-->
  </div>
</div>
<!-- end #main-content -->

<jsp:include page="/index/admin-index-footer.jsp" />
</body>

</html>
