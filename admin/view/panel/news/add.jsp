<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- ————————————————————————添加窗口———————————————————————————————— -->
<!-- ————————————————————————添加窗口———————————————————————————————— -->
<div id="addNewsWindow" class="easyui-window" title="添加新闻" data-options="iconCls:'icon-add',resizable:false,draggable:true,modal:true,closed:true" style="width:1000px;height:550px;">
    <!-- 这个是ajax表单 -->
    <form class="form" id="addNewsForm" method="post" action="">
        <table align="center">
            <tbody>
            <tr>
                <td>新闻标题：</td>
                <td><input type="text" class="easyui-validatebox" data-options="required:true" name="title" style="width:300px;"></td>
            </tr>
            <tr>
                <td>新闻类型：</td>
                <td><input class="easyui-combotree" id="addNewsTypeTree" name="kind" data-options="url:'/admin/view/jsonData/newsType.json',method:'get',required:true"></td>
                <td>创建时间：</td>
                <td><input type="text" name="updatetime" class="Wdate" style="width:170px;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">如果为空，则为当前时间</td>
            </tr>
            <tr>
                <td>新闻内容：</td>
                <td valign="middle" colspan="3">
                    <textarea id="newsContent" rows="7" cols="100" name="content" style="width:830px;height:360px;visibility:hidden;">

                    </textarea>
                </td>
            </tr>
            </tbody>
        </table>
        <div style="text-align:center;padding:5px">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitAddNews();">提交</a>
            &nbsp;&nbsp;
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearNewsForm();">清除</a>
            &nbsp;&nbsp;
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="closeAddNewsWindow();">取消</a>
        </div>
        <input type="hidden" name="nid">
        <input type="hidden" id="descriptionHidden" name="description">
        <input type="hidden" id="coverHidden" name="hasCover" value="0">
    </form>
</div>

<!-- 文件上传板块 -->
<div id="newsUploadWindow" class="easyui-window" title="上传封面图片" data-options="closed:true,iconCls:'icon-save',resizable:false,draggable:true,modal:true" style="width:500px;height:200px;padding:10px;">
		
</div>

<script type="text/javascript">

    //新闻类型选择 onchange
    $("#addNewsTypeTree").combotree({
        onChange:function(newValue, oldVaule) {
            $("#addNewsTypeTree").val(newValue);
        }
    });

    //将表单内容重置为空
    function clearNewsForm() {
        $('#addNewsForm').form('clear');
        if(newsEditor!=null) {
        	newsEditor.html("");
        }
    }

    function closeAddNewsWindow() {
        $("#addNewsWindow").window("close");
        clearNewsForm();
    }
    
    //提交表单（ajax方式）
    function submitAddNews() {
        newsEditor.sync();
        $("#descriptionHidden").val(newsEditor.text());
        $('#addNewsForm').form('submit', {
            url:"/admin/news/doAdd",
            onSubmit: function(){
            },
            success:function(data){
                var str = "";
                if($("#addNewsForm input[name='id']").val()=="") {
                    str = "添加";
                } else {
					str = "更改";
                }
                data = $.trim(data);//去除多余空格
                	if(data=="1") {
                	$.messager.alert("提示",str+'成功！');
                	$("#newsList").datagrid("reload");
                	$("#addNewsWindow").window("close");
                } else if(data=="0"){
                	$.messager.alert("提示",str+'失败！');
                } else {
                	$.messager.alert("调回", data);
                }
            }
        });
    }

    //默认加载进去后关闭一系列窗口
    $(function(){
    	//初始化添加新闻窗口并关闭
        $("#addNewsWindow").window({
            onClose:function () {
                clearNewsForm();
            }
        });
    });
</script>

<!-- 文本编辑器组件 -->
<script type="text/javascript">
    var newsEditor;
    KindEditor.ready(function (K) {
        newsEditor = createEditor("newsContent",K);
    });
</script>

<!-- ————————————————————————添加窗口结束———————————————————————————————— -->
<!-- ————————————————————————添加窗口结束———————————————————————————————— -->
