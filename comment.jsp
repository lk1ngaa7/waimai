<%@ page import="model.User" %>
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
    <title>打嗝网</title>
    <meta name="keywords" content="打嗝网,快餐,送餐,学生生活服务平台,房屋租赁,日租,宾馆,商家展示"/>
    <meta name="description" content="打嗝网,快餐,送餐,学生生活服务平台,房屋租赁,日租,宾馆,商家展示" />
    <link rel="stylesheet" type="text/css" href="css/comment.css">
    <script type="text/javascript" src="js/jq181.js"></script>
    <script type="text/javascript" src="js/comment.js"></script>
</head>
<body>
    <div id="wrapper">
        <div id="wrapperInner">
            <div id="wrapperInner2">
                <div id="content">
                    <a href="/"></a>
                </div>
                <div id="board">
                    <form id="commentText" method="POST" action="addComment">
                        <textarea class="commentInput" name="content"></textarea>
                        <textarea id="forCountHeight" class="commentInput" style="height: 0px;overflow: hidden;padding:0px;border: none;visibility: hidden;display: block;"></textarea>
                        <div id="commentText1">
                            <span class="inputTip"></span><span class="commentTip">请理性发言，客观评论</span>
                            <%
                                User user = (User) session.getAttribute("user");
                                if(user==null) {
                            %>
                            <span style="color: red"><a href="/">请先登录再留言</a></span>
                            <%
                                } else {
                            %>
                            <button id="commentSubmit" type="submit">提交</button>
                            <%
                                }
                            %>

                        </div>
                    </form>
                    <div id="comments">
                        <c:forEach var="obj" items="${comment}" varStatus="status">
                            <div>
                                <img src="/img/logoBig.png">
                                <div class="comments2">
                                    <div><span>${obj.username}</span><span>${obj.updatetime}</span></div>
                                    <div>${obj.content}</div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>