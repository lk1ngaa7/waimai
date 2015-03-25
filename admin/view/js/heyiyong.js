function showNoSelectLine() {
	$.messager.show({
		title : '提示',
		msg : "<font color='red' size='3px'>您没有选择任何一行！</font>",
		timeout : 3000,
		showType : 'slide'
	});
}
function showDialog1(time, count) {
    $.messager.show({
        title : '提示',
        msg : "<font color='#00008b' size='4px'>成功处理"+count+"条信息！</font>",
        timeout : time,
        showType : 'slide'
    });
}
function showMyMsgDialog(time, msg) {
    $.messager.show({
        title : '提示',
        msg : msg,
        timeout : time,
        showType : 'slide'
    });
}
/**
 * 提交“添加”表单
 * @param editor 编辑器对象
 * @param contentId 编辑框id
 * @param formId 表单id
 * @param primaryKeyName 表主键的input标签的name属性
 * @param url 提交的位置
 */
function submitSaveOrUpdate(editor, contentId, formId, primaryKeyName, url, windowId,datagridId) {
    editor.sync();
    $("#"+contentId).val(editor.text());
    $('#'+formId).form('submit', {
        url:url,
        onSubmit: function(){
        },
        success:function(data){
            var str = "";
            if($("#"+formId+" input[name='"+primaryKeyName+"']").val()=="") {
                str = "添加";
            } else {
                str = "更改";
            }
            data = $.trim(data);//去除多余空格
            if(data=="1") {
                showMyMsgDialog(2000, str+'成功！');
                $("#"+datagridId).datagrid("reload");
                $("#"+windowId).window("close");
            } else if(data=="0"){
                $.messager.alert("提示",str+'失败！');
            } else {
                $.messager.alert("调回", data);
            }
        }
    });
}

/**
 * 异步ajax文件上传
 * @param loadingId 等待id
 * @param tipId 成功或失败的提示语id
 * @param fileElementId <input type='file'>的id值
 * @param url 提交到哪里
 * @param inputId 真实值id
 */
function ajaxUploadFile(loadingId, tipId, fileElementId, url, inputId) {
    $("#"+loadingId).show();
    jQuery.ajaxFileUpload({
            url: url,//用于文件上传的服务器端请求地址
            secureuri: false,//一般设置为false
            fileElementId: fileElementId,
            dataType: 'json',//返回值类型 一般设置为json
            success: function (data, status) {
                if(inputId=="") {//这里为了兼容img.jsp页面能够使用
                    $("#place2ImgUrl2").val(data.url);
                    doUploadPlace2Img();
                } else {
                    $("#"+inputId).val(data.url);
                }
                $("#"+loadingId).hide();
                $("#"+tipId).html("上传成功！");
            },
            error: function (data, status, e){
                alert(e);
            }
        }
    )
}

function createEditor(contentId, K) {
        var editor = K.create('#'+contentId, {
            resizeType:1,
            allowPreviewEmoticons:true,
            fullscreenShortcut:false,//禁用全屏
            allowUpload:true,
            //是否可以弹出对话框选择文件
            allowFileManager:true,
            //文件选择的时候弹出的对话框/对话框中可以放置服务器图片文件
            //fileManagerJson:"/test/saveImage",
            allowImageUpload:true,
            uploadJson:"/admin/imageUpload",
            syncType:"absolute",
            items:[
                'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
                'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
                'insertunorderedlist', '|', 'emoticons', 'image', 'link', '|', 'flash', 'media', 'insertfile'],
            afterCreate:function () {
                /*  var self = this;
                 K.ctrl(document, 13, function () {
                 self.sync();
                 document.forms['form'].submit();
                 });
                 K.ctrl(self.edit.doc, 13, function () {
                 self.sync();
                 document.forms['form'].submit();
                 }); */
            }
        });
       return editor;
}


//——————————————————————————————————————————————————————————————————
//——————————————————————————————————————————————————————————————————
//——————————————————————————————————————————————————————————————————
//——————————————————————————————————————————————————————————————————
/**
 * 根据选择的多行对象，获取他们的id
 * @param rows
 * @returns {string}
 */
function getManyRowPId(rows) {
    var str = "";
    for(var i=0; i<rows.length; i++) {
        if(i!=0) {
            str += ",";
        }
        str += rows[i].pid;
    }
    return str;
}

function tickedManage(pid) {
    $.ajax({
        url: "/admin/place/getTicket?pid=" + pid,
        type: "get",
        success: function (data) {
            if(data=="") {
                data="暂无提供优惠券"
            }
            $("#currentTicket").val(data);
            $("#ticketPid").val(pid);
            $("#ticketWindow").window("open");
        }
    });
}

/**
 * 合作关系设置
 */
function cooperate(pid, listId) {
    $.ajax({
        url: "/admin/place/cooperate?pid=" + pid,
        type: "get",
        success: function (data) {
            if(data=="1"){
                $("#"+listId).datagrid("reload");
            } else {
                $("#"+listId).datagrid("reload");
            }
            showMyMsgDialog(2000, "设置合作关系成功！");
        }
    });
}