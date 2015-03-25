<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!Doctype html>
<%
    String path = request.getContextPath();
    String basePath = "http://104.131.131.72";
%>
<html>
<head>
    <meta content="text/html" charset="utf-8">
    <base href="<%= basePath%>">
    <meta content="text/html" charset="utf-8">
    <title>公告 打嗝网</title>
    <meta name="keywords" content="打嗝网,快餐,送餐,学生生活服务平台,房屋租赁,日租,宾馆,商家展示"/>
    <meta name="description" content="打嗝网,快餐,送餐,学生生活服务平台,房屋租赁,日租,宾馆,商家展示" />
    <link rel="stylesheet" type="text/css" href="css/newsContent.css">
    <script type="text/javascript" src="js/jq181.js"></script>
    <script type="text/javascript" src="js/news.js"></script>
</head>
<body>
    <div id="wrapper">
        <div id="wrapperInner">
            <div id="wrapperInner2">
                <div id="content">
                    <a href="/"></a>
                </div>
                <div id="board">
                    <div id="comments">
                        <h3>${news.title}</h3>
                        <div>${news.content}</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>