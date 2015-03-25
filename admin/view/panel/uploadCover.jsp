<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<form action="/admin/uploadCover2"
      encType="multipart/form-data" method="post" target="hidden_frame">
    <label for="file">请选择文件：</label>
    <input type="file" id="place2ImgFile" name="file" id="file"/> <br/>
    <input type="submit" onclick="watchuploadStatus()" value="点击上传"/>
    <input type="hidden" name="pid" value="${pid}">
    <div id="place2UploadSuccessTip"></div>
</form>

<script type="text/javascript">
    function watchuploadStatus() {
        $("#place2UploadSuccessTip").html("<font color='blue'>正在上传...请耐心等候结果再关闭窗口。</font>");
    }
</script>
