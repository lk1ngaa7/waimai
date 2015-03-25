<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 14-3-22
  Time: 下午4:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="userCouponWindow" class="easyui-window" title="用户的优惠券"
     data-options="iconCls:'icon-search',resizable:false,draggable:true,modal:true,closed:true"
     style="width:500px;height:300px;">
    <table id="userCouponList" class="easyui-datagrid" style="width:auto;height:250px"
           data-options="fitColumns:true,singleSelect:true">
        <thead>
        <tr>
            <th data-options="field:'cid',width:100">编号</th>
            <th data-options="field:'placeName',width:100">店家名称</th>
            <th data-options="field:'value',width:70">价值</th>
            <th data-options="field:'updatetime',width:100,align:'center'">领取时间</th>
            <th data-options="field:'statusInfo',width:100,align:'center'">使用情况</th>
        </tr>
        </thead>
    </table>
</div>
