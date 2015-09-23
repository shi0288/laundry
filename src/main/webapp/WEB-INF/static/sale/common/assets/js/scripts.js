

window.alert = function (mes, onClick) {
    var html = '<div class="cover3"></div><div id="alert"><div class="alert-title">提示</div><div class="alert-message">' + mes + '</div><div class="alert-ok">确定</div></div>';
    $("body").eq(0).append(html);
    var iheight = $(document).height();
    if ($(window).height() > $(document).height()) {
        iheight = $(window).height();
    }
    $(".cover3").height(iheight);
    var height = $("#alert").height();

    $("#alert").css({'margin-top': -height / 2});
    $("#alert .alert-ok").die().click(function () {
        closeAlert();
        if (onClick) {
            onClick();
        }
    });
};
function closeAlert() {
    $(".cover3").remove();
    $("#alert").remove();
}

jQuery(document).ready(function() {

    $('.page-container form').submit(function(){
        var username = $(this).find('.username').val();
        var password = $(this).find('.password').val();
        if(username == '') {
            $(this).find('.error').fadeOut('fast', function(){
                $(this).css('top', '27px');
            });
            $(this).find('.error').fadeIn('fast', function(){
                $(this).parent().find('.username').focus();
            });
            return false;
        }

        if(password == '') {
            $(this).find('.error').fadeOut('fast', function(){
                $(this).css('top', '96px');
            });
            $(this).find('.error').fadeIn('fast', function(){
                $(this).parent().find('.password').focus();
            });
            return false;
        }
    });

    $('.page-container form .username, .page-container form .password').keyup(function(){
        $(this).parent().find('.error').fadeOut('fast');
    });

});
