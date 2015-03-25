<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!Doctype html>
<html>
<head>
    <meta content="text/html" charset="utf-8">
    <title>生成订单 打嗝网</title>
    <%= "1".equals(request.getAttribute("success")) ? "<meta http-equiv=\"refresh\" content=\"3; url=order\">" : "" %>
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
                <%= "1".equals(request.getAttribute("success")) ? "订单已生成！<br>\n" +
                    "您的餐品将在接下来的60分钟内配送，<br>\n" +
                    "请耐心等待，谢谢惠顾！<br>" :
                    "订单生成失败！原因是：" %><br>
                <%= "1".equals(request.getAttribute("success")) ? "正在为您跳转到订单页面..." : (request.getAttribute("msg") != null ? request.getAttribute("msg") : "") %><br>
            </div>
            <div id="topBar">
                <%= request.getHeader("Referer") != null && !"1".equals(request.getAttribute("success")) ? "<a href=" + request.getHeader("Referer") + " id=\"itemBack\">返回</a>" : ""%>
                <a href="/" id="itemIndex">主页</a>
                <a href="order" id="itemOrder">消费</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>