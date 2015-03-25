<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- ————————————————————————添加窗口———————————————————————————————— -->
<!-- ————————————————————————添加窗口———————————————————————————————— -->
<div id="seeCommentWindow" class="easyui-window" title="查看留言"
     data-options="iconCls:'icon-see',resizable:false,draggable:true,modal:true,closed:true"
     style="width: 560px; height: 380px;">
    <!-- 这个是ajax表单 -->
    <div style="margin:17px; font-size: 14px">
        <form class="form" id="seeCommentForm" method="post" action="">
            <table align="center">
                <tbody>
                <tr>
                    <td class="alignRight">用户：</td>
                    <td><input type="text" name="username" style="width: 330px;"></td>
                </tr>

                <tr>
                    <td class="alignRight">内容：</td>
                    <td>
                        <textarea rows="3" cols="12" name="content" style="width: 330px; height: 200px"></textarea>
                    </td>
                </tr>
                <tr>
                    <td class="alignRight">时间：</td>
                    <td>
                        <input type="text"  name="updatetime" style="width: 330px">
                    </td>
                </tr>
                </tbody>
            </table>
            <div style="text-align: center; pseeing: 5px">
                <a href="javascript:void(0)" class="easyui-linkbutton"
                    onclick="closeAddCommentWindow();">确定</a>
            </div>
        </form>
    </div>
</div>

<script type="text/javascript">
    function closeAddCommentWindow() {
        $("#seeCommentWindow").window("close");
    }
</script>
<!-- ————————————————————————添加窗口结束———————————————————————————————— -->
<!-- ————————————————————————添加窗口结束———————————————————————————————— -->
