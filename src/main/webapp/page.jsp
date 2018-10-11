<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/taglib.jsp" %>

  <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.8.3.min.js"></script>
  <script type="text/javascript">
  
    var queryForm;
  
  	$(function() {
  		var contextPath = '${pageContext.request.contextPath }';
  		var url = window.location.href;
  		var path = url.substr(url.indexOf(contextPath));

  		//判断查询form是否存在  		
		$('form').each(function() {
			var r = new RegExp($(this).attr('action'));
			if (r.test(path)) {
				queryForm = $(this);				
			}
		});
		
  		//如果不存在queryForm
  		if (!queryForm) {
  			$("#main").append('<form id = "queryForm" method="post"></form>');
  			queryForm = $('#queryForm');
  			queryForm.attr('action', window.location.href);
  		}
  		
  		//在form中添加start,pageSize对象
  		queryForm.append('<s:hidden name="start" id="start"></s:hidden>');
  		queryForm.append('<s:hidden name="pageSize" id="pageSize"></s:hidden>');
  		
  		//初始化分页变量
  		var start = parseInt($('#start').val());
  		var pageSize = parseInt($('#pageSize').val());
  		var rowCount = parseInt($('#rowCount').html());
  		
  		
  		//总页数
  		var m = rowCount % pageSize;
  		var pageCount = m == 0 ? rowCount / pageSize : (rowCount - m) / pageSize + 1;
  		$('#pageCount').html(pageCount);
  		//第几页
  		$('#pageNo').html(start / pageSize + 1);
  		
  		//判断边界
  		if (start == 0) {
  			$('#prev').attr('disabled', true);
  			$('#first').attr('disabled', true);
  		}
  		if (start == (pageCount - 1) * pageSize || pageCount == 0 ) {
  			$('#next').attr('disabled', true);
  			$('#last').attr('disabled', true);
  		}  		
  		
  		//分页按钮事件
  		$('#first').bind('click', function() {
			$("#start").val(0);  
			queryForm.submit();
  		});
  		$('#next').bind('click', function() {
  			$('#start').val(start + pageSize);
  			$('#queryForm').submit();
  		});
  		$('#prev').bind('click', function() {
  			$('#start').val(start - pageSize);
  			queryForm.submit();
  		});
  		$('#last').bind('click', function() {
  			$('#start').val((pageCount - 1) * pageSize);
  			queryForm.submit();  			
  		});
  		//设置每页行数下拉列表框的onchange事件
  		$('#setPageSize').bind('change', function(){
  			$('#pageSize').val($('#setPageSize').val());
  			$('#start').val(0);
  			queryForm.submit();  			
  		});
  		
  		//跳到第几页
  		$('#go').bind('click',function(){
  	  		//取跳到第几页
  	  		var whichPage = parseInt($('#whichPage').val());  			
  			if(whichPage>pageCount || whichPage<0){
  				alert("超出页数范围！请重新输入！");
  				return;
  			}else{
  	 			$('#start').val((whichPage-1)*pageSize);
  	  			queryForm.submit();
  			}
  		});
  		
  		
  	});
  </script>        
  
                    
		  	  <input id="first" type="button" class="btn btn-default" value="首页">&nbsp;
		  	  <input id="prev" type="button" class="btn btn-default" value="上一页">&nbsp;
		  	  <input id="next" type="button" class="btn btn-default" value="下一页">&nbsp;
		  	  <input id="last" type="button" class="btn btn-default" value="末页">&nbsp;         
		          共<span id="pageCount"></span>页&nbsp;
		          第<span id="pageNo"></span>页&nbsp;
		          共<span id="rowCount">${page.rowCount }</span>行&nbsp;
                              转到：<input id="whichPage" type="text" style="width:30px;">&nbsp;
  	        <input id="go" type="button" class="btn btn-group-sm" value="Go!">&nbsp;		                	
		          每页<s:select 
		    			list="#{5:'5行',10:'10行', 20:'20行', 30:'30行', 40: '40行', 50: '50行' }" 
		    			id="setPageSize" name="pageSize" cssClass="box" cssStyle="width:60px">
		    		</s:select>行    		
  		    
