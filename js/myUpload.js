var externalInterface = function(){

    var myUpload = function(){
        var initParam = {
            id:"uploadBtn",
            f_id:"upload",
            swf:"/swf/test.swf?refresh="+Math.random(),
            width:"22",
            height:"22"
        };

        var swfParam = {
            url:"/upload",                   //上传路径
            bg:"img/add2.png",               //按钮背景
            maxSize:1024e4                  //最大上传
        };

        var swfVersionStr = "9.0.0";
        var xiSwfUrlStr = "/swf/playerProductInstall.swf";
        var flashvars = {};
        var params = {
            quality:"high",
            bgcolor:"#ffffff",
            allowscriptaccess:"sameDomain",
            allowfullscreen:"false"
        };
        var attributes = {
            id:"myUploadInterface",
            name:"test"
        };
        var myUploadInterface;

        swfobject.embedSWF( initParam.swf, initParam.id, initParam.width,initParam.height, swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);

        function ready(){
            myUploadInterface = (navigator.appName.indexOf("Microsoft") !=-1?window:document).myUploadInterface;
            myUploadInterface.init(swfParam);
        }

        function before(param){
            $("#progress > div").width(0).html("").show();
        }

        function complete(){
            $("#progress > div").css("width","100%").html("完成");
            loadData("/doUpload",function(){
            },{method:"POST",data:{aid:album.aid}});
        }

        function progress(per){
            $("#progress > div").css("width",Math.round(100*per)+"%").html(Math.round(100*per)+"%");
        }

        function err(code){
            if(code==1) log("文件不能大于 "+swfParam.maxSize/1024/1024+" MB");
        }

        var obj = {};
        obj.ready = ready;
        obj.before = before;
        obj.complete = complete;
        obj.progress = progress;
        obj.err = err;

        return obj;
    }();

    return {myUpload:myUpload};
}();