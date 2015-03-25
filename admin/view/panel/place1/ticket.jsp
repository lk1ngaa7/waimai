<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- ————————————————————————添加窗口———————————————————————————————— -->
<!-- ————————————————————————添加窗口———————————————————————————————— -->
<style type="text/css">
    .ticket {
        font-size: 15px;
    }
</style>
<div id="ticketWindow" class="easyui-window" title="添加优惠券"
     data-options="iconCls:'icon-add',resizable:false,draggable:true,modal:true,closed:true"
     style="width:600px;height:230px;">
    <!-- 这个是ajax表单 -->
    <table align="center" class="ticket">
        <tr>
            <td align="right">快速选择：（可多选）</td>
            <td>
                <label><input type="checkbox" id="v5" value="5">5元</label>&nbsp;&nbsp;
                <label><input type="checkbox" id="v10" value="10">10元</label>&nbsp;&nbsp;
                <%--<label><input type="checkbox" id="v15" value="15">15元</label>&nbsp;&nbsp;--%>
                <%--<label><input type="checkbox" id="v20" value="20">20元</label>&nbsp;&nbsp;--%>
                <a id="quickSelect" href="#" class="easyui-linkbutton" onclick="quickSelect()"
                   data-options="iconCls:'icon-add'">提交</a>
            </td>
        </tr>
        <%--<tr>--%>
            <%--<td align="right">自己填写：</td>--%>
            <%--<td>--%>
                <%--<input type="text" id="handWrite">--%>
                <%--（只输入整数）--%>
                <%--<a id="handbtn" href="#" class="easyui-linkbutton" onclick="handWrite()"--%>
                   <%--data-options="iconCls:'icon-add'">提交</a>--%>
            <%--</td>--%>
        <%--</tr>--%>
        <tr>
            <td align="right">当前情况：</td>
            <td><input type="text" id="currentTicket" value="无优惠券" readonly="readonly"></td>
        </tr>
    </table>
    <input type="hidden" id="ticketPid">
    <div style="width: auto"><a href="javascript:void(0)" class="easyui-linkbutton"  onclick="$('#ticketWindow').window('close');">确定</a></div>
</div>

<script type="text/javascript">
    function quickSelect() {
        var str = "";
        if (document.getElementById("v5").checked) {
            str += "5";
        }
        if (document.getElementById("v10").checked) {
            if (str != "") {
                str += ",";
            }
            str += "10";
        }
//        if (document.getElementById("v15").checked) {
//            if (str != "") {
//                str += ",";
//            }
//            str += "15";
//        }
//        if (document.getElementById("v20").checked) {
//            if (str != "") {
//                str += ",";
//            }
//            str += "20";
//        }
        ticketSubmit(str, $("#ticketPid").val());
    }

    function handWrite() {
        var str = $("#handWrite").val();
        ticketSubmit(str, $("#ticketPid").val());
    }

    function ticketSubmit(str, pid) {
        $.ajax({
            type: "get",
            url: "/admin/place/addTicket?str=" + str + "&pid=" + pid,
            success: function (data) {
                if (data == "1") {
                    showMyMsgDialog(3800,"添加成功！（" + str + "）");
                    $("#ticketWindow").window("close");
                } else {
                    alert("添加失败！");
                }
            }
        });
    }
</script>

<!-- ————————————————————————添加窗口结束———————————————————————————————— -->
<!-- ————————————————————————添加窗口结束———————————————————————————————— -->
