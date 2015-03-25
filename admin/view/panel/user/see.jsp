<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- ————————————————————————查看窗口———————————————————————————————— -->
<!-- ————————————————————————查看窗口———————————————————————————————— -->
<div id="seeUserWindow" class="easyui-window" title="查看用户"
     data-options="iconCls:'icon-search',resizable:false,draggable:true,modal:true,closed:true" style="width:500px;height:300px;">
    <!-- 这个是ajax表单 -->
    <form class="form" id="seeUserForm" method="post" action="">
        <table align="center">
            <tbody>
            <tr>
                <td>用户名：</td>
                <td><input type="text" name="username" style="width:120px;"></td>
             	<td align="right">昵 称：</td>
                <td><input type="text" name="nickname" style="width:120px;"></td>
            </tr>
            <tr>
                <td>优惠券：</td>
                <td><input id="youhuiquan1" type="text" name="couponCount" style="width:120px;"></td>
                <td align="right">积 分：</td>
                <td><input type="text" name="consumptionpoint" style="width:120px;"></td>
            </tr>
            <tr>
                <td align="left">最后一次登录时间：</td>
                <td colspan="3" align="left"><input type="text" name="lastTime" style="width:120px;"></td>
            </tr>
            <tr>
                <td>Q Q：</td>
                <td><input type="text" name="qq" style="width:120px;"></td>
                <td align="right">邮 箱：</td>
                <td><input type="text" name="email" style="width:120px;"></td>
            </tr>
            <tr>
                <td>楼栋地址：</td>
                <td><input type="text" name="address" style="width:120px;"></td>
                <td align="right">注册时间：</td>
                <td><input type="text" name="updatetime" style="width:120px;"></td>
            </tr>
            <tr>
                <td>登录次数：</td>
                <td><input type="text" name="loginTimes" style="width:120px;"></td>
                <td align="right" >手机号码：</td>
                <td><input type="text" name="phone" style="width:120px;"></td>
            </tr>
            </tbody>
        </table>
        <div style="text-align:center;pseeing:5px">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#seeUserWindow').window('close')">确定</a>
        </div>
    </form>
</div>
<!-- ————————————————————————查看窗口结束———————————————————————————————— -->
<!-- ————————————————————————查看窗口结束———————————————————————————————— -->
