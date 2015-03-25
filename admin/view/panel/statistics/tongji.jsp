<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 14-3-12
  Time: 上午10:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- CSS goes in the document HEAD or added to your external stylesheet -->

<style type="text/css">

    table.place2ImgTable {

        font-family: verdana, arial, sans-serif;

        font-size: 11px;

        color: #333333;

        border-width: 1px;

        border-color: #666666;

        border-collapse: collapse;

    }

    table.place2ImgTable th {
        text-align: center;

        border-width: 1px;

        padding: 8px;

        border-style: solid;

        border-color: #666666;

        background-color: #dedede;

    }

    table.place2ImgTable td {

        border-width: 1px;

        padding: 8px;

        border-style: solid;

        border-color: #666666;

        background-color: #ffffff;

    }

    table.place2ImgTable img {
        max-width: 330px;
        cursor: pointer
    }
</style>

<script type="text/javascript">
//    $(function(){
//        $.ajax({
//            url:"/admin/place/addPlace2Img",
//            type:"get",
//            data:{"url":imgUrl,"pid":pid},
//            success:function(data) {
//
//            }
//        });
//    });
</script>

<%--图片区域--%>
<table id="place2ImgTable" class="place2ImgTable">
    <tr>
        <th>图片</th>
    </tr>
</table>

