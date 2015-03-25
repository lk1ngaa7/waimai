<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- ————————————————————————添加窗口———————————————————————————————— -->
<!-- ————————————————————————添加窗口———————————————————————————————— -->
<div id="addPlace2Window" class="easyui-window" title="添加信息"
     data-options="iconCls:'icon-add',resizable:false,draggable:true,modal:true,closed:true"
     style="width:800px;height:500px;">
    <!-- 这个是ajax表单 -->
    <form class="form" id="addPlace2Form" method="post" action="">
        <table align="center">
            <tbody>
            <tr>
                <td>信息标题：</td>
                <td><input type="text" class="easyui-validatebox" data-options="required:true" name="name"
                           style="width:300px;"></td>
            </tr>
            <tr>
                <td>信息地址：</td>
                <td><input type="text" name="address" style="width:300px;"></td>
            </tr>
            <tr>
                <td>信息号码：</td>
                <td><input type="text" name="phone" style="width:300px;"></td>
            </tr>
            <tr>
                <td>信息类型：</td>
                <td>
                    <input class="easyui-combotree" id="typePlace2" name="tag"
                           data-options="url:'/admin/view/panel/place2/tag.json'">
                </td>
            </tr>
            <tr>
                <td>创建时间：</td>
                <td><input type="text" name="updatetime" class="Wdate" style="width:170px;"
                           onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">如果为空，则为当前时间
                </td>
            </tr>
            <tr>
                <td>团购地址：</td>
                <td>
                    <input type="text" name="groupbuying" style="width:300px;">
                </td>
            </tr>
            <tr>
                <td>信息图片：</td>
                <td>
                    <input type="file" id="place2ImgUrl" name="file" value="" onchange="">
                    <input type="button" value="点击上传" onclick="uploadCoverPlace2();">
                    <img src="/admin/view/images/loading.gif" id="loadingPlace2" style="display: none;">
                    <input type="hidden" name="icourl" id="icourlPlace2">
                    <span id="place2UploadTip" style="color: #78db1e"></span>
                </td>
            </tr>
            <tr>
                <td>信息内容：</td>
                <td valign="middle" colspan="3">
                    <textarea id="place2Content" rows="7" cols="100" name="descriptionTextArea"
                              style="width:630px;height:230px;visibility:hidden;">

                    </textarea>
                </td>
            </tr>
            </tbody>
        </table>
        <div style="text-align:center;padding:5px">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitAddPlace2();">提交</a>
            &nbsp;&nbsp;
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearPlace2Form();">清除</a>
            &nbsp;&nbsp;
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="closeAddPlace2Window();">取消</a>
        </div>
        <input type="hidden" name="pid">
        <input type="hidden" id="description2Hidden" name="description">
    </form>
</div>

<script type="text/javascript">

    //信息类型选择 onchange
    $("#addPlace2TypeTree").combotree({
        onChange: function (newValue, oldVaule) {
            $("#addPlace2TypeTree").val(newValue);
        }
    });

    //将表单内容重置为空
    function clearPlace2Form() {
        $('#addPlace2Form').form('clear');
        if (editorPlace2 != null) {
            editorPlace2.html("");
        }
    }

    function closeAddPlace2Window() {
        $("#addPlace2Window").window("close");
        clearPlace2Form();
    }

    //提交表单（ajax方式）
    function submitAddPlace2() {
        submitSaveOrUpdate(editorPlace2, "description2Hidden", "addPlace2Form", "pid", "/admin/place/doAddPlace2","addPlace2Window","place2List");
    }

    //默认加载进去后关闭一系列窗口
    $(function () {
        //初始化添加信息窗口并关闭
        $("#addPlace2Window").window({
            onClose: function () {
                clearPlace2Form();
            }
        });
        //$("#addPlace2Window").window("close");
    });

    //异步上传封面图片
    function uploadCoverPlace2() {
        ajaxUploadFile("loadingPlace2", "place2UploadTip", "place2ImgUrl", "/admin/uploadCover", "icourlPlace2");
    }

</script>

<!-- 文本编辑器组件 -->
<script type="text/javascript">
    var editorPlace2;
    KindEditor.ready(function (K) {
        editorPlace2 = createEditor("place2Content",K);
    });
</script>

<!-- ————————————————————————添加窗口结束———————————————————————————————— -->
<!-- ————————————————————————添加窗口结束———————————————————————————————— -->
