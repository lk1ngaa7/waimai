<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true"%><!DOCTYPE html>
<html>
<head>
    <style>
        body {
            margin: 0em; color: rgb(87, 87, 87); font-family: "Microsoft YaHei", "verdana", "arial"; background-repeat: repeat-x; background-color: white;
        }
        .mainContent {
            width: 700px; margin-top: 80px; margin-right: 120px; margin-left: 120px;
        }
        .title {
            color: rgb(39, 120, 236); font-family: "Microsoft YaHei Light", "Microsoft YaHei", "verdana"; font-size: 38pt; font-weight: 300; margin-bottom: 20px; vertical-align: bottom; position: relative;
        }
        .errorExplanation {
            color: rgb(0, 0, 0); font-family: "Microsoft YaHei", "verdana", "arial"; font-size: 12pt; text-decoration: none;
        }
        .taskSection {
            margin-top: 20px; margin-bottom: 40px; position: relative;
        }
        .tasks {
            color: rgb(0, 0, 0); padding-top: 5px; font-family: "Microsoft YaHei Light", "Microsoft YaHei", "verdana"; font-size: 12pt; font-weight: 200; margin-left: -25px;
        }
        li {
            margin-top: 8px;
        }
        .diagnoseButton {
            font-size: 9pt;
        }
        .webpageURL {
            direction: ltr;color: rgb(0, 102, 204)
        }
        .hidden {
            display: none;
        }
        a {
            color: rgb(0, 102, 204); font-family: "Microsoft YaHei", "verdana", "arial"; font-size: 11pt; text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>无法显示此页</title>
</head>
<body>
<div id="contentContainer" class ="mainContent">
    <div id="mainTitle" class="title"><%
        Integer code = (Integer)request.getAttribute("javax.servlet.error.status_code");
        if(code==null)
            out.write("禁止访问");
        else if(code==404){
            response.setStatus(404);
            out.write("无法显示此页");
        }
        else if(code==500)
            out.write("服务器错误");
        else
            out.write("无效的访问");
    %></div>
    <div class="taskSection" id="taskSection">
        <ul id="cantDisplayTasks" class="tasks">
            <li id="task1-6">确保 Web 地址 <span id="webpage" class="webpageURL"><%= request.getAttribute("javax.servlet.error.request_uri") %></span> 正确。</li>
            <li id="task1-7">使用搜索引擎查找页面。</li>
            <li id="task1-8">请过几分钟后刷新页面。</li>
            <li id="task1-2">状态：<%= request.getAttribute("javax.servlet.error.status_code") %></li>
            <li id="task1-4">异常：<%= request.getAttribute("javax.servlet.error.exception")!=null? "<pre>" +((Exception) request.getAttribute("javax.servlet.error.exception")).getMessage().replace("<", "&lt;").replace(">", "&gt;") + "</pre>":null %></li>
            <li id="task1-5">来自：<%= request.getAttribute("javax.servlet.error.servlet_name") %></li>
        </ul>
    </div>
    <div><button id="diagnose" class="diagnoseButton" onclick="alert('你是傻逼么？')">修复连接问题</button></div>
</div>
</body>
</html>