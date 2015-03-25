<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!Doctype html>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%= basePath%>>">
    <meta content="text/html" charset="utf-8">
    <title>结果 打嗝网</title>
    <%= "1".equals(request.getAttribute("success")) && request.getAttribute("redirect") != null ? "<meta http-equiv=\"refresh\" content=\"3; url=" + request.getAttribute("redirect") + "\">" : "" %>
    <meta name="keywords" content="打嗝网,快餐,送餐,学生生活服务平台,房屋租赁,日租,宾馆,商家展示"/>
    <meta name="description" content="打嗝网,快餐,送餐,学生生活服务平台,房屋租赁,日租,宾馆,商家展示" />
    <link rel="stylesheet" type="text/css" href="css/orderSuccess.css">
    <script type="text/javascript" src="js/jq181.js"></script>
</head>
<body>
<div id="wrapper">
    <div id="wrapperInner">
        <div id="content">
            <img src="img/logoBig.png">
            <div id="inner">
                <%= request.getAttribute("msg") %><br>
            </div>
            <div id="topBar">
                <%= request.getHeader("Referer") != null && !"1".equals(request.getAttribute("success")) ? "<a href=" + request.getHeader("Referer") + " id=\"itemBack\">返回</a>" : ""%>
                <a href="/" id="itemIndex">主页</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>