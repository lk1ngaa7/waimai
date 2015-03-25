<%@ page import="java.io.File" contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="net.sf.json.JSONSerializer" %>
<%@ page import="utilities.file.entities.*" %>
<%!
    String dir = null;

    HashMap<Integer, Folder> folderData = new HashMap<Integer, Folder>();            //json对象们
    HashMap<Integer, File> fileData = new HashMap<Integer, File>();                 //File对象们
    int fid = 0;                                                                     //起始文件夹id

    void initFolderObject(Folder folder){                                            //添加文件夹内容
        File[] fileArray = fileData.get(folder.getId()).listFiles();
        ArrayList<_Folder> folders = new ArrayList<_Folder>();
        ArrayList<_File> fs = new ArrayList<_File>();
        for(int i = 0; i < fileArray.length; i++){
            if(fileArray[i].isDirectory()) {
                _Folder temFolder = new _Folder(fid++, fileArray[i].getName());
                folders.add(temFolder);                                               //添加仅包含id与name的文件夹列表
                fileData.put(temFolder.getId(), fileArray[i]);                       //储存File对象
                folderData.put(temFolder.getId(), new Folder(temFolder.getId(), fileArray[i].getName()));   //包含内容的文件夹
            }
            else if(fileArray[i].isFile()){                                          //添加文件列表
                fs.add(new _File(fileArray[i].getName(), fileArray[i].getAbsolutePath().replace(dir,"").replace("\\", "/")));
            }
        }
        folder.setFolders(folders);
        folder.setFs(fs);
    }
%>
<%
    if(folderData.get(0) == null){                       //第一次访问初始化根目录
        dir = application.getRealPath("/");
        File f = new File(dir);
        fileData.put(0, f);
        Folder folder = new Folder(fid++, f.getName());
        initFolderObject(folder);
        folderData.put(folder.getId(), folder);
    }
    String idStr = request.getParameter("fId");
    if(idStr != null){
        String jsonStr = "[]";
        try {
            int id = Integer.parseInt(request.getParameter("fId"));
            if (folderData.get(id) != null){
                if (folderData.get(id).getFolders() == null) initFolderObject(folderData.get(id));
                jsonStr = JSONSerializer.toJSON(folderData.get(id)).toString();
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        response.setContentType("application/json;charset=utf-8");
        response.getWriter().write(jsonStr);
        response.getWriter().flush();
        response.getWriter().close();
    }
%>
<!Doctype html>
<html>
<head>
    <title>file</title>
    <style type="text/css">
        html{ scrollbar-base-color: #111;/*bar_bg*/ scrollbar-shadow-color: #2bb1af;/*border*/ scrollbar-arrow-color: #2bb1af;/*arrow*/ scrollbar-track-color: #111;/*bg*/ }
        body{ margin: 0px; padding: 10px; background: #111; font-family:'times new roman';-moz-user-select:none;-webkit-user-select:none; }
        .clear{ clear:both; height:0px; line-height:0px; font-size:0px; visibility:hidden; overflow:hidden }
        #frame{border: 0px solid #2bb1af; padding: 10px; overflow: hidden}
        .folderContent { border:1px solid #2bb1af; float:left; display:none; margin: 8px; }
        .folderContent > div{padding: 10px}
        .file,.folderTitle { color: #999; cursor:pointer; font-size: 14px; text-decoration: none }
        .folderTitle{ font-size: 16px; float: left; font-weight: bold; color: #2bb1af }
        .file:hover{ text-decoration: underline }
        .html{ color: #1ba053; }
        .jsp{ color: #d47b25; }
        .css{ color: #1ba053; }
        .js{ color: #1ba053; }
    </style>
    <script type="text/javascript" src="js/jq181.js"></script>
    <script type="text/javascript">
        $(function(){
            var data  =  <%= JSONSerializer.toJSON(folderData.get(0))%>;
            fill($("#frame"), data);
        });

        function fill(obj, data){
            var f = obj;
            for(var i = 0; i < data.folders.length; i++){
                var folder = $("<div class='folder'></div>"),
                        folderTitle =  $("<span class='folderTitle' fId='" + data.folders[i].id + "'>[" + data.folders[i].name + "]</span>"),
                        folderContent = $("<div class='folderContent'><div></div></div>"),
                        clear = $("<div class='clear'></div>");
                folder.append(folderTitle);
                folder.append(folderContent);
                folder.append(clear);
                bindFolder(folderTitle);
                f.append(folder);
            }
            for(var i = 0; i < data.fs.length; i++){
                if(data.fs[i].name.lastIndexOf(".") === -1){
                    f.append("<a class='file' href='" + data.fs[i].url + "'>" + data.fs[i].name + "</a><br/>")
                }
                else{
                    var indexOfPoint = data.fs[i].name.lastIndexOf("."),
                        length = data.fs[i].name.length,
                        type = data.fs[i].name.substring(indexOfPoint + 1, length);
                    f.append("<a class='file' href='" + data.fs[i].url + "'>" + data.fs[i].name.substring(0, indexOfPoint) + "<span class='" + type +"'>." + type + "</span>" + "</a><br/>")
                }
            }
        }

        function bindFolder(obj) {
            obj.toggle(function() {
                obj.next("div").fadeIn("fast");
                if(!obj.attr("loaded")){
                    loadData(location.href + "?fId=" + obj.attr("fId"), function(data){
                        fill(obj.next("div").find("> div") , data);
                        obj.attr("loaded", "true")
                    });
                }
            },function() {
                obj.next("div").fadeOut("fast");
            })
        }
        function loadData(url,call_back,data){
            jQuery.ajax({
                type:(data && data.method) ? data.method : 'GET',
                url:url,
                data:(data && data.data)?data.data:null,
                dataType:(data && data.dataType)?data.dataType:'json',
                cache:false,
                timeout:60000,
                beforeSend:function (XMLHttpRequest) {
                },
                success:function (data) {
                    if(call_back)call_back(data);
                },
                complete:function (XMLHttpRequest, textStatus) {
                },
                error:function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("网络发生错误！");
                    if(call_back)call_back(null);
                }
            });
        }
    </script>
</head>
<body unselectable="on" onselectstart="return false;">
<div id="frame"></div>
</body>
</html>