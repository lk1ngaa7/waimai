<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- ————————————————————————添加窗口———————————————————————————————— -->
<!-- ————————————————————————添加窗口———————————————————————————————— -->
<div id="addPlace1Window" class="easyui-window" title="添加外卖店铺" data-options="iconCls:'icon-add',resizable:false,draggable:true,modal:true,closed:true" style="width:800px;height:450px;">
    <!-- 这个是ajax表单 -->
    <form class="form" id="addPlace1Form" method="post" action="">
        <table align="center">
            <tbody>
            <tr>
                <td>外卖店铺标题：</td>
                <td><input type="text" class="easyui-validatebox" data-options="required:true" name="name" style="width:300px;"></td>
            </tr>
            <tr>
                <td>外卖店铺地址：</td>
                <td><input type="text" name="address" style="width:300px;"></td>
            </tr>
            <tr>
                <td>外卖类型：</td>
                <td>
                    <label>
                        <select name="foodType">
                            <option value="1" selected="selected">饭店、面庄</option>
                            <option value="2">烧烤夜啤酒</option>
                        </select>
                    </label>
                </td>
            </tr>
            <tr>
                <td>外卖店铺号码：</td>
                <td><input type="text" name="phone" style="width:300px;"></td>
            </tr>
            <tr>
                <td>店铺图片：</td>
                <td>
                    <input type="file" id="place1ImgUrl" name="file" value="" onchange="">
                    <input type="button" value="点击上传" onclick="uploadCoverPlace1();">
                    <img src="/admin/view/images/loading.gif" id="loadingPlace1" style="display: none;">
                    <input type="hidden" name="icourl" id="icourlPlace1">
                    <span id="place1UploadTip" style="color: #78db1e"></span>
                </td>
            </tr>
            <tr>
                <td>外卖店铺内容：</td>
                <td valign="middle" colspan="3">
                    <textarea id="place1Content" rows="7" cols="100" name="descriptionTextArea" style="width:630px;height:230px;visibility:hidden;">

                    </textarea>
                </td>
            </tr>
            </tbody>
        </table>
        <div style="text-align:center;padding:5px">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitAddPlace1();">提交</a>
            &nbsp;&nbsp;
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearPlace1Form();">清除</a>
            &nbsp;&nbsp;
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="closeAddPlace1Window();">取消</a>
        </div>
        <input type="hidden" name="pid">
        <input type="hidden" id="description1Hidden" name="description">
        <input type="hidden" id="coverHidden" name="hasCover" value="0">
    </form>
</div>

<script type="text/javascript">

    //外卖店铺类型选择 onchange
    $("#addPlace1TypeTree").combotree({
        onChange:function(newValue, oldVaule) {
            $("#addPlace1TypeTree").val(newValue);
        }
    });

    //将表单内容重置为空
    function clearPlace1Form() {
        $('#addPlace1Form').form('clear');
        if(editor!=null) {
        	editor.html("");
        }
    }

    function closeAddPlace1Window() {
        $("#addPlace1Window").window("close");
        clearPlace1Form();
    }

    //提交表单（ajax方式）
    function submitAddPlace1() {
        submitSaveOrUpdate(editor, "description1Hidden", "addPlace1Form", "pid", "/admin/place/doAddPlace1","addPlace1Window","place1List");
        $("#addPlace1Window").window("close");
    }

    //异步上传封面图片
    function uploadCoverPlace1() {
        ajaxUploadFile("loadingPlace1", "place1UploadTip", "place1ImgUrl", "/admin/uploadCover", "icourlPlace1");
    }

</script>

<!-- 文本编辑器组件 -->
<script type="text/javascript">
    var editor;
    KindEditor.ready(function (K) {
        editor = createEditor("place1Content",K);
    });
</script>

<!-- ————————————————————————添加窗口结束———————————————————————————————— -->
<!-- ————————————————————————添加窗口结束———————————————————————————————— -->
