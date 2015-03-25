function log(data){
    if(console)
        console.log(data);
};

$(document).ready(function(){
    $("#content > a").bind("mouseover",function(){
        $(this).removeClass("animationClear");
        $(this).addClass("animationUpDown");
    }).bind("mouseout",function(){
        var $this = $(this);
            //$this.addClass("animationPause");

            $this.removeClass("animationUpDown");
            $this.addClass("animationClear");

            setTimeout(function(){
        },500);
    });
});