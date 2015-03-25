<%@ page import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!Doctype html>
<html>
<head>
    <meta content="text/html" charset="utf-8">
    <title>打嗝网</title>
    <meta name="keywords" content="打嗝网,快餐,送餐,学生生活服务平台,房屋租赁,日租,宾馆,商家展示"/>
    <meta name="description" content="打嗝网,快餐,送餐,学生生活服务平台,房屋租赁,日租,宾馆,商家展示" />
    <link rel="stylesheet" type="text/css" href="css/index.css">
    <script type="text/javascript" src="js/jq181.js"></script>
    <script type="text/javascript" src="js/index.js"></script>
    <%
        String retUrl = request.getParameter("retUrl");
        String reqStr = "";
        if(retUrl!=null && !"".equals(retUrl)) {
            reqStr = "?retUrl="+retUrl;
        }

        User user = (User) request.getSession().getAttribute("user");
    %>
    <script type="text/javascript">
        var point = <%= user != null ? user.getConsumptionpoint() : null%>,
                couponAmount = <%= request.getAttribute("couponAmount")%>;
        if(point !==null){
            $("head").append("<script type='text/javascript' src='js/personal.js'><\/script>");
    }
    </script>
</head>
<body>
<div id="wrapper">
    <div id="wrapperInner">
        <div id="wrapperInner2">
            <div id="content" class="animationbounceInDown">
                <a href="food/1/6" id="itemFood"></a>
                <a href="play/1/6/1,10" id="itemRelaxation"></a>
                <a href="playIndex.html" id="itemEntertainment"></a>
                <a href="news/1/6/1" id="itemNotice"></a>
                <a href="comment?page=1&amount=100" id="itemMessage"></a>
                <a href="about.html" id="itemAbout"></a>
                <a href="houseIndex.html" id="itemHouse"></a>
            </div>
            <div id="menu" <%= request.getSession().getAttribute("user") == null ? "" : "style=\"display:none;\""%>>
                <form method="post" action="doLogin<%=reqStr%>">
                    <a href="reg" id="register"><span></span></a><input name="username" value="请输入昵称"><input name="password" type="password" placeholder="请输入密码"><button id="login" type="submit"><span></span></button>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="personalF" style="display: none;">
    <div>
        <span id="consumptionPoint"><a href="order">0</a></span>
        <span id="coupon"><a href="order">0</a></span>
        <span id="collection"><a href="order">0</a></span>
        <span id="infoModify"></span>
        <span id="personal"></span>
    </div>
</div>
</body>
</html>