<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!Doctype html>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%= basePath%>>"><!Doctype html>
    <meta content="text/html" charset="utf-8">
    <title>路线 打嗝网</title>
    <meta name="keywords" content="打嗝网,快餐,送餐,学生生活服务平台,房屋租赁,日租,宾馆,商家展示"/>
    <meta name="description" content="打嗝网,快餐,送餐,学生生活服务平台,房屋租赁,日租,宾馆,商家展示" />
    <link rel="stylesheet" type="text/css" href="css/click.css">
    <script type="text/javascript" src="js/jq181.js"></script>
    <script type="text/javascript">
        var pid = ${place.pid},
             placeName = "${place.name}";
    </script>
    <script type="text/javascript" src="js/click.js"></script>
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
            <a href="/" class="itemNext">主页</a>
        </div>
        <div id="content">
            <div id="recommendation">
                <p>
                    <span id="map">
                        <img src="http://api.map.baidu.com/staticimage?center=${place.coordinate}&width=500&height=333&zoom=18">
                    </span>
                    <%--<span>&gt; 站长同学说一句</span>--%>
                    ${place.description}
                    <br>
                    <a id="getCoupon5Btn" class="btn_1">领取5元代金券</a>
                    <a id="getCoupon10Btn" class="btn_1">领取10元代金券</a>
                </p>
                <div class="clear"></div>
            </div>
            <div id="comment">
                <div>
                    <span>地址</span>
                    <p>${place.address}</p>
                </div>
                <div>
                    <span>团购</span>
                    <p>${place.groupbuying}</p>
                </div>
            </div>
        </div>
    </div>
</div>
<textarea id="dialogue" style="display: none;">
    <div id="showCouponInfoCover">
        <div>
            <div class="couponInfoContent">
                <h1 class="dialogueH1">您的消费点：<span id="couponPoint">0</span></h1>
                <table id="couponTable" style="display: none;">
                    <tr><th>店名</th><th>价值</th><th style="text-align: right">数量</th></tr>
                    <tr class="deleteF">
                        <td id="storeName">商店</td><td>￥<span id="couponValue">0</span></td>
                        <td style="text-align: right; font: 0px/0px '宋体'">
                            <div>
                                <div class="amount">
                                    <input value="0" id="couponAmount">
                                <span>
                                    <span></span>
                                    <span></span>
                                </span>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" style="text-align: right">
                            <a id="doGetCoupon" class="btn_1">确认领取</a>
                        </td>
                    </tr>
                </table>
                <span id="msg" class="msg">失败</span>
            </div>
        </div>
        <script>
            $(function(){

                var couponInfoContent = $(".couponInfoContent"),
                        msg = $("#msg"),
                        couponPoint = $("#couponPoint"),
                        storeName = $("#storeName"),
                        couponValue = $("#couponValue"),
                        couponAmount = $("#couponAmount"),
                        link = $("#doGetCoupon");

                $("#showCouponInfoCover").click(function(){
                    $(this).remove();
                });

                couponInfoContent.click(function(e){
                    e.stopPropagation();
                });

                loadData("getCouponInfo/" + couponType +"/" + pid, function(data){
                    if(data.point != "-1"){
                        point = data.point;
                        max = Math.floor(point/couponType);
                        if(max > 0){
                            $("#couponTable").show();
                            msg.remove();
                        }
                        else{
                            msg.html("点数不足");
                        }
                        refresh();
                    }
                    else{
                        msg.html(data.msg);
                    }
                },{method:"GET"});

                /*绑定控制*/
                var control = couponAmount.siblings("span").children(),
                        inc = $(control[0]),
                        dec = $(control[1]),
                /* 数据 */
                        actionFlag = false,//可操作
                        point = 0,
                        max = 0,
                        amount = 1,
                        baseUrl = "getCoupon",
                        finalUrl = "";

                inc.click(function(){
                    if(amount >= max) return;
                    amount ++;
                    refresh();
                });
                dec.click(function(){
                    amount - 1 > 0 ? amount -- : "";
                    refresh();
                });
                couponAmount.bind("blur",function(e){
                    var _amount = parseInt(couponAmount.val());
                    if(isNaN(_amount) || _amount < 1);
                    else{
                        if(_amount <= max) amount = _amount;
                    }
                    refresh();
                });

                function actionFilter(actionName, handler){
                    if(actionFlag){
                        return handler();
                    }
                }

                function refresh(){
                    couponPoint.html(point);
                    storeName.text(placeName);
                    couponValue.html(couponType);
                    couponAmount.val(amount);
                    finalUrl = baseUrl + "/" + couponType + "/" + pid + "/" + amount;
                    link.attr("href", finalUrl);
                }
            });

        </script>
    </div>
</textarea>
</body>
</html>