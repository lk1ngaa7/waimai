<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!Doctype html>
<%
    String path = request.getContextPath();
    String basePath = "http://104.131.131.72";
    int currentPage = (Integer) request.getAttribute("page"),
        total = (Integer) request.getAttribute("total"),
        amount = (Integer) request.getAttribute("amount");
%>
<html>
<head>
    <meta content="text/html" charset="utf-8">
    <base href="<%= basePath%>">
    <title>玩 打嗝网</title>
    <meta name="keywords" content="打嗝网,快餐,送餐,学生生活服务平台,房屋租赁,日租,宾馆,商家展示"/>
    <meta name="description" content="打嗝网,快餐,送餐,学生生活服务平台,房屋租赁,日租,宾馆,商家展示" />
    <link rel="stylesheet" type="text/css" href="/css/play.css">
    <script type="text/javascript" src="js/jq181.js"></script>
    <script type="text/javascript" src="js/food.js"></script>
</head>
<body>
    <div id="wrapper">
        <div id="wrapperInner">
            <div id="topBar">
                <a id="itemType">
                    <table>
                        <tr>
                            <td>玩</td>
                        </tr>
                    </table>
                </a>
                <a href="play/<%= (currentPage - 1) + "/" + amount%>/1,10" id="itemPrev" <%= currentPage - 1 < 1 ? "style=\"display:none\"" : ""%>>上一页</a>
                <a href="play/<%= (currentPage + 1) + "/" + amount%>/1,10" id="itemNext" <%= currentPage + 1 > (int) Math.ceil((double) total/amount) ? "style=\"display:none\"" : ""%>>下一页</a>
                <a href="/" id="itemIndex">主页</a>
            </div>
            <div id="content">
                <c:forEach var="obj" items="${place}" varStatus="status">
                    <a href="show/${obj.pid}">
                        <img src="${obj.icourl}">
                        <span class="status${obj.onbusiness}">
                            <table>
                                <tr>
                                    <td>${obj.name}</td>
                                </tr>
                            </table>
                        </span>
                    </a>
                </c:forEach>
                <a class="aligenFix">&nbsp;</a>
                <a class="aligenFix">&nbsp;</a>
                <a class="aligenFix">&nbsp;</a>
            </div>
        </div>
    </div>
</body>
</html>