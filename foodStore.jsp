<%@ page import="model.User" %>
<%@ page import="common.GlobalTool" %>
<%@ page import="common.Status" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!Doctype html>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    User user = (User) request.getSession().getAttribute("user");
%>
<html>
<head>
    <meta content="text/html" charset="utf-8">
    <base href="<%= basePath%>">
    <title>店铺 打嗝网</title>
    <meta name="keywords" content="打嗝网,快餐,送餐,学生生活服务平台,房屋租赁,日租,宾馆,商家展示"/>
    <meta name="description" content="打嗝网,快餐,送餐,学生生活服务平台,房屋租赁,日租,宾馆,商家展示"/>
    <link rel="stylesheet" type="text/css" href="css/foodStore.css">
    <script type="text/javascript" src="js/jq181.js"></script>
    <script type="text/javascript" src="js/jquery.cookie.js"></script>
    <script>
        <%--如果时间不对头，要提示，并且哪些时间不能点餐--%>
        function orderTip() {
<%
        /*①首先检查店铺是否处于正常营业状态*/
        Integer storeStatus = (Integer) request.getAttribute("onBusiness");
        Integer foodType = (Integer) request.getAttribute("foodType");//取得类型（1为普通菜品，2为烧烤）
        Status orderStatus = GlobalTool.getOrderTip(storeStatus, foodType);
        //————————————————————————————
//        if(orderStatus.getTip()!=null && !"".equals(orderStatus.getTip())) {
//             out.println("alert('" + orderStatus.getTip()+"');");
//        }
        //————————————————————————————
        //因为手机端当时判断已经弄反了，所以这里也只能取反
        out.println("return " + (!orderStatus.isCanSubmit())+";");
%>
        }
    </script>
    <script type="text/javascript" src="js/foodStore.js"></script>
    <script type="text/javascript">
        var point = <%= user != null ? user.getConsumptionpoint() : null%>,
                couponAmount = <%= request.getAttribute("couponAmount")%>;
    </script>
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
                <div id="storeSpeed" class="commentStar3">出餐速度</div>
                <div id="storeComment" class="commentStar3">总体评价</div>
            </div>
            <a href="/" id="itemNext">主页</a>
            <a href="cart" id="itemIndex">餐车</a>
            <a href="order" id="itemOrder">消费</a>
        </div>
        <div id="content">
            <c:if test="${ recommend != null}">
                <div id="recommendation">
                    <h1>今日菜品推荐：${recommend.name}</h1>

                    <p>
                        <img src="${recommend.pic}">
                        <span>菜品详细介绍</span><br>
                            ${recommend.description}
                    </p>

                    <div class="clear"></div>
                </div>
            </c:if>
            <div id="foodMenu">
                <c:forEach var="obj" items="${menu}" varStatus="status">
                    <c:if test="${status.count%3 == 1}"><ul></c:if>
                    <li>
                        <table>
                            <tr>
                                <td><span>${obj.name}</span></td>
                                <td width="90"><span class="prize">￥${obj.price}</span><span class="order"
                                                                                             fid="${obj.fid}"></span>
                                </td>
                            </tr>
                        </table>
                    </li>
                    <c:if test="${status.count%3 == 0}"></ul></c:if>
                </c:forEach>
                <div class="clear"></div>
            </div>
            <div id="comment">
                <h2>我要评价</h2>

                <div id="commentInner">
                    <span>口味：</span><span id="commentStarLevel" class="commentStar3"></span><br>
                    <span>速度：</span><span id="commentStarSpeed" class="commentStar3"></span>
                </div>
                <form id="commentText" method="POST" action="addComment">
                    <input id="inputCommentStarLevel" name="commentStarLevel" type="hidden">
                    <input id="inputCommentStarSpeed" name="commentStarSpeed" type="hidden">
                    <input type="hidden" name="pId" value="${place.pid}">
                    <textarea class="commentInput" name="content"></textarea>
                    <textarea id="forCountHeight" class="commentInput"
                              style="height: 0px;overflow: hidden;padding:0px;border: none;visibility: hidden;display: block;"></textarea>

                    <div id="commentText1">
                        <span class="inputTip"></span><span class="commentTip">请理性发言，客观评论</span>
                        <button id="commentSubmit" type="submit">提交</button>
                    </div>
                </form>
                <div id="comments">
                    <c:forEach var="obj" items="${comment}" varStatus="status">
                        <div>
                            <img src="/img/default.png">

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