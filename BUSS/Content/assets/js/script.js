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

$('body').on('keypress', 'input[type=number][maxlength]', function (event) {
    var key = event.keyCode || event.charCode;
    var charcodestring = String.fromCharCode(event.which);
    var txtVal = $(this).val();
    var maxlength = $(this).attr('maxlength');
    var regex = new RegExp('^[0-9]+$');
    // 8 = backspace 46 = Del 13 = Enter 39 = Left 37 = right Tab = 9
    if (key == 8 || key == 46 || key == 13 || key == 37 || key == 39 || key == 9) {
        return true;
    }
    // maxlength allready reached
    if (txtVal.length == maxlength) {
        event.preventDefault();
        return false;
    }
    // pressed key have to be a number
    if (!regex.test(charcodestring)) {
        event.preventDefault();
        return false;
    }
    return true;
});

$('body').on('paste', 'input[type=number][maxlength]', function (event) {
    //catch copy and paste
    var ref = $(this);
    var regex = new RegExp('^[0-9]+$');
    var maxlength = ref.attr('maxlength');
    var clipboardData = event.originalEvent.clipboardData.getData('text');
    var txtVal = ref.val();//current value
    var filteredString = '';
    var combined_input = txtVal + clipboardData;//dont forget old data

    for (var i = 0; i < combined_input.length; i++) {
        if (filteredString.length < maxlength) {
            if (regex.test(combined_input[i])) {
                filteredString += combined_input[i];
            }
        }
    }
    setTimeout(function () {
        ref.val('').val(filteredString)
    }, 100);
});