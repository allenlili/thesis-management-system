
/**
 * 弹出信息
 */
$('#main-content [rel=tooltip]').tooltip();
$('#main-content [rel=popover]').popover();	

//-----------------------------------------------------------------------------------------

/**
 * 密码验证
 */
$("#pwd2").bind('blur',function(){
	if($("#pwd1").val()!=$("#pwd2").val()){
		$("#pwdError").html("两次输入密码不同！");
		$("#pwd1").val("");
		$("#pwd2").val("");
	}
});
$("#pwd1").bind('focus',function(){
	$("#pwdError").html("");
});	
$("#pwd2").bind('focus',function(){
	$("#pwdError").html("");
});	

//-----------------------------------------------------------------------------------------

/**
 * 分页查询
 */
$('#execute #queryButton').bind('click', function(){	
	$('#queryForm').submit();
});
$('#queryButton').bind('click', function(){
	$('#queryForm').submit();
});
$('#queryButton2').bind('click', function(){
	$('#queryForm').submit();
});

//-----------------------------------------------------------------------------------------
/**
 * 单选1、多选1
 */
$("#checkboxes").click(function(){
	$(".singleCheckbox").prop('checked',this.checked);
	var obj = $(".singleCheckbox");
	var count = 0;
	for(var i=0; i<obj.length; i++){
		if(obj[i].disabled==true){
			obj[i].checked = false;
			continue;
		}
		count = count + 1;
	}
	if($(".singleCheckbox:checked").length != count){
		$("#checkboxes").removeAttr("checked");
	}else{
		$("#checkboxes").prop('checked',"checked");
	}	
});
$(".singleCheckbox").change(function(){
	if($(".singleCheckbox").length != $(".singleCheckbox:checked").length){
		$("#checkboxes").removeAttr("checked");
	}else{
		$("#checkboxes").prop('checked',"checked");
	}	
});

/**
 * 单选2、多选2
 */
$("#checkboxes2").click(function(){
	$(".singleCheckbox2").prop('checked',this.checked);
	var obj = $(".singleCheckbox2");
	var count = 0;
	for(var i=0; i<obj.length; i++){
		if(obj[i].disabled==true){
			obj[i].checked = false;
			continue;
		}
		count = count + 1;
	}
	if($(".singleCheckbox2:checked").length != count){
		$("#checkboxes2").removeAttr("checked");
	}else{
		$("#checkboxes2").prop('checked',"checked");
	}	
});
$(".singleCheckbox2").change(function(){
	if($(".singleCheckbox2").length != $(".singleCheckbox2:checked").length){
		$("#checkboxes2").removeAttr("checked");
	}else{
		$("#checkboxes2").prop('checked',"checked");
	}	
});	

/**
 * 判断是否选择学生是否超过人数 
 */
$("#getSelectedStudents").click(function(){
	var willadd = parseInt($("#addTable .singleCheckbox2:checked").length);
	var realHaveSelectedNum =  parseInt($("#realHaveSelectedNum").val());
	var teachNum =  parseInt($("#teachNum").val());
	var total = willadd+realHaveSelectedNum;
	if(total>teachNum){
		alert("超过最大可选择人数！");
	}else{
		$("#addStudents").submit();
	}
});
//-----------------------------------------------------------------------------------------
/**
 * 判断表中没有数据，使按钮失效
 */
if($("#addTable tbody tr").length==0){
	$("#getSelectedStudents").attr("disabled", true);
}

if($("#deleteTable tbody tr").length==0){
	$("#getUnSelectedStudents").attr("disabled", true);
}
//-----------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------

