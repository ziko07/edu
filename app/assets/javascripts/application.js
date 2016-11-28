// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

function popupMessage(message, klass) {
    var notificationTop = "+" + ($(document).scrollTop() + 60);
    var notification = $('#notification');
    notification.find('.notification-content').html(message);
    notification.addClass(klass).show().animate({
        top: notificationTop
    }, 200);
    setTimeout(function () {
        if (!notification.hasClass('alert-danger')) {
            notification.hide().animate({
                top: "-60"
            }, 500);
        }
    }, 4000);
}

$(function () {
    $(".dropdown").hover(
        function () {
            $('.dropdown-menu', this).stop(true, true).fadeIn("fast");
            $(this).toggleClass('open');
        },
        function () {
            $('.dropdown-menu', this).stop(true, true).fadeOut("fast");
            $(this).toggleClass('open');
        }
    );

    $('.force-close-notification').click(function () {
        $(this).parent().hide().animate({
            top: "-60"
        }, 500);
    });
});

$(document).ajaxStart(function () {
    startLoader();
});

$(document).ajaxComplete(function () {
    stopLoader();
});

function startLoader() {
    $('body').append("<div class='loading'> <i class='fa fa-spinner fa-spin'></i> </div>");
}

function stopLoader() {
    $(".loading").remove();
}