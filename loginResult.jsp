<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!Doctype html>
<html>
<head>
    <meta content="text/html" charset="utf-8">
    <title>登录 打嗝网</title>
    <%= "1".equals(request.getAttribute("success")) ? "<meta http-equiv=\"refresh\" content=\"3; url=food/1/6\">" : "" %>
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
                登录<%= "1".equals(request.getAttribute("success")) ? "成功" : "失败" %>！<br>
                <%= "1".equals(request.getAttribute("success")) ? "正在为您跳转到订餐页面..." : "原因是：" + request.getAttribute("msg") %><br>
            </div>
            <div id="topBar">
                <a href="/" id="itemIndex">主页</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>