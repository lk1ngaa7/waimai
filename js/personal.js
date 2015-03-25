function log(data){
    if(console)
        console.log(data);
};

$(document).ready(function(){
    $("#consumptionPoint > a").text(point);
    $("#coupon > a").text(couponAmount);

    $("head").append("<link rel=\"stylesheet\" type=\"text/css\" href=\"css/personal.css\">");


    var personalF = $(".personalF > div"),
        timer = null;

    $(".personalF").show().hover(function(){
        if(timer) clearTimeout(timer);
        personalF.addClass("hover");
    }, function(){
        timer = setTimeout(function(){
            personalF.removeClass("hover");
        },300);
    });
});