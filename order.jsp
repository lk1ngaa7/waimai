<%@ page import="model.Coupon" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.CouponJson" %>
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
    <title>消费 打嗝网</title>
    <meta name="keywords" content="打嗝网,快餐,送餐,学生生活服务平台,房屋租赁,日租,宾馆,商家展示"/>
    <meta name="description" content="打嗝网,快餐,送餐,学生生活服务平台,房屋租赁,日租,宾馆,商家展示" />
    <link rel="stylesheet" type="text/css" href="css/order.css">
    <style>
        .coupon5Used{
            background: url("/img/coupon5used.jpg") repeat scroll 0 0 rgba(0, 0, 0, 0);
        }
        .coupon10Used{
            background: url("/img/coupon10used.jpg") repeat scroll 0 0 rgba(0, 0, 0, 0);
        }
    </style>
    <script type="text/javascript" src="js/jq181.js"></script>
    <script type="text/javascript" src="js/order.js"></script>
</head>
<body>
    <div id="wrapper">
        <div id="wrapperInner">
            <div id="topBar">
                <a id="itemType">消费</a>
                <%= request.getHeader("Referer") != null ? "<a href=" + request.getHeader("Referer") + " id=\"itemBack\">返回</a>" : ""%>
                <a href="/" id="itemIndex">主页</a>
            </div>
            <div id="content">
                <form id="orderList" action="addOrder" method="post">
                <c:choose>
                    <c:when test="${order != null}">
                        <table>
                            <tr><th width="25%">订单编号</th><th width="20%">总价</th><th width="20%">状态</th><th width="35%" style="text-align: right">日期</th></tr>
                            <c:forEach var="obj" items="${order}" varStatus="status">
                            <c:if test="${obj != null}">
                            <tr class="deleteF">
                                <td>${obj.olid}</td><td>￥${obj.price}</td><td>${obj.statusInfo}</td>
                                <td style="text-align: right;" id="deleteArea">
                                    <div>
                                        <c:if test="${!(obj.status == 2)}">
                                            <a class="delete" oLId="${obj.olid}"></a>
                                        </c:if>
                                        ${obj.updatetime}
                                    </div>
                                </td>
                            </tr>
                            </c:if>
                            </c:forEach>
                        </table>
                        <ul class="point">
                            <li>消费点： <span id="foodPrice" class="totalPrize">${user.consumptionpoint}</span> 点</li>
                        </ul>
                        <ul class="coupon">
                            <li>代金券：</li>
                            <li class="couponCard">
                                <%
                                    List<CouponJson> list = (List<CouponJson>) request.getAttribute("coupon");
                                    for(int i = 0; i < list.size(); i++){
                                        CouponJson c = list.get(i);
                                        //主要是那个“元”被挤下去了，所以10的时候显示元字
                                        if(c.getValue()==10) {
                                            if(c.getStatus()==2) {
                                                out.println("<a style='background: url(\"/img/coupon10used.jpg\") repeat scroll 0 0 rgba(0, 0, 0, 0);' href=\"showCoupon/" + c.getCid() + "\"><span><span></span></span><span>由 <span class=\"cProvider\">" + c.getName() + "</span> 提供</span></a>");
                                            } else {
                                                out.println("<a href=\"showCoupon/" + c.getCid() + "\"><span><span>" + ((int)list.get(i).getValue().doubleValue()) +"</span></span><span>由 <span class=\"cProvider\">" + c.getName() + "</span> 提供</span></a>");
                                            }
                                        } else {
                                            if(c.getStatus()==2) {
                                                out.println("<a style='background: url(\"/img/coupon5used.jpg\") repeat scroll 0 0 rgba(0, 0, 0, 0);' href=\"showCoupon/" + c.getCid() + "\"><span><span></span></span><span>由 <span class=\"cProvider\">" + c.getName() + "</span> 提供</span></a>");
                                            } else {
                                                out.println("<a style='' href=\"showCoupon/" + c.getCid() + "\"><span><span>" + ((int)list.get(i).getValue().doubleValue()) +"</span>元</span><span>由 <span class=\"cProvider\">" + c.getName() + "</span> 提供</span></a>");
                                            }
                                        }
                                    }
                                %>
                                <a class="justifyFix"></a>
                                <a class="justifyFix"></a>
                                <a class="justifyFix"></a>
                                <a class="justifyFix"></a>
                            </li>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        餐车为空
                    </c:otherwise>
                </c:choose>
                </form>
            </div>
        </div>
    </div>
</body>
</html>