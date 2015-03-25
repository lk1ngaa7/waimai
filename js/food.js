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


});