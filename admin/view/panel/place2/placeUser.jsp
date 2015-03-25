<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div id="placeUserManageWindow" class="easyui-window" title="添加信息"
     data-options="iconCls:'icon-add',resizable:false,draggable:true,modal:true,closed:true"
     style="width:300px;height:200px;">
    <div id="placeUserTip" style="color: red;padding: 5px">提示：该店铺没有账号</div>
    <form id="placeUserManageForm" action="" method="post">
        <table>
            <tr>
                <td align="right">用户名：</td>
                <td><input type="text" name="username"></td>
            </tr>
            <tr>
                <td align="right">密码：</td>
                <td><input type="password" name="password"></td>
            </tr>
            <tr>
                <input type="hidden" name="pid" id="placeUserPid">
                <input type="hidden" name="puid">
                <td colspan="2" align="right"><input type="button" value="提交" onclick="submitPlaceUser()"></td>
            </tr>
            <tr>
                <td colspan="2"> <div style="color: red;padding: 5px">只有提示成功才算操作成功，否则为失败！</div></td>
            </tr>
        </table>
    </form>
</div>
<script type="text/javascript">
    function submitPlaceUser() {
        var str = "";
        if ($("#placeUserManageForm input[name='puid']").val() == "") {
            str = "添加";
        } else {
            str = "更改";
        }
        $("#placeUserManageForm").form("submit", {
            url: "/admin/placeUser/saveOrUpdate",
            success: function (data) {
                if (data == "1") {
                    showMyMsgDialog(2000, str+"成功！");
                    $("#placeUserManageWindow").window("close");
                } else if (data == "0") {
                    showMyMsgDialog(2000, str+"失败！有可能是添加或修改的时候，用户名相同了！");
                }
            },
            error:function() {
                showMyMsgDialog(2000, str+"失败！有可能是添加或修改的时候，用户名相同了！");
            }
        });
    }
</script>