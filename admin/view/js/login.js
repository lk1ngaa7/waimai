$(function() {
    var $dialog = $('<div/>');
    var $formBody = $('#form-body');
    $dialog.dialog({
        height: 300,
        width: 500,
        content: $formBody.show(),
        noheader: true,
        buttons: [{
                id: 'loginBtn',
                disabled: true,
                text: '登陆',
                handler:function(){
                    $.post('public/dologin',$formBody.serialize(),function(rsp){
                          if(rsp.status){
                               window.location.reload();
                          }else{
                              $.messager.alert('提示',rsp.msg);
                          }
                    },'JSON').error(function(){
                        $.messager.alert('提示','系统错误！');
                    });
                }
            }]
    });
    $formBody.after($('#logo').show());
    
    $("#loginBtn").click(function() {
    	login();
    });
});


function login() {
	var username = $("#username").val();
	var password = $("#password").val();
	if(username=="") {
		$.messager.alert("提示","请输入账号！");
		return;
	}
	if(password=="") {
		$.messager.alert("提示","请输入密码！");
		return;
	}
	$.ajax({
		type:"post",
		url:"/admin/view/doLogin",
		data:{"username":username, "password":password},
		success:function(data) {
			if(data=="1") {
				window.location.href = "index";
			} else {
				$.messager.alert("提示","账号密码有误！");
			}
		}
	});
}