<%@ page import="model.User" %>
<%--
  Created by IntelliJ IDEA.
  User: HYY
  Date: 14-3-5
  Time: 下午8:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<%
	 //检测登录
    User user = (User)session.getAttribute("admin");
    if(user==null) {
        response.sendRedirect("/admin/view/login.html");
    }
%>
    <title>后台管理系统主页</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="themes/bootstrap/easyui.css" type="text/css" media="screen"/>
    <link rel="stylesheet" href="themes/icon.css" type="text/css" media="screen"/>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="jquery-easyui-1.3.4/jquery.easyui.min.js"></script>
    <!-- 日期组件 -->
    <script type="text/javascript" src="js/DatePicker/WdatePicker.js"></script>
    <!-- 文本工具 编辑框 -->
    <script charset="utf-8" src="js/kindeditor-4.1.1/kindeditor-min.js"></script>
    <script charset="utf-8" src="js/kindeditor-4.1.1/lang/zh_CN.js"></script>
    <script type="text/javascript" src="js/form2json.js"></script>
    <script type="text/javascript" src="js/ajaxfileupload.js"></script>
    <script type="text/javascript" src="js/heyiyong.js"></script>
    <script type="text/javascript">
        var uploadTip ='<a href="#" class="easyui-linkbutton l-btn" data-options="iconCls:\'icon-add\'" onclick="openUploadCoverPanel();"><span class="l-btn-left"><span class="l-btn-text icon-add l-btn-icon-left">点击上传图片</span></span></a>';
        function changeContent(url, title) {
            var centerTab = $("#centerTab");
            centerTab.panel("setTitle", title);
            centerTab.panel("refresh", url);
        }
        function logout() {
            $.messager.confirm("提示","是否要退出管理系统？", function(r){
                if(r) {
                    $.ajax({
                        type:"post",
                        url:"/admin/view/doLogout",
                        success:function(data) {
                            if(data=="1") {
                                window.location.href = "login.html";
                            }
                        }
                    });
                }
            });
        }
    </script>
    <style type="text/css">
        .alignRight {
            text-align: right;
        }
        .logout {
            color:red;
            text-decoration: none;
        }
        a:visited {
            color:blue;
        }
    </style>
</head>
<body class="easyui-layout" id="bodyLayout">
<div data-options="region:'north'" style="">
    <div class="user_info" style="text-align: right; ">【打嗝网管理员】,欢迎您。
        <a style="text-decoration: none;" href="#" onclick="$('#updateAdminPasswordWindow').window('open');">修改密码</a>&nbsp;&nbsp;
        <a style="text-decoration: none;" href="/" target="_blank">前往首页</a>&nbsp;&nbsp;
        <a class="logout" href="#" onclick="logout();">注销登陆</a>&nbsp;&nbsp;</div>
    <h1 style="">打嗝网 后台管理</h1>
</div>
<div data-options="region:'south'" style="height: 25px;text-align: center;line-height: 25px;overflow: hidden;">
    <%--Power by 重邮蚂蚁app团队--%>
    <form id="bt_jump_form" method="post" style="display: none;" target="_blank"><input name="title" id="bt_jump_page_title"/></form>
</div>

<!-- 左侧导航栏 -->
<div data-options="region:'west',title:'导航栏'" style="width:200px;">
    <!--导航树形结构，其数据定义放在了同级目录的navNodes.json里面-->
    <ul id="navTree" class="easyui-tree" data-options="url:'jsonData/navNodes.json',method:'get',animate:true,lines:true"></ul>
    <script type="text/javascript">
        $("#navTree").tree({
            onSelect:function (node){
                changeContent(node.attributes.url, node.text);
            },
            onDblClick:function (node){
                //alert(node);
            }
        });
    </script>
</div>

<!-- ————————————————中间部分（点击导航后显示的页面） ————————————————————-->
<div id="centerTab" data-options="region:'center',title:'欢迎来到打嗝网后台管理系统'" style="padding:5px;background:#eee;">
    <br><br><br><br><br><br>
    <h2 align="center">欢迎来到打嗝网后台管理系统</h2>
    <%--<h3 align="center">提示：出现故障或寻求帮助，请加技术支持QQ290248126</h3>--%>
    <%--<h3 align="center">提示2：如果出现数据刷新后不显示，则按F5刷新或者重新登录进去即可。</h3>--%>
</div>

<!-- ————————————————中间部分（点击导航后显示的页面） ————————————————————-->

<%--//—————————————————引入新闻的页面—————————————————--%>
<jsp:include page="/admin/view/panel/news/add.jsp"></jsp:include>
<%--//—————————————————新闻页面引入完毕—————————————————--%>

<%--//—————————————————引入店铺管理的页面—————————————————--%>
<jsp:include page="/admin/view/panel/place1/add.jsp"></jsp:include>
<jsp:include page="/admin/view/panel/place1/ticket.jsp"></jsp:include>

<%--//—————————————————引入菜品管理的页面—————————————————--%>
<jsp:include page="/admin/view/panel/food/add.jsp"></jsp:include>
<jsp:include page="/admin/view/panel/food/hot.jsp"></jsp:include>

<%--//—————————————————引入订单管理的页面—————————————————--%>
<jsp:include page="/admin/view/panel/orderList/see.jsp"></jsp:include>

<%--//—————————————————引入用户管理的页面—————————————————--%>
<jsp:include page="/admin/view/panel/user/see.jsp"></jsp:include>
<jsp:include page="/admin/view/panel/user/coupon.jsp"></jsp:include>

<%--//—————————————————引入住宿的页面—————————————————--%>
<jsp:include page="/admin/view/panel/place2/add.jsp"></jsp:include>
<jsp:include page="/admin/view/panel/place2/img.jsp"></jsp:include>
<jsp:include page="/admin/view/panel/place2/placeUser.jsp"></jsp:include>

<jsp:include page="/admin/view/panel/comment/see.jsp"></jsp:include>

<%--
<?php
	//—————————————————引入系统的页面—————————————————
	include 'panel/updatePassword.html';


--%>
</body>
</html>