$(document).ready(function(){
  $('#btn-next').on('click', function() {
    $('.form-1').animate({
      left: '-=100%',
      opacity: 0
    }, 'slow');
    $('.form-2').animate({
      left: 0,
      opacity: 1
    }, 'slow');

    $('p.reg-footer').css({
      marginTop: '83px'
    });
  });

  $('#btn-back').on('click', function() {
    $('.form-1').animate({
      left: 0,
      opacity: 1
    }, 'slow');
    $('.form-2').animate({
      left: '+=100%',
      opacity: 0
    }, 'slow');
    $('p.reg-footer').css({
      marginTop: '0px'
    });
  });
});