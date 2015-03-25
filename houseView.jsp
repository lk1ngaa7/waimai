<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!Doctype html>
<%
    String path = request.getContextPath();
    String basePath = "http://104.131.131.72";

%>
<html>
<head>
    <base href="<%= basePath%>>">
    <meta content="text/html" charset="utf-8">
    <title>住宿 打嗝网</title>
    <meta name="keywords" content="打嗝网,快餐,送餐,学生生活服务平台,房屋租赁,日租,宾馆,商家展示"/>
    <meta name="description" content="打嗝网,快餐,送餐,学生生活服务平台,房屋租赁,日租,宾馆,商家展示" />
    <link rel="stylesheet" type="text/css" href="css/houseView.css">
    <script type="text/javascript" src="js/jq181.js"></script>
    <script type="text/javascript" src="js/house.js"></script>
</head>
<body>
    <div id="wrapper">
        <div id="wrapperInner">
            <div id="topBar">
                <a id="itemType">
                    <table>
                        <tr>
                            <td>${place.name}</td>
                        </tr>
                    </table>
                </a>
                <div id="storeDesc">
                    <div id="storeSpeed" class="commentStar3">服务态度
                    </div>
                    <div id="storeComment" class="commentStar3">总体评价</div>
                </div>
                <a href="house/1/6/3" class="itemNext">全部</a>
                <a href="house/1/6/3,5" class="itemIndex">长租</a>
                <a href="house/1/6/3,6" class="itemIndex">短租</a>
            </div>
            <div id="content">
                <div id="recommendation">
                    <p>
                        <span id="pics">
                            <c:if test="${pic != null}">
                                 <c:forEach var="obj" items="${pic}" varStatus="status">
                                     <img src="${obj.url}">
                                 </c:forEach>
                            </c:if>
                        </span>
                        <a id="interested" href="interested/${place.pid}"><img src="img/interested.png"></a>
                        <%--<span>&gt; 地址</span>--%>
                        <%--${place.address}<br>--%>
                        <%--<span>&gt; 站长同学说一句</span>--%>
                        ${place.description}<br>
                    </p>
                    <div class="clear"></div>
                </div>
                <div id="comment">
                    <h2>我要评价</h2>
                    <div id="commentInner">
                        <span>服务：</span><span id="commentStarLevel" class="commentStar3"></span><br>
                        <span>印象：</span><span id="commentStarSpeed" class="commentStar3"></span>
                    </div>
                    <form id="commentText" method="POST" action="addComment">
                        <input id="inputCommentStarLevel" name="commentStarLevel" type="hidden">
                        <input id="inputCommentStarSpeed" name="commentStarSpeed" type="hidden">
                        <input type="hidden" name="pId" value="${place.pid}">
                        <textarea class="commentInput" name="content"></textarea>
                        <textarea id="forCountHeight" class="commentInput" style="height: 0px;overflow: hidden;padding:0px;border: none;visibility: hidden;display: block;"></textarea>
                        <div id="commentText1">
                            <span class="inputTip"></span><span class="commentTip">请理性发言，客观评论</span><button id="commentSubmit" type="submit">提交</button>
                        </div>
                    </form>
                    <div id="comments">
                        <c:forEach var="obj" items="${comment}" varStatus="status">
                            <div>
                                <img src="${obj.avatar}">
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