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
    if(window.console && window.console.log)
        window.console.log(data);
};
function warn(data){
    if(window.console && window.console.warn)
        window.console.warn(data);
};
function err(data){
    if(window.console && window.console.error)
        window.console.error(data);
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

function find(array, target){
    if(array && target){
        for(var i in array){
            if(target === array[i].id) return i;
        }
        return -1;
    }
    return -1;
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

    var cookieStr = $.cookie("order"),
        orderRegExp = /^(\d+:\d+,)*(\d+:\d+)$/g,
        cookie = null,
        order = [];
    if(cookieStr == null){
        log("订单不存在。");
    }
    else if(!cookieStr.match(orderRegExp)){
        err("解析cookie时发生错误！订单将被重置。");
    }
    else{
        cookie = cookieStr.split(",");
        for(var i = 0; i < cookie.length; i++){
            try{
                var aOrder = cookie[i].split(":");
                order.push({id:parseInt(aOrder[0]), amount:parseInt(aOrder[1])});
            }catch(e){
                err("填充order时，出现：" + e.name)
            }
        }
    }

    $(".order").click(function(){
        //何奕勇修改处开始
        if(!orderTip()){
            return;
        }
        //何奕勇修改处结束
        var $this = $(this),
            fid = parseInt($this.attr("fid")),
            index;
        if((index = find(order, fid)) >= 0){
            order[index].amount++;
        }
        else{
            order.push({id:fid, amount:1});
        }

        /*重新设置cookie*/
        var cookieStr = "";
        for(var i = 0; i < order.length; i++){
            if(i == 0)
                cookieStr += (order[i].id + ":" + order[i].amount);
            else
                cookieStr += ("," + order[i].id + ":" + order[i].amount);
        }

        log(cookieStr)

        $.cookie("order", cookieStr , {expires:7, path: "/", secure: false});

        var parent = $this.parent().parent().parent().parent().parent(),
            fake = parent.clone(),
            l = parent.offset().left,
            t = parent.offset().top,
            w = parent.width(),
            h = parent.height();
        fake.css("position", "absolute").css("left", l + "px").css("top", t + "px").width(w).height(h);
        $("body").append(fake);
        fake.animate({top:t - 100, opacity:0}, 500, function(){
            fake.remove();
        })
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

    if(point){
        $("head").append("<script type=\"text/javascript\" src=\"js/personal.js\"></script>");
    }


});