<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 14-3-12
  Time: 上午10:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- CSS goes in the document HEAD or added to your external stylesheet -->

<style type="text/css">

    table.place2ImgTable {

        font-family: verdana, arial, sans-serif;

        font-size: 11px;

        color: #333333;

        border-width: 1px;

        border-color: #666666;

        border-collapse: collapse;

    }

    table.place2ImgTable th {
        text-align: center;

        border-width: 1px;

        padding: 8px;

        border-style: solid;

        border-color: #666666;

        background-color: #dedede;

    }

    table.place2ImgTable td {

        border-width: 1px;

        padding: 8px;

        border-style: solid;

        border-color: #666666;

        background-color: #ffffff;

    }
    table.place2ImgTable img {
        max-width: 330px;
        cursor: pointer
    }
</style>

<div id="imgPlace2Window" class="easyui-window" title="图片管理"
     data-options="iconCls:'icon-edit',resizable:false,draggable:true,modal:true,closed:true"
     style="width:800px;height:400px;">

    提示：点击图片即可删除该图片<br>
    图片上传：
    <input type="file" id="place2Img2Url" name="file" value="" onchange="uploadPlace2Img()">
    <img src="/admin/view/images/loading.gif" id="place2ImgUrlLoading" style="display: none;">
    <input type="hidden" name="" id="place2ImgUrl2">
    <input type="hidden" name="" id="place2ImgUrlPid">
    <span id="place2ImgUploadTip" style="color: #78db1e"></span>
    <script type="text/javascript">
        function uploadPlace2Img() {
            $("#place2ImgUploadTip").html("");
            ajaxUploadFile("place2ImgUrlLoading", "place2ImgUploadTip", "place2Img2Url","/admin/uploadCover","");
        }
        function doUploadPlace2Img() {
            var imgUrl = $("#place2ImgUrl2").val();
            var pid = $("#place2ImgUrlPid").val();
            $.ajax({
                url:"/admin/place/addPlace2Img",
                type:"get",
                data:{"url":imgUrl,"pid":pid},
                success:function(data) {
                    if(data=="1"|| data==1) {
                        showMyMsgDialog(3000,"上传图片成功！");
                        showPlace2Pic(pid);
                    } else {
                        showMyMsgDialog(3000,"上传图片失败！");
                    }
                }
            });
        }
        function deletePlace2Img(picId) {
            if(confirm("危险操作，确定要删除这一条数据吗？")) {
                $.ajax({
                    url:"/admin/place/deletePlace2Img",
                    type:"get",
                    data:{"picId":picId},
                    success:function(data) {
                       if(data=="1" || data==1) {
                           showMyMsgDialog(3000, "删除图片成功！");
                           var pid = $("#place2ImgUrlPid").val();
                           showPlace2Pic(pid);
                       }
                    }
                });
            }
        }
    </script>

    <%--图片区域--%>
    <table id="place2ImgTable" class="place2ImgTable">
        <tr><th>图片</th></tr>
    </table>
</div>
