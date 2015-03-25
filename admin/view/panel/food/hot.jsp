<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 14-3-23
  Time: 下午1:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div id="hotImgWindow" class="easyui-window" title="热门菜品设置"
     data-options="iconCls:'icon-edit',resizable:false,draggable:true,modal:true,closed:true"
     style="width:550px;height:410px;">
    <div style="border: 1px solid blue; margin-top:20px;width: 380px; padding: 5px">
        当前图片：<br>

        <div id="currentImgDiv"></div>

        请选择位置：
        <select id="hotImgPosition">
            <option value="0">——请选择——</option>
            <option value="1">提交为app左侧图片</option>
            <option value="2">提交为app右侧图片</option>
        </select>
        <br>
        更改图片：
        <input type="file" id="hotImgUpload" name="file" onchange="saveOrUpdateHotImg();">
        <input type="hidden" id="fidHotImg" name="fid">
        <input type="hidden" id="fidHotImgUrl">
        <img src="/admin/view/images/loading.gif" id="hotImgUrlLoading" style="display: none;">
        <span id="foodHotImgUploadTip" style="color: #78db1e"></span>
    </div>

    <br><br>

    <div style="border: 1px solid blue; margin-top:20px;width: 130px; padding: 5px">
        取消设置为热门：<br>
        <input type="button" value="点此取消" onclick="cancelHot();">
    </div>

    <script type="text/javascript">
        function saveOrUpdateHotImg() {
            $("#foodHotImgUploadTip").html("");
            var position = $("#hotImgPosition").val();
            if (position == 0) {
                alert("请先选择位置");
            } else {
                ajaxUploadFileHotImg("hotImgUrlLoading", "foodHotImgUploadTip", "hotImgUpload", "/admin/uploadCover", position);
            }
        }

        function ajaxUploadFileHotImg(loadingId, tipId, fileElementId, url, position) {
            $("#" + loadingId).show();
            $.ajaxFileUpload({
                        url: url,//用于文件上传的服务器端请求地址
                        secureuri: false,//一般设置为false
                        fileElementId: fileElementId,
                        dataType: 'json',//返回值类型 一般设置为json
                        success: function (data, status) {
                            $("#" + tipId).html("上传成功！");
                            var fid = $("#fidHotImg").val();
                            setHotImg(fid, data.url, position);
                        },
                        error: function (data, status, e) {
                            alert(e);
                        }
                    }
            )
        }

        function setHotImg(fid, url, type) {
            $.ajax({
                url: "/admin/food/setHot",
                type: 'get',
                data: {fid: fid, imgUrl: url, type: type},
                success: function (data) {
                    if (data == "1") {
                        showMyMsgDialog(2000, "设置成功！");
                    } else {
                        showMyMsgDialog(2000, "失败！");
                    }
                }
            });
        }

        function cancelHot() {
            var fid = $("#fidHotImg").val();
            setHotImg(fid, "", 0);
        }
    </script>
</div>