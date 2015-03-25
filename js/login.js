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
    $("#map span[position]").bind("mouseover", function(){
        $("#map span[dialogue]").show();
    }).bind("mouseout", function(){
        $("#map span[dialogue]").hide();
    });

    /*验证*/
    var regUrl = "/doReg";

    String.prototype.trim = function(){
        return this.replace(/(^\s+)|(\s+$)/g,"");
    }
    var validate = {
        username:{ok:false, regexp:/^\w{1,10}$/, info:"请输入您的用户名(1~10英文字母)"},
        password:{ok:false, regexp:/^\w{6}$/, info:"请输入您的密码(6位英文字母)"}
    }
    $(".input").bind("focus",function(e){
        step0(e, this);
    }).bind("propertychange",function(e){
        step2(e, this);
    }).bind("input",function(e){
        step2(e, this);
    }).bind("paste",function(e){
        step2(e, this);
    }).bind("cut",function(e){
        step2(e, this);
    }).bind("blur",function(e){
        step1(e, this);
    });
    $("#submit").bind("click", submit);

    function step0(e, obj){
        var $obj = $(obj);
        if(!$obj.attr("val") || $obj.attr("val") == ""){
            $obj.val("");
        }
        else{
            $obj.val($obj.attr("val"));
            cursorEnd(obj);
        }
    }
    function step1(e ,obj, blur){
        var $obj = $(obj);
        $obj.val($obj.val().trim());
        step2(e, obj, true);
        step3(e, obj);
    }
    function step2(e,obj,blur){
        var $obj = $(obj),
            val = $obj.val(),
            flag = true;
        if(blur) $obj.attr("val",val);
        if(validate[$obj.attr("name")]){
            if(validate[$obj.attr("name")].min) {
                if(validate[$obj.attr("name")].min > val.length){
                    flag = false;
                }
            }
            if(validate[$obj.attr("name")].max) {
                if(validate[$obj.attr("name")].max < val.length){
                    flag = false;
                }
            }
            if(validate[$obj.attr("name")].regexp) {
                if(!val.match(validate[$obj.attr("name")].regexp)){
                    flag = false;
                }
            }
        }
        validate[$obj.attr("name")].ok = flag;
    }
    function step3(e,obj){
        var $obj = $(obj);
        if(validate[$obj.attr("name")]){
           if(!validate[$obj.attr("name")].ok || $obj.val() == ""){
               if(validate[$obj.attr("name")].info)
                    $obj.val(validate[$obj.attr("name")].info);
           }
        }
        handler(obj, validate[$obj.attr("name")].ok)
    }
    function cursorEnd(obj){
        if(obj.createTextRange){
            var a =obj.createTextRange();
            a.moveStart('character',obj.value.length);
            a.collapse(true);
            a.select();
        }
    }

    function handler(obj, flag){
        var $obj = $(obj);
        if(flag) $obj.parent().removeAttr("err").attr("ok","");
        else $obj.parent().removeAttr("ok").attr("err","");
    }
    function submit(){
        var flag = true;
        for(var i in validate){
             if(!validate[i].ok) flag = false;
        }
        if(flag){
            $("form").submit();
        }
    }

});