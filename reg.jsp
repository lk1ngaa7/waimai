<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!Doctype html>
<html>
<head>
    <meta content="text/html" charset="utf-8">
    <title>注册 打嗝网</title>
    <meta name="keywords" content="打嗝网,快餐,送餐,学生生活服务平台,房屋租赁,日租,宾馆,商家展示"/>
    <meta name="description" content="打嗝网,快餐,送餐,学生生活服务平台,房屋租赁,日租,宾馆,商家展示" />
    <link rel="stylesheet" type="text/css" href="css/reg.css">
    <script type="text/javascript" src="js/jq181.js"></script>
    <script type="text/javascript" src="js/reg.js"></script>
</head>
<body>
<div id="wrapper">
    <div id="wrapperInner">
        <div id="content">
             <form id="regF" method="post" action="doReg">
                 <div><input name="username" autocomplete="off"></div>
                 <div><input id="password" name="password" type="password"></div>
                 <div><input name="repassword" type="password"></div>
                 <div><input name="birthday" autocomplete="off"></div>
                 <div><input name="phone" autocomplete="off"></div>
                 <div><select name="address">
                     <option value="">-- 请选择楼栋号 --</option>
                     <c:if test="${address != null}">
                         <c:forEach var="address" items="${address}" varStatus="status">
                             <option>${address.name}</option>
                         </c:forEach>
                     </c:if>
                 </select></div>
                 <span id="option">
                     <a href="/"></a><input type="submit" value="" id="submit">
                 </span>
             </form>
        </div>
    </div>
</div>
</body>
</html>