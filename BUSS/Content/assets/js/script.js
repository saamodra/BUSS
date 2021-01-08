$(window).scroll(function(){
  var sticky = $('.fixed-top'),
      scroll = $(window).scrollTop(),
      windowWidth = $(window).width();

  if(!$('body').hasClass('page-blog')) {
    if(windowWidth > 992) {
      if(scroll >= 100) {
        sticky.removeClass('navbar-dark').addClass('nav-sticky navbar-light')
      } else {
        sticky.removeClass('nav-sticky navbar-light').addClass('navbar-dark');
      }
    }
  }
});

$(document).ready(function() {
  var sticky = $('.fixed-top'),
      windowWidth = $(window).width();

  if(windowWidth <= 992) {
    sticky.removeClass('navbar-dark');
    sticky.addClass('nav-sticky navbar-light');
  }
})

// $('.nav-item-2').click(function() {
//   $('body').animate({
//       scrollTop: $('#' + $(this).attr('target')).offset().top
//   }, 1000);

//   console.log('asd')
// });

// $('.nav-item-2, .footer-menu').on('click', function (e) {
//   e.preventDefault();
//   var to = $(this).attr('href');

//   if(to == '#home') {
//     $('html, body').animate({
//       scrollTop: 0
//     }, 1000);

//   } else {

//     $('html, body').animate({
//       scrollTop: eval($(to).offset().top )
//     }, 700);
//   }
// });