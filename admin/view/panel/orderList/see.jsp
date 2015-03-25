<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- ————————————————————————查看窗口———————————————————————————————— -->
<!-- ————————————————————————查看窗口———————————————————————————————— -->
<div id="seeOrderListWindow" class="easyui-window" title="查看订单"
     data-options="iconCls:'icon-search',resizable:false,draggable:true,modal:true,closed:true" style="width:500px;height:490px;">
    <!-- 这个是ajax表单 -->
    <form class="form" id="seeOrderListForm" method="post" action="">
        <table align="center">
            <tbody>
            <tr>
                <td>下单用户：</td>
                <td><input type="text" name="username" style="width:120px;"></td>
             	<td>手机号码：</td>
                <td><input type="text" name="phone" style="width:120px;"></td>
            </tr>
            <tr>
                <td>楼栋地址：</td>
                <td><input type="text" name="address" style="width:120px;"></td>
                <td>总共价格：</td>
                <td><input type="text" name="price" style="width:120px;"></td>
            </tr>
            <tr>
                <td>附加说明：</td>
                <td valign="middle" colspan="3">
                    <textarea id="seeOrderListContent" rows="8" cols="100" name="remark" style="width:350px;height:60px">

                    </textarea>
                </td>
            </tr>
            <tr>
                <td>复制区域：</td>
                <td valign="middle" colspan="3">
                    <textarea id="copyArea" rows="8" cols="100" name="copyText" style="width:350px;height:260px">

                    </textarea>
                </td>
            </tr>
            </tbody>
        </table>
        <div style="text-align:center;pseeing:5px">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="closeSeeOrderListWindow();">确定</a>
        </div>
    </form>
</div>
<!-- ————————————————————————查看窗口结束———————————————————————————————— -->
<!-- ————————————————————————查看窗口结束———————————————————————————————— -->
