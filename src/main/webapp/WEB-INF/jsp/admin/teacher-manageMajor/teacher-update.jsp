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
        <h3 class="panel-title"><span class="glyphicon glyphicon-list-alt"></span><strong>学院专业教工管理</strong></h3>
      </div>
      
      <!--主体-->    
      <div class="panel-body">
      	<!--start修改内容 -->
      	<form action="${pageContext.request.contextPath}/manageMajor/teacher!update.action" method="post">
		<s:hidden name="id"></s:hidden>
        <div class="input-group" id="input">
          <span class="input-group-addon">教工号</span>
          <input name="teacherId" type="text" class="form-control" readonly="readonly" value="${teacherId}" readonly="readonly"/>
        </div>
      
        <div class="input-group" id="input">
          <span class="input-group-addon">教工姓名</span>
          <input name="name" type="text" class="form-control" value="${name}" readonly="readonly"/>
        </div>
                             
        <div class="input-group" id="input">
          <span class="input-group-addon">职&nbsp;&nbsp;称</span>
          <input name="level" type="text" class="form-control" value="${level}" readonly="readonly"/>
        </div>
     
        <div class="input-group" id="input">
          <span class="input-group-addon">最大指导数量</span>
          <input name="teachNum" type="text" class="form-control" value="${teachNum}"/>
        </div>  
            
        <div class="input-group" id="input">
          <span class="input-group-addon">实际指导数量</span>
          <input name="realTeachNum" type="text" class="form-control" value="${realTeachNum}" readonly="readonly"/>
        </div>            
             
        <div class="input-group" id="input">
          <span class="input-group-addon">性&nbsp;&nbsp;别</span>
          <input name="sex" type="hidden" class="form-control" value="${sex}" readonly="readonly"/>
          <c:if test="${sex == 1 }">
          	<input type="text" class="form-control" value="男" readonly="readonly"/>
          </c:if>
          <c:if test="${sex == 2 }">
          	<input type="text" class="form-control" value="女" readonly="readonly"/>
          </c:if>
          <c:if test="${sex == null }">
          	<input type="text" class="form-control" value="女" readonly="readonly"/>
          </c:if>          
        </div>
        
        <div class="input-group" id="input">
          <span class="input-group-addon">邮&nbsp;&nbsp;箱</span>
          <input name="teacherEmail" type="text" class="form-control" value="${teacherEmail}"/>
        </div>
     
        <div class="input-group" id="input">
          <span class="input-group-addon">电话号码</span>
          <input name="teacherTel" type="text" class="form-control" value="${teacherTel}"/>
        </div>
     
        <div class="input-group" id="input">
          <span class="input-group-addon">研究方向</span>
     	  <textarea name="teacherNote" class="form-control" style="resize:none;" cols="30" rows="5">${teacherNote}</textarea>
        </div>
            
        <center>
        <div class="btn-group" id="input">
          <input type="submit" class="btn btn-default" value="修&nbsp;&nbsp;&nbsp;&nbsp;改"/>
          <input type="button" class="btn btn-default" value="返&nbsp;&nbsp;&nbsp;&nbsp;回" 
          onClick="location.href='${pageContext.request.contextPath}/manageMajor/teacher!findPage.action'"/>
        </div>
        </center>
        </form>      
       <!--end 修改内容   -->
  		
		
        <!--start修改学院和专业 -->
       <div class="form-group">
       
          <!-- 关联学院 start -->        
          <div class="col-xs-6 col-md-4">
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
			            <input type="button" class="btn" onclick="location.href='${pageContext.request.contextPath }/manageMajor/teacher!deleteInstitute.action?id=${id }&instituteId=${institute.id }'" value="删除">
			          </td>
				    </tr>
<%-- 				  </c:forEach> --%>
				  <!-- 增加行 -->
				  <form action="${pageContext.request.contextPath }/manageMajor/teacher!addInstitute.action" method="post">
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
          <div class="col-xs-6 col-md-4">
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
				  <c:forEach items="${majors}" var="m">
				    <tr>
			          <td class="text-center">${m.majorName }</td>
			          <td class="text-center">
			            <input type="button" class="btn" onclick="location.href='${pageContext.request.contextPath }/manageMajor/teacher!deleteMajor.action?id=${id }&majorId=${m.id }'" value="删除">
			          </td>
				    </tr>
				  </c:forEach>
				  <!-- 增加行 -->
				  <form action="${pageContext.request.contextPath }/manageMajor/teacher!addMajor.action" method="post">
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
          
		  <div class="col-xs-6 col-md-4">
            <div class="panel panel-default">
              <!-- Default panel contents -->
              <div class="panel-heading">对应评阅老师</div>
            
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
			      <c:if test="${viewer!=null }">
				    <tr>
				      <td class="text-center">${viewer.teacherId }</td>
			          <td class="text-center">${viewer.name }</td>
			          <td class="text-center">
			            <input type="button" class="btn" onclick="location.href='${pageContext.request.contextPath }/manageMajor/teacher!deleteViwer.action?id=${id }&viewerId=${t.id }'" value="删除">
			          </td>
				    </tr>
				  </c:if>  
				  <!-- 增加行 -->
				  <form action="${pageContext.request.contextPath }/manageMajor/teacher!addViwer.action" method="post">
				    <s:hidden name="id"></s:hidden>
					<tr>
			          <td class="text-center" colspan="2">
			          	<s:select name="viwerId" list="#viwerList" listKey="id" listValue="name"></s:select>
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
                      
        </div>  
        <!--end修改学院和专业 -->
        
            		
  		
  		</div>
  		
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
