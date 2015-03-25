<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!Doctype html>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <meta content="text/html" charset="utf-8">
    <base href="<%= basePath%>">
    <meta content="text/html" charset="utf-8">
    <title>公告 打嗝网</title>
    <meta name="keywords" content="打嗝网,快餐,送餐,学生生活服务平台,房屋租赁,日租,宾馆,商家展示"/>
    <meta name="description" content="打嗝网,快餐,送餐,学生生活服务平台,房屋租赁,日租,宾馆,商家展示" />
    <link rel="stylesheet" type="text/css" href="css/news.css">
    <script type="text/javascript" src="js/jq181.js"></script>
    <script type="text/javascript" src="js/news.js"></script>
</head>
<body>
    <div id="wrapper">
        <div id="wrapperInner">
            <div id="wrapperInner2">
                <div id="content">
                    <a href="/"></a>
                    <div id="menu">
                        <a href="news/1/6/1"></a>
                        <a href="news/1/6/2"></a>
                        <a href="news/1/6/3"></a>
                        <a href="news/1/6/4"></a>
                        <a href="news/1/6/5"></a>
                    </div>
                </div>
                <div id="board">
                    <div id="comments">
                        <c:forEach var="obj" items="${news}" varStatus="status">
                            <div><a href="newsContent/${obj.nid}">${obj.title}</a>${obj.updatetime}</div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>