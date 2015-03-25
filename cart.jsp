<%@ page import="model.User" %>
<%@ page import="java.util.Calendar" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%><!Doctype html>
<html>
<head>
    <base href="<%= basePath%>">
    <meta content="text/html" charset="utf-8">
    <title>餐车 打嗝网</title>
    <meta name="keywords" content="打嗝网,快餐,送餐,学生生活服务平台,房屋租赁,日租,宾馆,商家展示"/>
    <meta name="description" content="打嗝网,快餐,送餐,学生生活服务平台,房屋租赁,日租,宾馆,商家展示" />
    <link rel="stylesheet" type="text/css" href="css/cart.css">
    <script type="text/javascript" src="js/jq181.js"></script>
    <script type="text/javascript" src="js/jquery.cookie.js"></script>
    <script type="text/javascript" src="js/cart.js"></script>
    <script type="text/javascript">

        <%
            Calendar calendar = Calendar.getInstance();
//            out.print("alert('"+calendar.get(Calendar.HOUR_OF_DAY)+"');");
        %>
    </script>
</head>
<body>
    <div id="wrapper">
        <div id="wrapperInner">
            <div id="topBar">
                <a id="itemType">餐车</a>
                <%= request.getHeader("Referer") != null ? "<a href=" + request.getHeader("Referer") + " id=\"itemBack\">返回</a>" : ""%>
                <a href="/" id="itemIndex">主页</a>
            </div>
            <div id="content">
                <form id="orderList" action="addOrder" method="post">
                <c:choose>
                    <c:when test="${order != null}">
                        <table>
                            <tr><th>餐品名称</th><th>单价</th><th style="text-align: right">数量</th></tr>
                            <c:forEach var="obj" items="${order}" varStatus="status">
                            <c:if test="${obj != null}">
                            <tr class="deleteF">
                                <td>${obj.name}</td><td>￥${obj.price}</td>
                                <td style="text-align: right; font: 0px/0px '宋体'">
                                    <div>
                                        <a class="delete"></a>
                                        <div class="amount">
                                            <input value="${obj.amount}" fid="${obj.fid}" price="${obj.price}" foodType="${obj.foodtype}">
                                        <span>
                                            <span></span>
                                            <span></span>
                                        </span>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            </c:if>
                            </c:forEach>
                        </table>
                        <ul>
                            <li>
                                <%
                                    //检测登录
                                    User user = (User)session.getAttribute("user");
                                    if(user==null) {
                                %>
                                <a href="/?retUrl=/cart" style="text-decoration: underline">对不起，您还没有登录，请点此登录...</a><br>
                                <%
                                    }
                                %>
                                <span class="inputTabEmu">联系电话：</span>
                                <span class="orderInput">
                                    <input class="input" name="phone" autocomplete="off" value="${user.phone}">
                                </span>
                            </li>
                            <li><span class="inputTabEmu">地址：</span>
                                    <input class="input" type="text" name="address" value="${user.address}">
                            </li>
                            <li id="submitLi">
                                <button id="submit">提交</button>
                            </li>
                            <li><span class="orderTip">温馨提示：每份收取￥1.5打包费，5份以上部分按每份￥1计算，烧烤每满￥10加收￥2</span></li>
                            <li><span class="orderTip2">
                                亲爱的童子们：每消费1元钱就可获得1个饱嗝的积分，积分可在住宿，山上山下好吃好玩的兑换优惠券哦！
                                详情戳主页——店铺——有兴趣点这里——领取优惠券——欧克！
                            </span></li>
                            <li>总价： <span id="foodPrice" class="totalPrize">...</span> （<span id="packPrice" class="totalPrize">...</span>打包费）</li>
                        </ul>

                    </c:when>
                    <c:otherwise>
                        <h2 style="font-size: 20px">餐车为空</h2><br>
                        <div style="text-align: left">
                            温馨提示：<br>
                            <%--本网站现每天只送两次餐，分别是上午12点和下午6点；<br>--%>
                            推荐订餐时间：上午8:00~11:30和下午3：00~5:30可以点餐，上午的在12：00~12:30之间会收到餐品，下午的在6：00~6:30会收到餐品。
                        </div>
                    </c:otherwise>
                </c:choose>
                </form>
            </div>
        </div>
    </div>

</body>
</html>