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

function find(array, target){
    if(array && target){
        for(var i in array){
            if(target === array[i].id) return i;
        }
        return -1;
    }
    return -1;
}


$(document).ready(function(){

    var orderInput = $(".amount> input"),
        order = [];

    for(var i = 0; i < orderInput.length; i++){
        +function(i){
            /*填充order[]*/
            var $input = $(orderInput[i]),
                del = $input.parent().siblings(".delete"),
                tr = del.parent().parent().parent();
            try{
                order.push({id:parseInt($input.attr("fid")), amount:parseInt($input.val()), price:parseFloat($input.attr("price")), foodType:parseFloat($input.attr("foodType"))});
            }catch(e){
                err("填充order时，出现：" + e.name)
            }
            /*绑定控制*/
            var control = $input.siblings("span").children(),
                inc = $(control[0]),
                dec = $(control[1]),
                index = find(order, parseInt($input.attr("fid"))),
                amountData = order[index];

            inc.click(function(){
                if(index != -1){
                    amountData.amount ++;
                    $input.val(amountData.amount);
                    doAction();
                }
            });
            dec.click(function(){
                if(index != -1){
                    amountData.amount - 1 > 0 ? amountData.amount -- : "";
                    $input.val(amountData.amount);
                    doAction();
                }
            });
            $input.bind("blur",function(e){
                var amount = parseInt($input.val());
                if(isNaN(amount) || amount < 1) $input.val(amountData.amount);
                else{
                    amountData.amount = amount;
                    $input.val(amount);
                    doAction();
                }
            });
            tr.hover(function(){
                del.css("display", "inline-block");
            }, function(){
                del.hide();
            });
            del.click(function(){
                if(confirm("确认删除？")){
                    tr.fadeOut(300, tr.remove);
                    order.splice(index, 1);
                    doAction();
                }
            });
        }(i)
    }

    setPrice();

    function doAction(){
        setCookieStr();
        setPrice();
    }

    function setPrice(){
        var foodPrice = 0, packPrice = 0, totalAmount = 0;//, barbecueAmount = 0;
        for(var i = 0; i < order.length; i++){
            for(var j = 0; j < order[i].amount; j++){
                totalAmount ++;
                foodPrice += (order[i].price);
                packPrice += (totalAmount > 5 ? 1 : 1.50);
//                if(order[i].foodType == 2) barbecueAmount ++;
            }
        }
        if (order.length>0 && order[0].foodType == 2) {
            packPrice = (parseInt(foodPrice/10)+1)*2;
        }
        $("#foodPrice").html("￥" + (foodPrice + packPrice).toFixed(2));
        $("#packPrice").html("￥" + packPrice.toFixed(2));
    }

    function setCookieStr(){
        /*重新设置cookie*/
        var cookieStr = "";
        for(var i = 0; i < order.length; i++){
            if(i == 0)
                cookieStr += (order[i].id + ":" + order[i].amount);
            else
                cookieStr += ("," + order[i].id + ":" + order[i].amount);
        }

        $.cookie("order", cookieStr , {expires:7, path: "/", secure: false});
    }

    String.prototype.trim = function(){
        return this.replace(/(^\s+)|(\s+$)/g,"");
    }
    var validate = {
        phone:{ok:false, regexp:/^\d{11}$/, info:"请输入手机号码(11位)", required:true}
    }
    $(".input").each(function(){
        var $obj = $(this),
            parent = $obj.parent(),
            fake = $("<span class='fake'></span>");

        blur(null ,$obj, fake)

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
            fake.text(validate[$obj.attr("name")].info);
        fake.bind("click", function(){
            fake.hide();
            $obj.show().focus();
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
            fake.css("display", "block");
        }
        else{
            $obj.show();
            fake.hide();
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
            return false;
        }
    }

});