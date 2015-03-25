(function(window){
    /*resize分发器*/
    var resizeDispatcher = function(){
        var win = $(window);
        var listeners = [],
            data = {w:win.width(),h:win.height()};
        win.bind("resize",function(){
            data = {w:win.width(),h:win.height()};
            dispatch(data);
        });
        function dispatch(data){
            for(var i in listeners){
                if(listeners[i]&&listeners[i].active)
                    if(listeners[i].handler) listeners[i].handler(data);
            }
        }
        function add(data){
            listeners.push(data);
        }
        function getData(){
            return data;
        }
        return {add:add,getData:getData};
    }();

    function getUniqueId(length){                            /*注意：如果范围太小将死循环*/
        var id = "L"+random(length);
        while(find(id,ids))
            id = random(length);
        ids.push(id);
        return id;
    }
    function find(value,target){
        for(var i in target){
            if(target[i] == value)
                return true;
        }
        return false;
    }
    function random(length){
        var min = Math.pow(10,length - 1),
            max = min*10 - 1,
            result = Math.round(min + Math.random()*(max - min));
        return result;
    }

    window.resizeDispatcher = resizeDispatcher;window.getUniqueId = getUniqueId;
})(window);

function log(data){
    if(console)
        console.log(data);
};

function visible(obj,visible,duration,callback){
    if(visible)
        if($.support.opacity) {
            obj.stop().fadeIn(duration,callback);
        }
        else{
            obj.show();
            if(callback) callback();
        }
    else
    if($.support.opacity) {
        obj.stop().fadeOut(duration,callback);
    }
    else{
        obj.hide();
        if(callback) callback();
    }
}

function btnEffect(obj){
    var offsetH = obj.height();
    return obj.bind("mouseout",function(){
        $(this).css("background-position-y","0px");
    }).bind("mousedown",function(){
            $(this).css("background-position-y",-offsetH+"px");
    }).bind("mouseup",function(){
        $(this).css("background-position-y","0px");
    });
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

function find(pattern,target){
     if(pattern && target){
         for(var i in target){
             if(typeof target[i] == "object") {
                 if(target[i].id == pattern) return target[i].name;
             }
             else{
                 if(target[i] == pattern) return true;
             }
         }
     }
}

function merge(data){
    var arr = [];
     for(var i = 0; i < data.length; i++){
         for(var j = 0, _arr = data[i]; j < _arr.length; j++)
            arr.push(_arr[j]);
     }
    return arr;
}


$(document).ready(function(){
    var imgF = $("#pics");
    imgF.height(imgF.width()/4*3);
    resizeDispatcher.add({active:true, handler:function(){
        imgF.height(imgF.width()/4*3);
    }});

    var imgs = $("#pics > img"), current_pic = 0;
    for(var i = 0, pic_info = []; i < imgs.length; i++){
        pic_info.push([imgs[i].src, imgs[i].title, imgs[i].getAttribute("url")]);
    }

    for(var i  = 0; i < imgs.length;i++){//添加图片块
        +function(index){
            $(imgs[i]).click(function(){
                pic_info[index][2] ? location.href = pic_info[index][2] : 0;
            });
        }(i);
    }

    var tem = "<div class='controlF'>";//添加控制
    for(var i  = 0;i<pic_info.length;i++){
        var tem2 ="<div class='controls" + (i==0?" controlSelected":"") + "' cid = '"+i+"' "+"></div>"
        tem += tem2;
    }
    tem += "</div>";
    $("#pics").append(tem);


    $(".controlF").hover(pausePlay, autoPlay);

    $(".controls").each(function(){//绑定控制
        $(this).bind("click",function(){
            if(current_pic==$(this).attr("cid")) return;
            current_pic=$(this).attr("cid");
            change_pic(current_pic);
        });
    });

    $($(".controls")[0]).css("background-position","0px 0px");

    var controls = $(".controls");

    function change_pic(cid){// 切换图片
        for(var i = 0; i < imgs.length; i++){
            if(cid == i)  $(imgs[i]).fadeIn(500);
            else  $(imgs[i]).fadeOut(500);
        }

        controls.removeClass("controlSelected");
        $(controls[cid]).addClass("controlSelected");
    }

    var intervalPlay = function(){
        if(current_pic == pic_info.length - 1) current_pic = -1;
        change_pic(++current_pic);
        },
        interval = null;

    autoPlay();

    function autoPlay(){
        if(pic_info.length == 1) return;
        interval = setInterval(intervalPlay, 5000)
    }

    function pausePlay(){
        clearInterval(interval);
    }

    $("#commentStarLevel, #commentStarSpeed").bind("mousemove", function(event){
        var $this = $(this),
            width = $this.width(),
            step = width/5,
            tem = event.clientX + $(document).scrollLeft() - $this.offset().left,
            currentStar = 1;
            if(tem > 4*step) currentStar = 5;
            else if(tem > 3*step) currentStar = 4;
            else if(tem > 2*step) currentStar = 3;
            else if(tem > 1*step) currentStar = 2;
            else currentStar = 1;

            this.className = "commentStar" + currentStar;
    });


    $(".commentInput").bind("propertychange",function(e){
        step2(e,this);
    }).bind("input",function(e){
            step2(e,this);
    }).bind("paste",function(e){
        step2(e,this);
    }).bind("cut",function(e){
        step2(e,this);
    }).bind("blur",function(e){
        step1(e,this);
    });

    var validatePattern = {comment:{lengthMin:3, lengthMax:300, regExp:null}}, validate = {comment:false};

    $("#commentSubmit").bind("click",do_upload);

    String.prototype.trim = function(){
        return this.replace(/(^\s+)|(\s+$)/g,"");
    }

    function step1(e,obj){
        var $obj = $(obj);
        var val = $obj.val();
        var trim_str = val.trim();
        if(val.length > trim_str.length) $obj.val(trim_str);
        step2(e,$obj,true);
    }

    function step2(e,obj,blur){
        var $obj = $(obj);
        var val = $obj.val();
        if($obj.hasClass("commentInput")&&$obj.attr("id")!="forCountHeight"){
            var tmp = $("#forCountHeight");
            tmp.val($obj.val());
            $obj.css("height",tmp[0].scrollHeight < 80 ? "80px" : tmp[0].scrollHeight > 150 ? "150px" : tmp[0].scrollHeight+"px");
            if(val.length >= validatePattern.comment.lengthMin && val.length <= validatePattern.comment.lengthMax){
                validate.comment = true;
                if(blur){
                    $(".inputTip").hide();
                }
                else{
                    $(".inputTip").show();
                    $(".inputTip").html("还可以输入<span>" + (validatePattern.comment.lengthMax - val.length) + "</span>字");
                }
            }
            else{
                validate.comment = false;
                $(".inputTip").html("长度在<span>3~300</span>之间");
            }
        }
    }

    function emu_form_input(data){
        if($($(".name_input")[0]).val()  == "")
            $($(".name_input")[0]).val(data);
    }
    function validate_all(){
        with (validate){
            return comment;
        }
    }
    function do_upload(){
        if(!validate_all()){
            return false;
        }
        $("#inputCommentStarLevel").val($("#commentStarLevel")[0].className);
        $("#inputCommentStarSpeed").val($("#commentStarSpeed")[0].className)
    }

});