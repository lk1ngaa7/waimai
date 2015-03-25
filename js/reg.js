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

    /*验证*/
    var regUrl = "/doReg";

    String.prototype.trim = function(){
        return this.replace(/(^\s+)|(\s+$)/g,"");
    }
    var validate = {
        username:{ok:false, regexp:/^.{1,12}$/, info:"请输入昵称(1～12位)", required:true},
        password:{ok:false, regexp:/^\w{6,20}$/, info:"请输入密码(6～20)", required:true},
        repassword:{ok:false, info:"请重复密码", equalTo:"password", required:true},
        birthday:{ok:true, regexp:/^\d{4}\/\d{1,2}\/\d{1,2}$/, info:"您的生日(yyyy/mm/dd) 可为空"},
        phone:{ok:false, regexp:/^\d{11}$/, info:"请输入手机号码(11位)", required:true},
        address:{ok:true}
    }
    $("#regF > div > input").each(function(){
        var $obj = $(this),
            parent = $obj.parent(),
            fake = $("<input class='fake'>");

        $obj.bind("focus",function(e){
            focus(e, $obj);
        }).bind("propertychange",function(e){
            input(e, $obj);
        }).bind("input",function(e){
            input(e, $obj);
        }).bind("paste",function(e){
            input(e, $obj);
        }).bind("cut",function(e){
            input(e, $obj);
        }).bind("blur",function(e){
            blur(e, $obj, fake);
        });

        parent.append(fake);
        if(validate[$obj.attr("name")].info)
            fake.val(validate[$obj.attr("name")].info);
        fake.bind("focus", function(){
            $obj.show().focus();
            fake.hide();
        });
    });

    $("#regF > div > select").bind("change", function(){
        var $obj = $(this),
            flag = true;
        if(validate[$obj.attr("name")].not && validate[$obj.attr("name")].not === $obj.find('option:selected').index())
            flag = false;
        validate[$obj.attr("name")].ok = flag;
    });

    $("#submit").bind("click", submit);

    function focus(e, $obj){
        cursorEnd($obj);
    }
    function blur(e ,$obj, fake){
        $obj.val($obj.val().trim());
        if( !input(e, $obj)){
            $obj.hide();
            fake.show();
        }
    }
    function input(e, $obj){
        var val = $obj.val(),
            flag = true;
        if(validate[$obj.attr("name")] && (validate[$obj.attr("name")].required || (val !== "" && !validate[$obj.attr("name")].required))){
            if(validate[$obj.attr("name")].min) {
                if(validate[$obj.attr("name")].min > val.length) flag = false;
            }
            if(validate[$obj.attr("name")].max) {
                if(validate[$obj.attr("name")].max < val.length) flag = false;
            }
            if(validate[$obj.attr("name")].regexp) {
                if(!val.match(validate[$obj.attr("name")].regexp)) flag = false;
            }
            if(validate[$obj.attr("name")].equalTo){
                if($("#" + validate[$obj.attr("name")].equalTo).val() !== val) flag = false;
            }
        }
        validate[$obj.attr("name")].ok = flag;
        return flag;
    }

    function cursorEnd($obj){
        if($obj[0].createTextRange){
            var a =$obj[0].createTextRange();
            a.moveStart('character',$obj[0].value.length);
            a.collapse(true);
            a.select();
        }
    }

    function submit(){
        var flag = true;
        for(var i in validate){
            if(!validate[i].ok) flag = false;
        }
        if(!flag){
            alert("对不起，您输入的信息有误，请检查表单文字的提示！");
            return false;
        }
    }
});