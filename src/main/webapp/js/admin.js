
/**
 * 提交答辩成绩
 */
$("#forwardGrade").click(function(){
	var obj = $(".studentIdlists");
	var obj2 = $(".gradelists");
	for(var i=0; i<obj.length; i++){
		if(obj[i].value==null||obj[i].value==""||obj2[i].value==null||obj2[i].value==""){
			alert("您未录完所有答辩成绩，无法提交！");
			return false;
		}		
	}
	if(confirm("只有一次提交机会，您确定吗？")){
		$("#forward").submit();
	}else{
		return false;
	}
});
/*--------------------------------------------------------------------------------------------*/





